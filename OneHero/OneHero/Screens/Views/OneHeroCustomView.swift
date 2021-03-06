//
//  OneHeroCustomView.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import QuartzCore
import UIKit

public class OneHeroViewWithShadow: UIView {
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

public class OneHeroCustomView: OneHeroViewWithShadow {
    enum ViewSide: Int {
        case left, right, top, bottom, none, all
    }

    public override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5)
    }

    @IBInspectable public override var borderWidth: CGFloat {
        didSet {
            updateBorder()
        }
    }

    @IBInspectable public override var borderColor: UIColor? {
        didSet {
            updateBorder()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyStyle()
    }

    fileprivate func applyStyle() {
        apply(Stylesheet.Main.oneHeroDefaultCustomView)
    }

    fileprivate func updateBorder() {
        let border = CALayer()
        var clearResult = false

        switch ViewSide(rawValue: borderToColor) ?? .none {
        case .left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: CGFloat(borderWidth), height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: CGFloat(borderWidth), height: frame.height)
        case .top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: CGFloat(borderWidth))
        case .bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: CGFloat(borderWidth))
        case .none, .all:
            clearResult = true
        }

        if !clearResult {
            border.borderColor = borderColor?.cgColor
            border.borderWidth = CGFloat(borderWidth)
            layer.addSublayer(border)
        } else {
            layer.borderWidth = 0
            layer.borderColor = UIColor.clear.cgColor
        }
    }

    @IBInspectable var borderToColor: Int = 0 {
        didSet {
            updateBorder()
        }
    }
}

/// Computed properties, based on the backing CALayer property, that are visible in Interface Builder.
open class ANCustomView: UIView {
    /// When positive, the background of the layer will be drawn with rounded corners. Also effects the mask generated by the `masksToBounds' property. Defaults to zero. Animatable.
    @IBInspectable public override var cornerRadius: CGFloat {
        get {
            return CGFloat(layer.cornerRadius)
        }
        set {
            layer.cornerRadius = CGFloat(newValue)
        }
    }

    /// The width of the layer's border, inset from the layer bounds. The border is composited above the layer's content and sublayers and includes the effects of the `cornerRadius' property. Defaults to zero. Animatable.
    @IBInspectable public override var borderWidth: CGFloat {
        get {
            return CGFloat(layer.borderWidth)
        }
        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }

    /// The color of the layer's border. Defaults to opaque black. Colors created from tiled patterns are supported. Animatable.
    @IBInspectable public override var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    /// The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    /// The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /// The blur radius used to create the shadow. Defaults to 3. Animatable.
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// Call this Function only, access from any where in your project
// Default values here
private let animationDuration: TimeInterval = 1.0
private let deleyTime: TimeInterval = 0
private let springDamping: CGFloat = 0.25
private let lowSpringDamping: CGFloat = 0.50
private let springVelocity: CGFloat = 8.00

extension ANCustomView {
    // MARK: Default Animation here

    public func AnimateView() {
        provideAnimation(animationDuration: animationDuration, deleyTime: deleyTime, springDamping: springDamping, springVelocity: springVelocity)
    }

    // MARK: Custom Animation here

    public func AnimateViewWithSpringDuration(_: UIView, animationDuration: TimeInterval, springDamping: CGFloat, springVelocity: CGFloat) {
        provideAnimation(animationDuration: animationDuration, deleyTime: deleyTime, springDamping: springDamping, springVelocity: springVelocity)
    }

    // MARK: Low Damping Custom Animation here

    public func AnimateViewWithSpringDurationWithLowDamping(_: UIView, animationDuration: TimeInterval, springVelocity: CGFloat) {
        provideAnimation(animationDuration: animationDuration, deleyTime: deleyTime, springDamping: lowSpringDamping, springVelocity: springVelocity)
    }

    private func provideAnimation(animationDuration: TimeInterval, deleyTime: TimeInterval, springDamping: CGFloat, springVelocity: CGFloat) {
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: animationDuration,
                       delay: deleyTime,
                       usingSpringWithDamping: springDamping,
                       initialSpringVelocity: springVelocity,
                       options: .allowUserInteraction,
                       animations: {
                           self.transform = CGAffineTransform.identity
        })
    }
}
