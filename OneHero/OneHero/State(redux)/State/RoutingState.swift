//
//  RoutingState.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct RoutingState: Equatable {
    var navigationState: RoutingDestination
    var transitionType: SceneTransitionType
    var animationType: AnimationType
    var navigationBarVisible: Bool = false
    var currentViewId: RoutingDestination = .undefined
    var originatingViewId: RoutingDestination = .undefined

    init(navigationState: RoutingDestination = .home, transitionType: SceneTransitionType = .none, animationType: AnimationType = .standard) {
        self.navigationState = navigationState
        self.transitionType = transitionType
        self.animationType = animationType
    }

    static func == (lhs: RoutingState, rhs: RoutingState) -> Bool {
        return (lhs.navigationState.id == rhs.navigationState.id) && (lhs.transitionType == rhs.transitionType) && (lhs.animationType == rhs.animationType)
    }
}

struct MainViewState: Equatable {
    var menuTitle: String = ""
    var navigationBarVisible: Bool = false
}
