//
//  AppReducer.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState.initialAppState()

    switch action {
    default:
        state = AppState(
            routingState: RoutingReducer.routingReducer(action: action, state: state.routingState),
            homeScreenState: HomeScreenReducer.homeScreenReducer(action: action, state: state.homeScreenState),
            mainViewState: mainReducer(action: action, state: state.mainViewState),
            marvelCharacterProfileState: AboutCharacterProfileReducer.aboutCharacterProfileReducer(action: action, state: state.marvelCharacterProfileState)
        )
    }

    return state
}

private func mainReducer(action: Action, state: MainViewState?) -> MainViewState {
    var state = state ?? MainViewState()

    switch action {
    case let act as SetMenuTitleAction:
        state.menuTitle = act.menuTitle
    default: break
    }

    return state
}
