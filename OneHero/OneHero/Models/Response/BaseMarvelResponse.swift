//
//  BaseMarvelResponse.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation

public struct BaseMarvelResponse<Response: Decodable>: Decodable {
    public let status: String?
    public let message: String?
    public let data: MarvelData<Response>?
}
