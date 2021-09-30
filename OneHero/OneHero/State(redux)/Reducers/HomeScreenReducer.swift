//
//  AuthenticationReducer.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct HomeScreenReducer {
    static func homeScreenReducer(action: Action, state: HomeScreenState?) -> HomeScreenState {
        var state = state ?? HomeScreenState.initState()
        switch action {
        case let act as HomeScreenActions.HomeScreenAction:
            switch act {
            case let .setMarvelCharacterProfile(characters):
                state.characters = characters ?? [MarvelCharacter]()
            case let .updateRetrievalState(newState):
                state.retrievalState = newState
            case let .setShouldLoadMore(loadMore):
                state.shouldLoadMore = loadMore
            case let .setStartEndPagingIndex(pagingIndex):
                state.pagingIndex = pagingIndex
            case let .setSelectedCharacter(marvelCharacter):
                state.selectedCharacter = marvelCharacter
            case let .presentPopover(presentPop):
                state.presentPopover = presentPop
            case .resetState, .reset:
                state = HomeScreenState.initState()
                state.retrievalState = .failure
                state.shouldLoadMore = false
                state.selectedCharacter = nil
                state.pagingIndex = PagingIndex(start: 0, end: Configuration.defaultPagingAmt)
            default: break
            }
        default: break
        }
        return state
    }
}
