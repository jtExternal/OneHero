//
//  MarvelApiRequest.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation

private let config = Configuration()

enum MarvelApiRequest {
    // GET /v1/public/characters
    case getCharacters(startIndex: Int, maxResults: Int)
    // GET /v1/public/characters/{characterId}
    case getCharacter(characterId: String)
    
    enum DictKeys: String {
        case ts
        case hash
        case apiKey = "apikey"
        case characterId
        case limit
        case offset
    }
}

extension MarvelApiRequest: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: config.environment.apiBaseUrl) else { fatalError("Base URL incorrect. API Base URL incorrect.") }
        return url
    }
    
    var path: String {
        switch self {
        case .getCharacters(_,_):
            return "characters"
        case let .getCharacter(characterId):
            return "characters/\(characterId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        let timeStamp = String(Date().toMilliseconds())
        let hash = timeStamp + config.environment.privateApiKey + config.environment.publicApiKey
        let md5Hash = hash.md5()
        
        
        switch self {
        case let .getCharacters(startIndex, maxResults):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .urlEncoding,
                                                urlParameters: [DictKeys.ts.rawValue: timeStamp,
                                                                DictKeys.hash.rawValue: md5Hash,
                                                                DictKeys.apiKey.rawValue: config.environment.publicApiKey,
                                                                DictKeys.offset.rawValue: startIndex,
                                                                DictKeys.limit.rawValue: maxResults],
                                                                additionHeaders: headers)
        default:
            return .request
        }
    }
    
    // swiftlint:disable line_length
    var headers: HTTPHeaders? {
        return ["Accept": "application/json",
                "Content-Type": "application/json"
        ]
    }
    
    var sampleData: Data? {
        switch self {
        case .getCharacter(_):
            return nil
        case .getCharacters:
            return nil
        }
    }
    
    var sampleResponseClosure: EndPointType.SampleResponseClosure? {
        return { EndpointSampleResponse.networkResponse(200, self.sampleData) }
    }
}
