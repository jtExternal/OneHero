//
//  CharacterProfileActions.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct CharacterProfileActions {
    enum CharacterProfileAction: Action {
        case resetState
        case fetchUserProfile
        case resetOperationState
        case updateRetrievalState(state: AboutCharacterProfileState.RetrievalState)
        case setMarvelCharacterProfile(profile: MarvelCharacter?)
    }
}

struct CharacterProfileActionCreators: HasDependencies {
    func fetchUserProfile(state: AppState, store: Store<AppState>) -> Action? {
        store.dispatch(CharacterProfileActions.CharacterProfileAction.resetOperationState)
        let userProfileService = dependencies.resolveMarvelAPIService()
        store.dispatch(ResetRoutingAction())
        
        guard state.marvelCharacterProfileState.fetchProfileOperationState != .fetching, state.marvelCharacterProfileState.fetchProfileOperationState != .fetched else {
            return nil
        }
        
        store.dispatch(
            CharacterProfileActions.CharacterProfileAction.updateRetrievalState(state: .fetching)
        )
        
        userProfileService.getCharacter(id: "\(state.marvelCharacterProfileState.userProfile?.id ?? 0)") { result in
            
            switch result {
            case .failure:
                store.dispatch(CharacterProfileActions.CharacterProfileAction.updateRetrievalState(state: .failure))
            case let .success(value):
                switch value {
                case let .getCharacter(marvelCharacter):
                    store.dispatch(CharacterProfileActions.CharacterProfileAction.updateRetrievalState(state: .success))
                    store.dispatch(CharacterProfileActions.CharacterProfileAction.setMarvelCharacterProfile(profile: marvelCharacter))
                    store.dispatch(CharacterProfileActions.CharacterProfileAction.updateRetrievalState(state: .fetched))
                case .noResults:
                    store.dispatch(CharacterProfileActions.CharacterProfileAction.updateRetrievalState(state: .failure))
                default:
                    break
                }
            }
        }
        
        return nil
    }
}
