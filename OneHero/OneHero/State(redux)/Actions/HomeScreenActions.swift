//
//  Actions.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct HomeScreenActions {
    enum HomeScreenAction: Action {
        case resetState
        case resetOperationState
        case updateRetrievalState(state: HomeScreenState.RetrievalState)
        case setMarvelCharacterProfile(profile: [MarvelCharacter]?)
        case getCharacters
        case setSelectedCharacter(profile: MarvelCharacter?)
        case setShouldLoadMore(loadMore: Bool)
        case setStartEndPagingIndex(pagingIndex: PagingIndex)
        case presentPopover(presentPopover: HomeScreenState.PresentPopover)
        case reset
    }
}

struct HomeScreenActionCreators: HasDependencies {
    func getCharacters(state: AppState, store: Store<AppState>) -> Action? {
        let marvelAPIService = dependencies.resolveMarvelAPIService()
        store.dispatch(ResetRoutingAction())
        
        store.dispatch(
            CharacterProfileActions.CharacterProfileAction.updateRetrievalState(state: .fetching)
        )
        
        marvelAPIService.getCharacters(startIndex: state.homeScreenState.pagingIndex.start, maxResults: state.homeScreenState.pagingIndex.end) { result in
            
            if result.error == nil {
                store.dispatch(HomeScreenActions.HomeScreenAction.updateRetrievalState(state: .fetching))
            }
            
            if result.error != nil {
                store.dispatch(HomeScreenActions.HomeScreenAction.updateRetrievalState(state: .failure))
            }
            
            if result.value != nil {
                switch result {
                case let .success(value):
                    switch value {
                    case let .getCharacters(marvelCharacters):
                        store.dispatch(HomeScreenActions.HomeScreenAction.updateRetrievalState(state: .success))
                        store.dispatch(HomeScreenActions.HomeScreenAction.setMarvelCharacterProfile(profile: marvelCharacters))
                        
                        if state.homeScreenState.pagingIndex.start > 0 {
                            store.dispatch(HomeScreenActions.HomeScreenAction.setShouldLoadMore(loadMore: true))
                        } else {
                            store.dispatch(HomeScreenActions.HomeScreenAction.setShouldLoadMore(loadMore: false))
                        }
                        
                        store.dispatch(HomeScreenActions.HomeScreenAction.updateRetrievalState(state: .fetched))
                    case .noResults:
                        store.dispatch(HomeScreenActions.HomeScreenAction.updateRetrievalState(state: .failure))
                    default:
                        break
                    }
                default: break
                }
            }
        }
        return nil
    }
}
