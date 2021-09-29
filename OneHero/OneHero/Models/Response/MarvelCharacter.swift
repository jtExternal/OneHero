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
    public let thumbnail: Thumbnail?
    public let urls: [MarvelURL]?
    
    public init(id: Int = 0, name: String? = nil, description: String? = nil, thumbnail: Thumbnail? = nil, urls: [MarvelURL]? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.urls = urls
    }
}
