//
//  UIViewcontroller+Router.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import UIKit

extension UIViewController {
    func navigate(_ navigation: RoutingDestination) {
        navigate(navigation as Navigation)
    }
}
