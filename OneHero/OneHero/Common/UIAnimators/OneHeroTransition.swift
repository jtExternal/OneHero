//
//  OneHeroTransition.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import UIKit

public protocol OneHeroTransition {
    func animateFlipTransition(fromView: UIView,
                               toView: UIView,
                               completion: @escaping AnimatableCompletion)
}

public let defaultTransitionDuration: Duration = 0.5
public typealias AnimatableCompletion = () -> Void
public typealias AnimatableExecution = () -> Void
public typealias Duration = TimeInterval

struct FlipTransition: OneHeroTransition {
    public var transitionDuration: Duration = defaultTransitionDuration

    func animateFlipTransition(fromView: UIView,
                               toView: UIView,
                               completion: @escaping AnimatableCompletion) {
        UIView.transition(from: fromView,
                          to: toView,
                          duration: transitionDuration,
                          options: UIView.AnimationOptions.transitionFlipFromLeft,
                          completion: { _ in
                              completion()
        })
    }
}
