//
//  RoutingAction.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct RoutingAction: Action {
    let destination: RoutingDestination
    let transitionType: SceneTransitionType
    let animationType: AnimationType

    init(destination: RoutingDestination, transitionType: SceneTransitionType = .none, animationType: AnimationType = .standard) {
        store.dispatch(ResetRoutingAction())
        self.destination = destination
        self.transitionType = transitionType
        self.animationType = animationType
    }
}

struct ResetRoutingAction: Action {}

struct SetCurrentViewAction: Action {
    let currentView: RoutingDestination
}
