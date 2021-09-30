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
        case .dev: return AppSecrets.privateApiKey
        case .qa: return AppSecrets.privateApiKey
        case .production: return AppSecrets.privateApiKey
        }
    }
    
    var publicApiKey: String {
        switch self {
        case .dev: return AppSecrets.publicApiKey
        case .qa: return AppSecrets.publicApiKey
        case .production: return AppSecrets.publicApiKey
        }
    }
}

struct Configuration {
    var environment: Environment {
        #if DEV
            let env = Environment.dev
        #elseif qa
            let env = Environment.qa
        #else
            let env = Environment.production
        #endif

        return env
    }

    /// Set during authentication process
    var shouldUseMockJSON: Bool = false
    
    
    static let defaultPagingAmt = 10
    static let imageNotAvailableSuffix = "image_not_available.jpg"
    
}
