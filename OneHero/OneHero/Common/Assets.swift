//
//  Assets.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import UIKit

enum Assets: String {
    case detail
    case placeHolder
    
    enum Font: String {
        case workSansRegFont = "WorkSans-Regular"
        case workSansSemiBoldFont = "WorkSans-SemiBold"
        case workSansThin = "WorkSans-Thin"
        case workSansMedium = "WorkSans-Medium"
        case workSansLight = "WorkSans-Light"
    }
    
    func getImage() -> UIImage? {
        let bundle = Bundle(for: SceneDelegate.self)
        return UIImage(named: rawValue, in: bundle, compatibleWith: nil)
    }
}

extension Assets.Font {
    func getFont() -> UIFont {
        guard let customFont = UIFont(name: self.rawValue, size: UIFont.labelFontSize) else {
            fatalError("""
            Failed to load the "\(rawValue)" font.
            Make sure the font file is included in the project and the font name is spelled correctly.
            """
            )
        }
        return customFont
    }
}
