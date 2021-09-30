//
//  StoryboardNames.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import UIKit

enum StoryboardNames: String {
    case homeScreenStoryboard = "Main"
    case aboutCharacterScreenStoryboard = "About"
    
    static func getStoryboard(storyboard: StoryboardNames) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
    }
}
