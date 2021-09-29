//
//  MarvelData.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation

public struct MarvelData<Results: Decodable>: Decodable {
    public let results: Results
    
    public init(offset: Int = 0, limit: Int = 0, total: Int = 0, count: Int = 0, results: Results) {
        self.results = results
    }
}
