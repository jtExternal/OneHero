//
//  OneHeroStyleSheet.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import UIKit

enum Stylesheet {
    enum Main {
        // name, color, font, font size e.g oneHeroMessageTextGreyRegular15
        enum Labels {
            /// Reg Work Sans Font - Grey - 15 pts
            static let oneHeroMessageTextGreyRegular15 = Style<UILabel> {
                $0.textColor = UIColor.Palette.manatee
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(15.0)
                $0.minimumScaleFactor = 0.5
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true
            }

            /// Medium Work Sans Font - Dark Grey - 28 pts
            static let oneHeroTitleDarkGreyMedium28 = Style<UILabel> {
                $0.textColor = UIColor.Palette.charcoal
                $0.font = Assets.Font.workSansMedium.getFont().withSize(28.0)
                $0.minimumScaleFactor = 0.5
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true
            }

            /// Medium Work Sans Font - Dark Grey - 18 pts
            static let oneHeroFormLabelPageTitleMedium16 = Style<UILabel> {
                $0.textColor = UIColor.Palette.charcoal
                $0.font = Assets.Font.workSansMedium.getFont().withSize(16.0)
                $0.minimumScaleFactor = 0.5
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true
            }

            /// Regular Work Sans Font - Dark Grey - 15 pts
            static let oneHeroFormLabelTitleDarkGreyRegular15 = Style<UILabel> {
                $0.textColor = UIColor.Palette.charcoal
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(15.0)
                $0.minimumScaleFactor = 0.5
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true
            }

            /// Semi bold Work Sans Font - Dark Grey - 15 pts
            static let oneHeroMessageTitleUnreadDarkGreySemiBold15 = Style<UILabel> {
                $0.textColor = UIColor.Palette.charcoal
                $0.font = Assets.Font.workSansSemiBoldFont.getFont().withSize(15.0)
                $0.minimumScaleFactor = 0.5
            }

            /// Medium Work Sans Font - Dark Grey - 15 pts
            static let oneHeroMessageTitleReadDarkGreyMedium15 = Style<UILabel> {
                $0.textColor = UIColor.Palette.charcoal
                $0.font = Assets.Font.workSansMedium.getFont().withSize(15.0)
                $0.minimumScaleFactor = 0.5
            }

            /// Regular Work Sans Font - Light Grey - 14 pts
            static let oneHeroMessageTextBodyLightGreyRegular14 = Style<UILabel> {
                $0.textColor = UIColor.Palette.manatee
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(14.0)
                $0.minimumScaleFactor = 0.5
            }
            
            
            /// Medium Work Sans Font - Dark Grey - 28 pts
            static let oneHeroTitleWhiteMedium18 = Style<UILabel> {
                $0.textColor = UIColor.Palette.ghostWhite
                $0.font = Assets.Font.workSansSemiBoldFont.getFont().withSize(18.0)
                $0.minimumScaleFactor = 0.5
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true
            }

            /// Regular Work Sans Font - Dark Grey - 15 pts - Attributed
            static let oneHeroFormLabelTitleAttributedDarkGreyRegular15 = Style<UILabel> {
                $0.minimumScaleFactor = 0.5
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true

                let attribs: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.font: Assets.Font.workSansRegFont.getFont().withSize(15.0),
                    NSAttributedString.Key.foregroundColor: UIColor.Palette.charcoal
                ]
                $0.backgroundColor = UIColor.clear
                let attributeString = NSMutableAttributedString(string: $0.text ?? "",
                                                                attributes: attribs)
                $0.attributedText = attributeString
            }

            /// Regular Work Sans Font - Dark Red - 15 pts
            static let oneHeroErrorLabelDarkRedRegular15 = Style<UILabel> {
                $0.textColor = UIColor.Palette.harvardCrimson
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(15.0)
                $0.minimumScaleFactor = 0.5
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true
            }

            /// Regular Work Sans Font - Light Grey - 13 pts
            static let oneHeroFormLabelSmallMessageLightGreyRegular13 = Style<UILabel> {
                $0.textColor = UIColor.Palette.manatee
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(13.0)
                $0.minimumScaleFactor = 0.5
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true
            }

            /// Regular Work Sans Font - Dark Grey - 18 pts
            static let oneHeroFormLabelSectionTitleDarkGreyRegular18 = Style<UILabel> {
                $0.textColor = UIColor.Palette.auroMetalSaurus
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(18.0)
                $0.minimumScaleFactor = 0.5
                $0.adjustsFontSizeToFitWidth = true
                $0.adjustsFontForContentSizeCategory = true
            }

