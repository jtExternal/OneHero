//
//  UIView+Extensions.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

public extension UIView {
    func fixInView(_ container: UIView!) {
        translatesAutoresizingMaskIntoConstraints = false
        frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: container,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: container,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: container,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: container,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
    }

    // swiftlint:disable force_cast
    /** Loads instance from nib with the same name. */
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }

    /// Border color of view; also inspectable from Storyboard.
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }

        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }

            layer.borderColor = color.cgColor
        }
    }

    /// Border width of view; also inspectable from Storyboard.
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    /// Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }

        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }

    //    1. Call this method from your init functions
    /// Helper method to init and setup the view from the Nib.
    func xibSetup(name: String? = nil) {
        let view = loadFromNib(name: name)
        addSubview(view)
        stretch(view: view)
    }

    //    2. Loads the view from the nib in the bundle
    /// Method to init the view from a Nib.
    ///
    /// - Returns: Optional UIView initialized from the Nib of the same class name.
    func loadFromNib<T: UIView>(name: String?) -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = name ?? String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName))")
        }

        return view
    }

    //    3. Resizes the loaded view, ready for use
    /// Stretches the input view to the UIView frame using Auto-layout
    ///
    /// - Parameter view: The view to stretch.
    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension UIView {
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
