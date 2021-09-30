//
//  UserProfileState.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import ReSwift

struct AboutCharacterProfileState: Equatable {
    static func == (lhs: AboutCharacterProfileState, rhs: AboutCharacterProfileState) -> Bool {
        return lhs.userProfile == rhs.userProfile &&
            (lhs.fetchProfileOperationState == rhs.fetchProfileOperationState) &&
            (lhs.error == rhs.error)
    }

    enum UserProfileErrorType {
        case none
        case unableToRetrieve
    }

    enum RetrievalState {
        case notFetched
        case fetching
        case fetched
        case queryPassed
        case success
        case failure
    }
    
    var fetchProfileOperationState: RetrievalState
    var userProfile: MarvelCharacter?
    var error: UserProfileErrorType

    static func initialUserProfileState() -> AboutCharacterProfileState {
        return AboutCharacterProfileState(fetchProfileOperationState: .notFetched,
                                userProfile: nil,
                                error: .none)
    }
}
