//
//  HTTPTask.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//
//  Created by Malcolm Kumwenda on 2018/03/05.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//
import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request

    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)

    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)

    // case download, upload...etc
}
