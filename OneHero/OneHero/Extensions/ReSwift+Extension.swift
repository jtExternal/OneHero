//
//  ReSwift+Extension.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import ReSwift

extension Store {
    open func dispatchOnMain(_ action: Action) {
        DispatchQueue.main.async {
            self.dispatch(action)
        }
    }
}
