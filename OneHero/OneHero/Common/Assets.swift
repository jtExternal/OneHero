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
    case marvelHistoryBioPlaceholder = "MarvelHistoryBio"
    
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
    
    func getRTF() -> NSAttributedString? {
        let bundle = Bundle(for: AppDelegate.self)
        guard let url = bundle.url(forResource: self.rawValue, withExtension: "rtf") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? NSAttributedString(data: data,
                                       options: [.documentType: NSAttributedString.DocumentType.rtf],
                                       documentAttributes: nil)
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
