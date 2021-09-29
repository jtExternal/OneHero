//
//  ServicesDI.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation

protocol Dependency {
    func resolveMarvelAPIService() -> MarvelAPIServiceProtocol
}

class CoreDependency: Dependency {
    var config = Configuration()

    func resolveMarvelAPIService() -> MarvelAPIServiceProtocol {
        return MarvelAPIService()
    }
}

struct DependencyInjector {
    static var dependencies: Dependency = CoreDependency()
    private init() {}
}

/// Attach to any type for exposing the dependency container
protocol HasDependencies {
    var dependencies: Dependency { get }
}

extension HasDependencies {
    /// Container for dependency instance factories
    var dependencies: Dependency {
        return DependencyInjector.dependencies
    }
}

class AppDependency: CoreDependency {
    // FILL IN WITH NEW DEPENDENCIES
}
