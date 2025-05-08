//
//  Config.swift
//  MaterialDesignSwiftUITextfield
//
//  Created by Himan Dhawan on 5/5/25.
//

import SwiftUICore
import UIKit

class ACHScreenConfig {

    /// UI Elements retrictions
    static let routingNumberUpperLimit = 9
    static let bankAccountNumberUpperLimit = 17
    static let bankAccountNumberLowerLimit = 4

    /// UI Colors of Material Design textfields.

    static var errorColor: UIColor {
        
        return UIColor.red
    }

    static var filledColor: UIColor {
        
        return .systemBackground
    }

    static var strokeColor: UIColor {
        
        return UIColor.gray
    }

    static var textColor: UIColor {
        
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor.black
        }
    }

    static var focusedColor: UIColor {
        return UIColor.blue
    }


    
    static func getPlaceHolderFontOfTextField() -> Font {
        
        return Font.system(size: 15)
    }
    
    static func getTextFontOfTextField() -> Font {
        
        
        return Font.system(size: 11)
    }
    
    static func getTextFontOfErrorLabel() -> Font {
        
        return Font.system(size: 11)
    }

}


public class SDKMaterialTextFieldConfig {
    public static var shared = SDKMaterialTextFieldConfig()
    private init() {}
    
    // Text Color
    public var defaultTextColor : Color = Color(ACHScreenConfig.textColor)
    public var darkModeTextColor : Color = Color(ACHScreenConfig.textColor)
    // Title Color
    public var defaultTitleColor : Color = Color(ACHScreenConfig.textColor)
    public var darkModeTitleColor : Color = Color(ACHScreenConfig.textColor)
    // PlaceHolder Text Color
    public var defaultPlaceHolderTextColor : Color = Color(ACHScreenConfig.strokeColor).opacity(0.8)
    public var darkModePlaceHolderTextColor : Color = Color(ACHScreenConfig.strokeColor).opacity(0.8)
    // Disable Color
    public var defaultDisableColor : Color = Color(UIColor.systemGray).opacity(0.1)
    public var darkModeDisableColor : Color = .gray.opacity(0.2)
    // Background Color
    public var defaultBackgroundColor : Color = Color(ACHScreenConfig.filledColor)
    public var darkModeBackgroundColor : Color = Color(ACHScreenConfig.filledColor)
    // Error Text Color
    public var defaultErrorTextColor : Color = Color(ACHScreenConfig.errorColor)
    public var darkModeErrorTextColor : Color = Color(ACHScreenConfig.errorColor)
    // Border Color
    public var defaultBorderColor : Color = .gray
    public var darkModeBorderColor : Color = .white.opacity(0.7)
    // Trailing Image Color
    public var defaultTrailingImageForegroundColor : Color = .black
    public var darkModeTrailingImageForegroundColor : Color = .white
    // Focused Border Color
    public var focusedBorderColorEnable: Bool = true
    public var defaultFocusedBorderColor : Color = Color(ACHScreenConfig.focusedColor)
    public var darkModeFocusedBorderColor : Color = Color(ACHScreenConfig.focusedColor)
    // Font
    public var titleFont : Font = ACHScreenConfig.getTextFontOfTextField()
    public var errorFont : Font = ACHScreenConfig.getTextFontOfErrorLabel()
    public var placeHolderFont : Font = ACHScreenConfig.getPlaceHolderFontOfTextField()
    // Default
    public var borderWidth : CGFloat = 1.0
    public var cornerRadius : CGFloat = 5.0
    public var borderType: BorderType = .line
    public var disableAutoCorrection: Bool = false
    public var textFieldHeight : CGFloat = 45
}

public enum BorderType {
    case square
    case line
}
