//
//  LoginViewModel.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct HomeScreenState: Equatable {
    enum StoreLocationsState {
        case notBegan
        case searching
        case success
        case failure
    }

    enum RetrievalState {
        case notFetched
        case fetching
        case fetched
        case none
        case queryPassed
        case success
        case failure
    }
    
    enum PresentPopover {
        case present
        case none
    }

    enum AttemptErrorType {
        case none
        case unableToFindStore
        case unableToGetLocation
    }

    var currentSearchQuery: String?
    var characters: [MarvelCharacter]
    var storeLocationState: StoreLocationsState
    var error: AttemptErrorType
    var selectedCharacter: MarvelCharacter?
    var retrievalState: RetrievalState
    var presentPopover: PresentPopover?
    var pagingIndex: PagingIndex = PagingIndex(start: 0, end: Configuration.defaultPagingAmt)
    var shouldLoadMore: Bool = false
    
    static func initState() -> HomeScreenState {
        return HomeScreenState(currentSearchQuery: nil, characters: [MarvelCharacter](), storeLocationState: .notBegan, error: .none, selectedCharacter: nil, retrievalState: .notFetched )
    }
}
