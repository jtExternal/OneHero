//
//  Thumbnail.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation

public struct Thumbnail: Decodable {
    public let url: URL
    
    enum ImageKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        guard let url = URL(string: "\(path).\(fileExtension)") else { throw NetworkError.noData }
        self.url = url
    }
}
