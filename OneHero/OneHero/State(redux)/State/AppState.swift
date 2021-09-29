//
//  AppState.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct AppState {
    let routingState: RoutingState
    let homeScreenState: HomeScreenState
    let mainViewState: MainViewState
    let userProfileState: AboutCharacterProfileState

    static func initialAppState() -> AppState {
        return AppState(routingState: RoutingState(),
                        homeScreenState: HomeScreenState.initState(),
                        mainViewState: MainViewState(),
                        userProfileState: AboutCharacterProfileState.initialUserProfileState())
    }
}
