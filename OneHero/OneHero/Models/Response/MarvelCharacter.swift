//
//  MarvelCharacter.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation

public struct MarvelCharacter: Decodable, Equatable {
    public static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        return lhs.id == rhs.id &&
        (lhs.name == rhs.name) &&
        (lhs.description == rhs.description)
    }
    
    public let id: Int
    public let name: String?
    public let description: String?
    public let thumbnail: MarvelImage?
    public let urls: [MarvelURL]?
    
    public init(id: Int = 0, name: String? = nil, description: String? = nil, thumbnail: MarvelImage? = nil, urls: [MarvelURL]? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.urls = urls
    }
    
    func getUrlType(destType: MarvelURLDestTypes) -> String? {
        if let urls = urls {
            for marvelUrl in urls {
                if marvelUrl.type == destType.rawValue {
                    return marvelUrl.url
                }
            }
        }
        return nil
    }
}
