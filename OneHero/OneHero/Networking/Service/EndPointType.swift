//
//  EndPoint.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//
//  Created by Malcolm Kumwenda on 2018/03/05.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

/// Controls how stub responses are returned.
public enum StubBehavior {
    /// Do not stub.
    case never

    /// Return a response immediately.
    case immediate

    /// Return a response after a delay.
    case delayed(seconds: TimeInterval)
}

/// Used for stubbing responses.
public enum EndpointSampleResponse {
    /// The network returned a response, including status code and data.
    case networkResponse(Int, Data?)

    /// The network returned response which can be fully customized.
    case response(HTTPURLResponse?, Data?)

    /// The network failed to send the request, or failed to retrieve a response (eg a timeout).
    case networkError(NSError)
}

extension NetworkRouter {
    // Swift won't let us put the StubBehavior enum inside the provider class, so we'll
    // at least add some class functions to allow easy access to common stubbing closures.

    /// Do not stub.
    public final class func neverStub(_: EndPoint) -> StubBehavior {
        return .never
    }

    /// Return a response immediately.
    public final class func immediatelyStub(_: EndPoint) -> StubBehavior {
        return .immediate
    }

    /// Return a response after a delay.
    public final class func delayedStub(_ seconds: TimeInterval) -> (EndPoint) -> StubBehavior {
        return { _ in .delayed(seconds: seconds) }
    }
}

protocol EndPointType {
    typealias SampleResponseClosure = () -> EndpointSampleResponse

    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var sampleData: Data? { get }

    /// A closure responsible for returning an `EndpointSampleResponse`.
    var sampleResponseClosure: SampleResponseClosure? { get }
}

extension EndPointType {
    var sampleResponseClosure: SampleResponseClosure? {
        return { EndpointSampleResponse.networkResponse(200, self.sampleData) }
    }
}
