//
//  ProfileReducer.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct AboutCharacterProfileReducer {
    static func aboutCharacterProfileReducer(action: Action, state: AboutCharacterProfileState?) -> AboutCharacterProfileState {
        var state = state ?? AboutCharacterProfileState.initialUserProfileState()

        switch action {
        case let a as UserProfileActions.UserProfileAction:
            switch a {
            case .fetchUserProfile:
                state.fetchProfileOperationState = .fetching
            case let .setUserProfile(profile):
                state.userProfile = profile
            case let .updateRetrievalState(newState):
                state.fetchProfileOperationState = newState
            case .resetState:
                state = AboutCharacterProfileState.initialUserProfileState()
            case .resetOperationState:
                state.fetchProfileOperationState = .notFetched
                state.error = .none
                state.userProfile = nil
            }
        default: break
        }

        return state
    }
}
