//
//  AppDelegate.swift
//  OneHero
//
//  Created by Justin Trantham on 9/29/21.
//

import UIKit
import ReSwift

let store = Store<AppState>(reducer: appReducer, state: nil)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let diskCacheSize = 100*1024*1024
        URLCache.configSharedCache(disk: diskCacheSize)
        
        guard  !AppSecrets.publicApiKey.isEmpty && !AppSecrets.privateApiKey.isEmpty  else {
            assertionFailure("Public & private API keys cannot be empty. Please follow README.")
            return false
        }
        
        return true
    }
    
    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        configure(dependency: AppDependency())
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

