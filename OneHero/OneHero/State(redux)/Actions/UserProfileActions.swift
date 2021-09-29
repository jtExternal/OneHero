//
//  UserProfileActions.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct UserProfileActions {
    enum UserProfileAction: Action {
        case resetState
        case fetchUserProfile
        case resetOperationState
        case updateRetrievalState(state: AboutCharacterProfileState.RetrievalState)
        case setUserProfile(profile: MarvelCharacter?)
    }
}

struct UserProfileActionCreators: HasDependencies {
    /// Fetch user profile from current session; create action
    ///
    /// - Returns: Action?
    func fetchUserProfile(state: AppState, store: Store<AppState>) -> Action? {
        store.dispatchOnMain(UserProfileActions.UserProfileAction.resetOperationState)
        let userProfileService = dependencies.resolveMarvelAPIService()
        store.dispatch(ResetRoutingAction())

        guard state.userProfileState.fetchProfileOperationState != .fetching, state.userProfileState.fetchProfileOperationState != .fetched else {
            return nil
        }

        store.dispatchOnMain(
            UserProfileActions.UserProfileAction.updateRetrievalState(state: .fetching)
        )
        
// TODO REPLACE
        userProfileService.getCharacter(id: "1011334") { result in
            
            switch result {
            case .failure:
                store.dispatch(UserProfileActions.UserProfileAction.updateRetrievalState(state: .failure))
            case let .success(value):
                switch value {
                case let .getCharacter(marvelCharacter):
                    store.dispatchOnMain(UserProfileActions.UserProfileAction.updateRetrievalState(state: .success))
                    store.dispatchOnMain(UserProfileActions.UserProfileAction.setUserProfile(profile: marvelCharacter))
                    store.dispatch(UserProfileActions.UserProfileAction.updateRetrievalState(state: .fetched))
                case .noResults:
                    store.dispatchOnMain(UserProfileActions.UserProfileAction.updateRetrievalState(state: .failure))
                    store.dispatch(UserProfileActions.UserProfileAction.updateRetrievalState(state: .noStoresFound))
                default:
                    break
                }
            }
        }

        return nil
    }
}
