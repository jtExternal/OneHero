//
//  OneHeroProgressView.swift
//  OneHero
//
//  Created by Justin Trantham on 9/29/21.
//

import Foundation
import UIKit

open class OneHeroProgressView {
    static let shared = OneHeroProgressView()

    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()

    open func showProgressView() {
        let window = UIWindow(frame: UIScreen.main.bounds)

        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor(hex: 0xFFFFFF, alpha: 0.3)

        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = window.center
        progressView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)

        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        UIApplication.shared.keyWindow?.addSubview(containerView)
        activityIndicator.startAnimating()
    }

    open func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 256.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 256.0
        let blue = CGFloat(hex & 0xFF) / 256.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
