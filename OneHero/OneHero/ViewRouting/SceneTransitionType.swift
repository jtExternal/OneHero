//
//  SceneTransitionType.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import UIKit

enum SceneTransitionType: Equatable {
    case launching
    case show
    case root // make view controller the root view controller.
    case push // push view controller to navigation stack.
    case pushWithoutAnimation
    case pushUsing(usingNav: UINavigationController?)
    case present // present view controller.
    case alert // present alert.
    case none
    case back
    case backUsing
    case popToRoot
}

enum AnimationType {
    case standard
    case flip
    case slide
    case none
}
