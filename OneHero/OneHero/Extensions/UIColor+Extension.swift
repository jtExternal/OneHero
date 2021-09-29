//
//  UIColor+Extension.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    struct Palette {
        /// FFFFFF white
        static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        /// 949DA5 light gray
        static let manatee = #colorLiteral(red: 0.5803921569, green: 0.6156862745, blue: 0.6470588235, alpha: 1)

        /// C4CDD5 med gray
        static let lavenderGray = #colorLiteral(red: 0.768627451, green: 0.8039215686, blue: 0.8352941176, alpha: 1)

        /// F4F6F8 slight white
        static let whiteSmoke = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9725490196, alpha: 1)

        /// F9FAFB slight white
        static let ghostWhite = #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9843137255, alpha: 1)

        /// E6EAED light gray
        static let platinum = #colorLiteral(red: 0.9019607843, green: 0.9176470588, blue: 0.9294117647, alpha: 1)

        /// 737A81 dark gray
        static let auroMetalSaurus = #colorLiteral(red: 0.4509803922, green: 0.4784313725, blue: 0.5058823529, alpha: 1)

        /// 34393E
        static let charcoal = #colorLiteral(red: 0.2039215686, green: 0.2235294118, blue: 0.2431372549, alpha: 1)

        /// 0A9A5D darker green
        static let shamrockGreen = #colorLiteral(red: 0.03921568627, green: 0.6039215686, blue: 0.3647058824, alpha: 1)

        /// 00CC75 med green
        static let caribbeanGreen = #colorLiteral(red: 0, green: 0.8, blue: 0.4588235294, alpha: 1)

        /// D30015 red
        static let harvardCrimson = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.08235294118, alpha: 1)

        /// 84ccae
        static let disabledButtonColor = #colorLiteral(red: 0.5176470588, green: 0.8, blue: 0.6823529412, alpha: 1)

        /// 0A6DFD
        static let darkBlue = #colorLiteral(red: 0.039, green: 0.427, blue: 0.992, alpha: 1)

        /// e6f0fe
        static let lightBlue = #colorLiteral(red: 0.902, green: 0.941, blue: 0.996, alpha: 1)

        /// e9f7f1
        static let lightGreen = #colorLiteral(red: 0.914, green: 0.969, blue: 0.945, alpha: 1)
    }
}
