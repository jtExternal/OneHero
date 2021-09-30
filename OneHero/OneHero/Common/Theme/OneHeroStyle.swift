//
//  OneHeroStyle.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import UIKit

/// Represents view style with a closure that configures the view.
public struct Style<View: UIView> {
    public let style: (View) -> Void

    public init(style: @escaping (View) -> Void) {
        self.style = style
    }

    /// Applies self to the view.
    public func apply(to view: View) {
        style(view)
    }

    /// Style that does nothing (keeps the default/native style).
    public static var native: Style<View> {
        return Style { _ in }
    }
}

extension UIView {
    /// For example: `let nameLabel = UILabel(style: Stylesheet.Profile.name)`.
    public convenience init<V>(style: Style<V>) {
        self.init(frame: .zero)
        apply(style)
    }

    /// Applies the given style to self.
    public func apply<V>(_ style: Style<V>) {
        guard let view = self as? V else {
            Log.w("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }

    /// Returns self with the style applied. For example: `let nameLabel = UILabel().styled(with: Stylesheet.Profile.name)`.
    public func styled<V>(with style: Style<V>) -> Self {
        guard let view = self as? V else {
            Log.w("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

extension Style {
    // swiftlint:disable force_cast
    /// Marges two styles together.
    public func adding<V>(_ other: Style<V>) -> Style {
        return Style {
            self.apply(to: $0)
            other.apply(to: $0 as! V)
        }
    }

    /// Returns current style modified by the given closure.
    public func modifying(_ other: @escaping (View) -> Void) -> Style {
        return Style {
            self.apply(to: $0)
            other($0)
        }
    }
}
