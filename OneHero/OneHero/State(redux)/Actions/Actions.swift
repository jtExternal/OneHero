//
//  Actions.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct NavigationBackAction: Action {}

struct SetMenuTitleAction: Action {
    let menuTitle: String
}

/// Logout and reset all states; free memory
struct LogoutResetStates: Action {}