            /// Regular Work Sans Font - Dark Grey - 13 pts
            static let oneHeroMessageTextCharcoalRegular13 = oneHeroMessageTextGreyRegular15.modifying {
                $0.textColor = UIColor.Palette.charcoal
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(13.0)
            }
        }

        /// Buttons
        enum Buttons {
            /// White background button/checkbox with grey tint
            static let oneHeroCheckboxUnselcted = Style<UIButton> {
                $0.tintColor = UIColor.Palette.lavenderGray
            }

            /// White background button/checkbox with green tint
            static let oneHeroCheckboxSelected = Style<UIButton> {
                $0.tintColor = UIColor.Palette.shamrockGreen
            }

            /// Base rounded button with 15 pt work sans medium font
            static let oneHeroRoundSolidButton = Style<UIButton> {
                $0.cornerRadius = 20.0
                $0.isEnabled = true
                $0.setTitleColor(UIColor.Palette.white, for: .normal)
                $0.backgroundColor = UIColor.Palette.shamrockGreen
                $0.titleLabel?.font = Assets.Font.workSansMedium.getFont().withSize(15.0)
            }

            /// Medium Work Sans font - White Font - 15 pts - Red background
            static let oneHeroRoundSolidRedButton = oneHeroRoundSolidButton.modifying {
                $0.setTitleColor(UIColor.Palette.white, for: .normal)
                $0.backgroundColor = UIColor.Palette.harvardCrimson
            }

            /// Medium Work Sans font - White Font - 15 pts - Green background
            static let oneHeroRoundSolidGreenButton = oneHeroRoundSolidButton.modifying {
                $0.setTitleColor(UIColor.Palette.white, for: .normal)
                $0.backgroundColor = UIColor.Palette.shamrockGreen
            }

            /// Medium Work Sans font - Grey Font - 15 pts - Hollow background with grey border outline
            static let oneHeroImageLeftButtonGrey = Style<UIButton> {
                $0.setTitleColor(UIColor.Palette.manatee, for: .normal)
                $0.backgroundColor = UIColor.clear
                $0.imageView?.tintColor = UIColor.Palette.manatee
                $0.tintColor = UIColor.Palette.manatee
            }

        }

        /// TextViews
        enum TextViews {
            static let oneHeroMultiLineTextInput = Style<UITextView> {
                $0.enablesReturnKeyAutomatically = true
                $0.textColor = UIColor.Palette.manatee
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(15.0)
                $0.borderWidth = 1.0
                $0.tintColor = UIColor.Palette.manatee
                $0.borderColor = UIColor.Palette.lavenderGray
                $0.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            }
        }

        /// TextFields
        enum TextFields {
            static let oneHeroTextField = Style<UITextField> {
                $0.enablesReturnKeyAutomatically = true
                $0.returnKeyType = .next
                $0.textColor = UIColor.Palette.charcoal
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(15.0)
                
                $0.cornerRadius = 8.0
                $0.borderWidth = 1.0
                $0.tintColor = UIColor.Palette.charcoal
                $0.clearButtonMode = .never
                $0.borderColor = UIColor.Palette.lavenderGray
            }

