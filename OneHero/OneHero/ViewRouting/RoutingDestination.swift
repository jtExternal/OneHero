//
//  RoutingDestination.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import UIKit

enum RoutingDestination: Navigation {
    case home
    case aboutCharacter
    case undefined
    
    var id: String {
        switch self {
        case .home:
            return "homeVC"
        case .aboutCharacter:
            return "aboutCharacterVC"
        case .undefined:
           return ""
        }
    }
    
    func getScreen() -> UIViewController? {
        var storyboard: UIStoryboard = StoryboardNames.getStoryboard(storyboard: .homeScreenStoryboard)
        
        switch self {
        case .home:
            storyboard = StoryboardNames.getStoryboard(storyboard: .homeScreenStoryboard)
        case .aboutCharacter:
            storyboard = StoryboardNames.getStoryboard(storyboard: .aboutCharacterScreenStoryboard)

        case .undefined:
            return nil
        }
        
        return storyboard.instantiateViewController(withIdentifier: self.id)
    }
}
