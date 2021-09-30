//
//  MarvelURL.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation

enum MarvelURLDestTypes: String {
    case wiki
    case detail
    case comiclink
}

public struct MarvelURL: Decodable {
    let type: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
