//
//  PagingInde.swift
//  One Hero
//
//  Created by Justin Trantham on 9/29/21.
//

import Foundation

struct PagingIndex: Equatable {
    let start, end: Int
    init(start: Int, end: Int = Configuration.defaultPagingAmt) { self.start = start; self.end = end }
}