            static let oneHeroTextFieldPlaceholderGrey15 = Style<UITextField> {
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(15.0)
                $0.textColor = UIColor.Palette.manatee

                $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder != nil ? $0.placeholder! : "",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.Palette.manatee])
            }

            static let oneHeroTextFieldGrey15 = Style<UITextField> {
                $0.font = Assets.Font.workSansRegFont.getFont().withSize(15.0)
                $0.textColor = UIColor.Palette.charcoal

                $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder != nil ? $0.placeholder! : "",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.Palette.manatee])
            }

            static let oneHeroTextFieldError = oneHeroTextField.modifying {
                $0.borderColor = UIColor.Palette.harvardCrimson
            }

            static let oneHeroTextFieldNoBorderSquare = oneHeroTextField.modifying {
                $0.borderColor = UIColor.clear
                $0.borderWidth = 0
                $0.cornerRadius = 0.0
                $0.borderStyle = .none
            }

            static let oneHeroTextFieldFormTextInputSettings = oneHeroTextField.modifying {
                $0.keyboardType = UIKeyboardType.asciiCapable
                $0.placeholder = nil
            }

            static let oneHeroTextFieldFormTextEmailInputSettings = oneHeroTextFieldFormTextInputSettings.modifying {
                $0.keyboardType = UIKeyboardType.emailAddress
                $0.placeholder = nil
            }

            static let oneHeroTextFieldFormTextPasswordInputSettings = oneHeroTextFieldFormTextInputSettings.modifying {
                $0.isSecureTextEntry = true
                $0.placeholder = nil
                $0.clearsOnBeginEditing = false
            }

            static let oneHeroTextFieldFormTextTelephoneInputSettings = oneHeroTextFieldFormTextInputSettings.modifying {
                $0.keyboardType = .phonePad
                $0.textContentType = UITextContentType.telephoneNumber
                $0.placeholder = nil
            }

            static let oneHeroTextFieldFormTextSocialSecurityNumber = oneHeroTextFieldFormTextInputSettings.modifying {
                $0.keyboardType = .phonePad
                $0.isSecureTextEntry = true
                $0.textContentType = UITextContentType.telephoneNumber
                $0.placeholder = nil
            }

            static let oneHeroTextFieldFormTextSocialSecurityNumberWithoutSecure = oneHeroTextFieldFormTextInputSettings.modifying {
                $0.keyboardType = .phonePad
                $0.textContentType = UITextContentType.telephoneNumber
                $0.placeholder = nil
            }
        }

        enum Views {
          
        }

        enum ImageViews {
        }

        static let oneHeroDefaultBackground = Style<UIView> {
            $0.backgroundColor = UIColor.Palette.whiteSmoke
        }

        static let oneHeroDefaultCustomView = Style<OneHeroCustomView> {
            $0.cornerRadius = 6
            $0.borderColor = UIColor.Palette.charcoal
            $0.shadowColor = UIColor.Palette.charcoal
            $0.shadowOpacity = 0.1
            $0.shadowOffset = CGSize(width: 0, height: 1)
            $0.shadowRadius = 20
            $0.borderWidth = 0
        }

        static let oneHeroMenuTableViewCell = Style<UITableViewCell> {
            $0.textLabel?.font = Assets.Font.workSansRegFont.getFont().withSize(15.0)
            $0.textLabel?.textColor = UIColor.Palette.charcoal
            $0.selectionStyle = .none
        }

        /// Off white background color navigation bar with 17 pt medium Works Sans Medium Font
        static let navBarAppearance = Style<UINavigationBar> {
            $0.barTintColor = UIColor.Palette.white
            $0.barStyle = .default
            $0.backgroundColor = UIColor.Palette.whiteSmoke
            $0.isTranslucent = true
            $0.titleTextAttributes = [NSAttributedString.Key.font: Assets.Font.workSansMedium.getFont().withSize(17.0),
                                      NSAttributedString.Key.foregroundColor: UIColor.Palette.charcoal]
        }

        static let navBarAppearanceClear = Style<UINavigationBar> {
            $0.barTintColor = UIColor.clear
            $0.barStyle = .default
            $0.backgroundColor = UIColor.clear
            $0.setBackgroundImage(UIImage(), for: .default)
            $0.shadowImage = UIImage()
            $0.isTranslucent = true
            $0.titleTextAttributes = [NSAttributedString.Key.font: Assets.Font.workSansMedium.getFont().withSize(17.0),
                                      NSAttributedString.Key.foregroundColor: UIColor.Palette.charcoal]
        }

        /// Disabled navigation bar right item green text
        static let navbarItemRightGreenAlphaDisabled: (UIBarButtonItem?) -> UIBarButtonItem? = {
            $0?.tintColor = UIColor.Palette.caribbeanGreen.withAlphaComponent(0.7)
            $0?.isEnabled = false
            return $0
        }

        static let navbarItemRightGreenEnabled: (UIBarButtonItem?) -> UIBarButtonItem? = {
            $0?.tintColor = UIColor.Palette.caribbeanGreen
            $0?.isEnabled = true
            return $0
        }
        
        /// Back image `<` for navigation back bar item
        static let navBarItemAppearance: () -> UIBarButtonItem = {
            let backItem = UIBarButtonItem()
            backItem.title = ""
            backItem.tintColor = .clear
//            backItem.image = Assets.back.getImage()

            return backItem
        }
        
        static let image = Style<UIImageView> {
            $0.contentMode = .center
            $0.backgroundColor = .darkGray
        }
    }
}
