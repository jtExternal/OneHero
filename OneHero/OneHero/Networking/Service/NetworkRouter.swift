//
//  NetworkService.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//
//  Created by Malcolm Kumwenda on 2018/03/05.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation
import DataCache

enum Result<T> {
    case success(T)
    case failure(Error)

    var error: Error? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }

    var value: T? {
        switch self {
        case let .success(value): return value
        default: return nil
        }
    }
}

public final class OneHeroNetworkResponse: CustomDebugStringConvertible {
    /// A text description of the `Response`. Suitable for debugging.
    public var debugDescription: String {
        return description
    }

    /// A text description of the `Response`.
    public var description: String {
        return "Status Code: \(statusCode), Data Length: \(String(describing: data?.count))"
    }

    /// The status code of the response.
    public let statusCode: Int

    /// The response data.
    public let data: Data?

    /// The original URLRequest for the response.
    public let request: URLRequest?

    /// The HTTPURLResponse object.
    public let response: HTTPURLResponse?

    public init(statusCode: Int, data: Data?, request: URLRequest? = nil, response: HTTPURLResponse? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
}

enum NetworkResponse: String, Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

typealias NetworkRouterCompletion = (_ data: Data?, _ response: OneHeroNetworkResponse?, _ error: Error?) -> Void

protocol NetworkRouterProtocol: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class NetworkRouter<EndPoint: EndPointType>: NSObject, NetworkRouterProtocol {
    private var task: URLSessionTask?
    let config: Configuration

    /// Closure that decides if/how a request should be stubbed.
    public typealias StubClosure = (EndPoint) -> StubBehavior

    /// A closure responsible for determining the stubbing behavior
    /// of a request for a given `TargetType`.
    public let stubClosure: StubClosure

    /// Initializes a provider.
    public init(stubClosure: @escaping StubClosure = NetworkRouter.neverStub,
                config: Configuration = Configuration()) {
        self.stubClosure = stubClosure
        self.config = config
    }

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared

        do {
            let request = try buildRequest(from: route)
            NetworkLogger.log(request: request)
            let stubBehavior = stubClosure(route)

            switch stubBehavior {
            case .immediate:
                guard let sampleJson = route.sampleData else {
                    completion(nil, OneHeroNetworkResponse(statusCode: 0, data: nil, request: nil, response: nil), nil)
                    return
                }
                completion(sampleJson, OneHeroNetworkResponse(statusCode: 200, data: sampleJson, request: request, response: nil), nil)

            case .never:
                var uniqueCacheKey = ""
                var uniqueQueryParams = [String]()
                
                // Construct a unique cache key to store network data minus the auth query parameters
                if let urlString = request.url?.absoluteString {
                    if let urlPars = URLComponents(string: urlString) {
                        if let queryParams = urlPars.queryItems {
                            for val in queryParams {
                                if val.name != MarvelApiRequest.DictKeys.apiKey.rawValue &&
                                    val.name != MarvelApiRequest.DictKeys.hash.rawValue &&
                                    val.name != MarvelApiRequest.DictKeys.ts.rawValue {
                                    uniqueQueryParams.append("\(val.name):\(val.value ?? "")")
                                }
                            }
                        }
                        
                        uniqueCacheKey = "\(urlPars.path):\(uniqueQueryParams.joined())"
                    }
                }
                
                // Assuming no network connection present 1099
                if let data = DataCache.instance.readData(forKey: uniqueCacheKey) {
                    Log.d("Loading from cache with key \(uniqueCacheKey)")
                    completion(data, OneHeroNetworkResponse(statusCode: 200,
                                                        data: data,
                                                        request: request,
                                                        response: nil), nil)
                    return
                }
                
                task = session.dataTask(with: request, completionHandler: { data, response, error in
                    let returnedResponse = response as? HTTPURLResponse
                    
                    if returnedResponse != nil && data != nil && error == nil {
                        DataCache.instance.write(data: data!, forKey: uniqueCacheKey)
                    }
                    
                    completion(data, OneHeroNetworkResponse(statusCode: returnedResponse?.statusCode ?? 0,
                                                        data: data ?? Data(),
                                                        request: request,
                                                        response: returnedResponse), error)
                })

            case let .delayed(sec):
                guard let sampleJson = route.sampleData else {
                    completion(nil, OneHeroNetworkResponse(statusCode: 0, data: nil, request: nil, response: nil), nil)
                    return
                }
                let killTimeOffset = Int64(CDouble(sec) * CDouble(NSEC_PER_SEC))
                let killTime = DispatchTime.now() + Double(killTimeOffset) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: killTime) {
                    completion(sampleJson, OneHeroNetworkResponse(statusCode: 200, data: sampleJson, request: request, response: nil), nil)
                }
            }

        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }

    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 10.0)

        request.httpMethod = route.httpMethod.rawValue

        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case let .requestParameters(bodyParameters,
                                        bodyEncoding,
                                        urlParameters):

                try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: urlParameters,
                                        request: &request)

            case let .requestParametersAndHeaders(bodyParameters,
                                                  bodyEncoding,
                                                  urlParameters,
                                                  additionalHeaders):

                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: urlParameters,
                                        request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }

    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    func handleNetworkResponse(_ response: OneHeroNetworkResponse) -> Result<String> {
        switch response.statusCode {
        case 200 ... 299: return .success(NetworkResponse.success.rawValue)
        case 401 ... 500: return .failure(NetworkResponse.authenticationError)
        case 501 ... 599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
}
