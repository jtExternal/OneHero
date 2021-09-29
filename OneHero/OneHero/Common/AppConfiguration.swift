//
//  AppConfiguration.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation

enum Environment: String {
    case dev
    case qa
    case production

    var apiBaseUrl: String {
        switch self {
        case .dev: return "https://gateway.marvel.com/v1/public"
        case .qa: return "https://gateway.marvel.com/v1/public"
        case .production: return "https://gateway.marvel.com/v1/public"
        }
    }

    var privateApiKey: String {
        switch self {
        case .dev: return "11db5a813befb9fea66d3846e74e26e61b0856e7"
        case .qa: return "11db5a813befb9fea66d3846e74e26e61b0856e7"
        case .production: return "11db5a813befb9fea66d3846e74e26e61b0856e7"
        }
    }
    
    var publicApiKey: String {
        switch self {
        case .dev: return "0c8c7ee951fa19cf452b6e35076d7d83"
        case .qa: return "0c8c7ee951fa19cf452b6e35076d7d83"
        case .production: return "0c8c7ee951fa19cf452b6e35076d7d83"
        }
    }
}

struct Configuration {
    var environment: Environment {
        #if DEV
            let env = Environment.dev
        #elseif Staging
            let env = Environment.qa
        #else
            let env = Environment.production
        #endif

        return env
    }

    /// Set during authentication process
    var shouldUseMockJSON: Bool = false
    
    static let defaultPagingAmt = 10
}
