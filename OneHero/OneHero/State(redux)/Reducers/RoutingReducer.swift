//
//  RoutingReducer.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct RoutingReducer {
    static func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
        var state = state ?? RoutingState()

        switch action {
        case let routingAction as RoutingAction:
            state.navigationState = routingAction.destination
            state.transitionType = routingAction.transitionType
            state.animationType = routingAction.animationType
            state.currentViewId = routingAction.destination
        case _ as ResetRoutingAction:
            state.navigationState = .undefined
            state.transitionType = .none
            state.animationType = .standard
        case _ as NavigationBackAction:
            state.navigationState = .undefined
            state.animationType = .standard
            state.transitionType = .back
        case let currentVC as SetCurrentViewAction:
            state.currentViewId = currentVC.currentView
        default: break
        }

        return state
    }
}
