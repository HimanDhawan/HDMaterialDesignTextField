//
//  MaterialDesignTextField.swift
//  MaterialDesignSwiftUITextfield
//
//  Created by Himan Dhawan on 5/5/25.
//

import SwiftUICore
import SwiftUI

/// A customizable Material Design text field component for SwiftUI applications.
///
/// This component provides a rich set of features including:
/// - Material Design styling with floating labels
/// - Support for light and dark mode
/// - Customizable colors, fonts, and dimensions
/// - Left and trailing icons with click handlers
/// - Secure text entry
/// - Error states and messages
/// - Accessibility support
/// - Character count limits
/// - Custom keyboard types
///
/// # Example Usage
/// ```swift
/// SDKMaterialTextField(text: .constant(""))
///     .setTitleText("Username")
///     .setPlaceHolderText("Enter your username")
///     .setError(errorText: .constant("Invalid username"))
/// ```
public struct HDMaterialTextField: View {
    
    // MARK: - Environment and State Properties
    
    /// The current color scheme (light/dark mode)
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    /// The trailing icon image
    @State private var trailingImage : Image?
    
    /// The keyboard type for the text field
    @State private var keyBoardType : UIKeyboardType = .default
    
    /// The left icon image binding
    @Binding private var leftImage: Image?
    
    /// The focus state of the text field
    @FocusState private var isTextFieldFocused: Bool
    
    // MARK: - Configuration Properties
    
    /// Callback for left icon tap
    private var onTapLeftIcon: (() -> Void)?
    
    /// Size of the left icon
    private var leftIconFrame: CGSize = CGSize(width: 25, height: 25)
    
    /// Color of the left icon
    private var leftIconColor: Color?
    
    /// Accessibility identifier for the text field
    private var accessibilityIdentifier: String = ""
    
    // MARK: - State Properties
    
    /// Whether the text is secure (password field)
    @State private var secureText = false
    
    /// Whether the text field is focused
    @State var isFocused = false
    
    // MARK: - Text Field Properties
    
    /// Binding to the text field's content
    private var text: Binding<String>
    
    /// Binding to control if the text field is disabled
    private var disable: Binding<Bool>?
    
    /// Binding to control if the text field is in error state
    private var error: Binding<Bool>?
    
    /// Binding to the error message text
    private var errorText: Binding<String>?
    
    /// Whether the text field is secure
    private var isSecureText: Bool = false
    
    /// The title text that appears above the field when focused
    private var titleText: String?
    
    /// The placeholder text that appears when the field is empty
    private var placeHolderText: String = ""
    
    /// Callback for trailing icon tap
    private var trailingImageClick: (() -> Void)?
    
    /// Image to show when secure text is visible
    private var secureTextImageOpen : Image? = Image(systemName: "eye.fill")
    
    /// Image to show when secure text is hidden
    private var secureTextImageClose : Image? = Image(systemName: "eye.slash.fill")
    
    /// Maximum number of characters allowed
    private var maxCount: Int?
    
    /// How to truncate text when it overflows
    private var truncationMode: Text.TruncationMode = Text.TruncationMode.tail
    
    // MARK: - Color Properties
    
    /// Text colors for light and dark mode
    private var defaultTextColor = SDKMaterialTextFieldConfig.shared.defaultTextColor
    private var darkModeTextColor = SDKMaterialTextFieldConfig.shared.darkModeTextColor
    
    /// Title colors for light and dark mode
    private var defaultTitleColor = SDKMaterialTextFieldConfig.shared.defaultTitleColor
    private var darkModeTitleColor = SDKMaterialTextFieldConfig.shared.darkModeTitleColor
    
    /// Placeholder colors for light and dark mode
    private var defaultPlaceHolderTextColor = SDKMaterialTextFieldConfig.shared.defaultPlaceHolderTextColor
    private var darkModePlaceHolderTextColor = SDKMaterialTextFieldConfig.shared.darkModePlaceHolderTextColor
    
    /// Disabled state colors for light and dark mode
    private var defaultDisableColor = SDKMaterialTextFieldConfig.shared.defaultDisableColor
    private var darkModeDisableColor = SDKMaterialTextFieldConfig.shared.darkModeDisableColor
    
    /// Background colors for light and dark mode
    private var defaultBackgroundColor = SDKMaterialTextFieldConfig.shared.defaultBackgroundColor
    private var darkModeBackgroundColor = SDKMaterialTextFieldConfig.shared.darkModeBackgroundColor
    
    /// Error text colors for light and dark mode
    private var defaultErrorTextColor = SDKMaterialTextFieldConfig.shared.defaultErrorTextColor
    private var darkModeErrorTextColor = SDKMaterialTextFieldConfig.shared.darkModeErrorTextColor
    
    /// Border colors for light and dark mode
    private var defaultBorderColor = SDKMaterialTextFieldConfig.shared.defaultBorderColor
    private var darkModeBorderColor = SDKMaterialTextFieldConfig.shared.darkModeBorderColor
    
    /// Trailing icon colors for light and dark mode
    private var defaultTrailingImageForegroundColor = SDKMaterialTextFieldConfig.shared.defaultTrailingImageForegroundColor
    private var darkModeTrailingImageForegroundColor = SDKMaterialTextFieldConfig.shared.darkModeTrailingImageForegroundColor
    
    /// Focused border colors for light and dark mode
    private var focusedBorderColorEnable = SDKMaterialTextFieldConfig.shared.focusedBorderColorEnable
    private var defaultFocusedBorderColor = SDKMaterialTextFieldConfig.shared.defaultFocusedBorderColor
    private var darkModeFocusedBorderColor = SDKMaterialTextFieldConfig.shared.darkModeFocusedBorderColor
    
    // MARK: - Font Properties
    
    /// Font for the title text
    private var titleFont = SDKMaterialTextFieldConfig.shared.titleFont
    
    /// Font for the error text
    private var errorFont = SDKMaterialTextFieldConfig.shared.errorFont
    
    /// Font for the placeholder text
    private var placeHolderFont = SDKMaterialTextFieldConfig.shared.placeHolderFont
    
    // MARK: - Style Properties
    
    /// Width of the border
    private var borderWidth = SDKMaterialTextFieldConfig.shared.borderWidth
    
    /// Radius of the corners
    private var cornerRadius = SDKMaterialTextFieldConfig.shared.cornerRadius
    
    /// Type of border (line or square)
    private var borderType = SDKMaterialTextFieldConfig.shared.borderType
    
    /// Whether to disable autocorrection
    private var disableAutoCorrection = SDKMaterialTextFieldConfig.shared.disableAutoCorrection
    
    /// Height of the text field
    private var textFieldHeight = SDKMaterialTextFieldConfig.shared.textFieldHeight
    
    /// Whether to show the left icon
    var showLeftIcon: Bool = false
    
    /// Whether the accessibility element should be hidden
    var isAccessbileHidden : Bool {
        if text.wrappedValue.count > 0 {
            return false
        }
        return true
    }
    
    /// Accessibility label for the left image
    var leftImageAccesiblityLabel: String = ""
    
    // MARK: - Initialization
    
    /// Creates a new Material Design text field
    /// - Parameter text: Binding to the text field's content
    public init(text: Binding<String>) {
        self.text = text
        self._leftImage = .constant(nil)
    }
    
    // MARK: - View Body
    
    public var body: some View {
        VStack(spacing: 4) {
            // Title and input area
            VStack(spacing: 0) {
                HStack(alignment:.center,spacing: 0) {
                    // Left icon
                    leftImage?
                        .resizable()
                        .scaledToFit()
                        .foregroundColor( leftIconColor != nil ? leftIconColor : getTrailingImageForegroundColor())
                        .frame(width: leftIconFrame.width, height: leftIconFrame.height)
                        .padding(.trailing, 0)
                        .padding(.leading, 10)
                        .onTapGesture {
                            onTapLeftIcon?()
                        }
                        .accessibilityElement()
                        .accessibilityLabel(leftImageAccesiblityLabel)
                        .accessibilityHidden(leftImageAccesiblityLabel.isEmpty ? true : false )
                    
                    // Text field content
                    VStack(spacing: -8) {
                        // Focus button
                        Button(action: {
                            isTextFieldFocused = true
                        }, label: {
                            Color.clear
                            .frame(height: 20)
                        })
                        
                        // Secure or regular text field
                        secureAnyView()
                            .onChange(of: isTextFieldFocused) { newValue in
                                if newValue {
                                    withAnimation(.smooth(duration: 0.1)) {
                                        isFocused = true
                                    }
                                } else {
                                    withAnimation(.smooth(duration: 0.1)) {
                                        isFocused = false
                                    }
                                }
                            }
                            .placeholder(when: true, placeholder: {
                                if self.text.wrappedValue.count > 0 {
                                    Text(titleText ?? "")
                                        .accessibilityIdentifier(accessibilityIdentifier)
                                        .accessibilityHidden(self.isAccessbileHidden)
                                        .accessibilityLabel(placeHolderText + "Textfield." + "Tap to edit")
                                        .padding(.top, -25)
                                        .padding(.leading,0)
                                        .foregroundColor(getTitleTextColor())
                                        .font(titleFont)
                                        .background(.red)
                                } else {
                                    Text(isFocused ? (titleText ?? "") : placeHolderText)
                                        .accessibilityIdentifier(accessibilityIdentifier)
                                        .accessibilityHidden(self.isAccessbileHidden)
                                        .accessibilityLabel(placeHolderText + "Textfield." + "Tap to edit")
                                        .padding(.top, isFocused ?  -25 : -10)
                                        .padding(.leading,isFocused ? 0 : 3)
                                        .foregroundColor(isFocused ? getTitleTextColor() : getPlaceHolderTextColor())
                                        .font(isFocused ? titleFont : placeHolderFont)
                                        
                                }
                            })
                            .font(placeHolderFont)
                            .keyboardType(keyBoardType)
                            .frame(maxWidth: .infinity)
                            .frame(height: textFieldHeight)
                            .foregroundColor(getTextColor())
                            .disabled(disable?.wrappedValue ?? false)
                            .padding([.trailing], borderType == .square ? 12 : 1)
                            .padding(.leading,10)
                            .disableAutocorrection(disableAutoCorrection)
                            .onReceive(text.wrappedValue.publisher.collect()) {
                                if let maxCount {
                                    let sName = String($0.prefix(maxCount))
                                    if text.wrappedValue != sName && (maxCount != 0) {
                                        text.wrappedValue = sName
                                    }
                                }
                            }
                            .truncationMode(truncationMode)
                            .background(Color.clear)
                    }
                    
                    // Trailing icon
                    trailingImage?
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(getTrailingImageForegroundColor())
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 12)
                        .padding(.leading, 20)
                        .padding(.bottom, 5)
                        .onTapGesture {
                            if !isSecureText {
                                trailingImageClick?()
                            } else {
                                secureText.toggle()
                                trailingImage = secureText ? secureTextImageClose : secureTextImageOpen
                            }
                        }
                        .disabled(disable?.wrappedValue ?? false)
                }
                .zIndex(1)
                
                // Bottom line for line border type
                if borderType == .line {
                    Rectangle()
                        .frame(height: getBorderWidth(type: .line))
                        .foregroundColor(getBorderColor())
                }
            }
            .background(
                RoundedRectangle(cornerRadius: getCornerRadius())
                    .stroke(getBorderColor(), lineWidth: getBorderWidth(type: .square))
                    .background(getBackgroundColor().cornerRadius(getCornerRadius()))
                    .zIndex(0)
            )
            
            // Error text
            if let error = error?.wrappedValue {
                if error {
                    Text(errorText?.wrappedValue ?? "")
                        .font(errorFont)
                        .padding(.leading,10)
                        .foregroundColor(getErrorTextColor())
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("")
                        .font(errorFont)
                        .padding(.leading,10)
                        .foregroundColor(getErrorTextColor())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } else {
                Text("")
                    .font(errorFont)
                    .padding(.leading,10)
                    .foregroundColor(getErrorTextColor())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .opacity((disable?.wrappedValue ?? false) ? 0.3: 1.0)
    }
    
    // MARK: - Helper Methods
    
    /// Returns either a secure or regular text field based on the secureText state
    private func secureAnyView() -> AnyView {
        if !secureText {
            return AnyView(
                TextField("", text: text)
                    .accessibilityLabel(placeHolderText)
                    .accessibilityHidden(false)
                    .focused($isTextFieldFocused)
                    .accessibilityIdentifier(accessibilityIdentifier)
            )
        } else {
            return AnyView(
                SecureField("", text: text)
                    .accessibilityLabel(placeHolderText)
                    .accessibilityHidden(false)
                    .focused($isTextFieldFocused)
                    .accessibilityIdentifier(accessibilityIdentifier)
            )
        }
    }
    
    /// Returns the appropriate border color based on the current state
    private func getBorderColor() -> Color {
        if error?.wrappedValue ?? false {
            return getErrorTextColor()
        } else {
            if colorScheme == .light {
                if isFocused && focusedBorderColorEnable {
                    return defaultFocusedBorderColor
                } else {
                    return defaultBorderColor
                }
            } else {
                if isFocused && focusedBorderColorEnable {
                    return darkModeFocusedBorderColor
                } else {
                    return darkModeBorderColor
                }
            }
        }
    }
    
    /// Returns the appropriate background color based on the current color scheme
    private func getBackgroundColor() -> Color {
        return colorScheme == .light ? defaultBackgroundColor : darkModeBackgroundColor
    }
    
    /// Returns the appropriate text color based on the current color scheme
    private func getTextColor() -> Color {
        return colorScheme == .light ? defaultTextColor : darkModeTextColor
    }
    
    /// Returns the appropriate error text color based on the current color scheme
    private func getErrorTextColor() -> Color {
        return colorScheme == .light ? defaultErrorTextColor : darkModeErrorTextColor
    }
    
    /// Returns the appropriate placeholder text color based on the current color scheme
    private func getPlaceHolderTextColor() -> Color {
        return colorScheme == .light ? defaultPlaceHolderTextColor : darkModePlaceHolderTextColor
    }
    
    /// Returns the appropriate title text color based on the current state
    private func getTitleTextColor() -> Color {
        if error?.wrappedValue == true {
            return getErrorTextColor()
        }
        
        if isFocused && focusedBorderColorEnable {
            if colorScheme == .light {
                return defaultFocusedBorderColor
            } else {
                return darkModeFocusedBorderColor
            }
        }
        
        return colorScheme == .light ? defaultTitleColor : darkModeTitleColor
    }
    
    /// Returns the appropriate border width based on the border type
    private func getBorderWidth(type: BorderType) -> CGFloat {
        if type == .square {
            return borderType == .square ? borderWidth : 0.0
        } else {
            return borderWidth
        }
    }
    
    /// Returns the corner radius based on the border type
    private func getCornerRadius() -> CGFloat {
        return borderType == .square ? cornerRadius : 0.0
    }
    
    /// Returns the appropriate trailing image foreground color based on the current color scheme
    private func getTrailingImageForegroundColor() -> Color {
        return colorScheme == .light ? defaultTrailingImageForegroundColor : darkModeTrailingImageForegroundColor
    }
}

extension HDMaterialTextField {
        
    /// Sets the accessibility identifier for the text field.
    /// - Parameter identifier: A unique string identifier for accessibility purposes.
    /// - Returns: A modified text field with the specified accessibility identifier.
    public func setAccessibilityidentifier(_ identifier: String) -> Self {
        var copy = self
        copy.accessibilityIdentifier = identifier
        return copy
    }
    
    /// Sets the text color for light mode.
    /// - Parameter color: The color to use for the text in light mode.
    /// - Returns: A modified text field with the specified text color.
    public func setTextColor(_ color: Color) -> Self {
        var copy = self
        copy.defaultTextColor = color
        return copy
    }
    
    /// Sets the text color for dark mode.
    /// - Parameter color: The color to use for the text in dark mode.
    /// - Returns: A modified text field with the specified dark mode text color.
    public func setDarkModeTextColor(_ color: Color) -> Self {
        var copy = self
        copy.darkModeTextColor = color
        return copy
    }
    
    /// Sets the title text that appears above the text field when focused.
    /// - Parameter titleText: The text to display as the title.
    /// - Returns: A modified text field with the specified title text.
    public func setTitleText(_ titleText: String) -> Self {
        var copy = self
        copy.titleText = titleText
        return copy
    }
    
    /// Sets the title text color for light mode.
    /// - Parameter titleColor: The color to use for the title text in light mode.
    /// - Returns: A modified text field with the specified title color.
    public func setTitleColor(_ titleColor: Color) -> Self {
        var copy = self
        copy.defaultTitleColor = titleColor
        return copy
    }
    
    /// Sets the title text color for dark mode.
    /// - Parameter titleColor: The color to use for the title text in dark mode.
    /// - Returns: A modified text field with the specified dark mode title color.
    public func setDarkModeTitleColor(_ titleColor: Color) -> Self {
        var copy = self
        copy.darkModeTitleColor = titleColor
        return copy
    }
    
    /// Sets the font for the title text.
    /// - Parameter titleFont: The font to use for the title text.
    /// - Returns: A modified text field with the specified title font.
    public func setTitleFont(_ titleFont: Font) -> Self {
        var copy = self
        copy.titleFont = titleFont
        return copy
    }
    
    /// Sets the placeholder text that appears when the text field is empty.
    /// - Parameter placeHolderText: The text to display as the placeholder.
    /// - Returns: A modified text field with the specified placeholder text.
    public func setPlaceHolderText(_ placeHolderText: String) -> Self {
        var copy = self
        copy.placeHolderText = placeHolderText
        return copy
    }
    
    /// Sets the font for the placeholder text.
    /// - Parameter placeHolderFont: The font to use for the placeholder text.
    /// - Returns: A modified text field with the specified placeholder font.
    public func setPlaceHolderFont(_ placeHolderFont: Font) -> Self {
        var copy = self
        copy.placeHolderFont = placeHolderFont
        return copy
    }
    
    /// Sets the placeholder text color for light mode.
    /// - Parameter color: The color to use for the placeholder text in light mode.
    /// - Returns: A modified text field with the specified placeholder text color.
    public func setPlaceHolderTextColor(_ color: Color) -> Self {
        var copy = self
        copy.defaultPlaceHolderTextColor = color
        return copy
    }
    
    /// Sets the placeholder text color for dark mode.
    /// - Parameter color: The color to use for the placeholder text in dark mode.
    /// - Returns: A modified text field with the specified dark mode placeholder text color.
    public func setDarkModePlaceHolderTextColor(_ color: Color) -> Self {
        var copy = self
        copy.darkModePlaceHolderTextColor = color
        return copy
    }
    
    /// Sets the disabled state of the text field.
    /// - Parameter disable: A binding to a boolean that controls whether the text field is disabled.
    /// - Returns: A modified text field with the specified disabled state.
    public func setDisable(_ disable: Binding<Bool>) -> Self {
        var copy = self
        copy.disable = disable
        return copy
    }
    
    /// Sets the disabled state color for light mode.
    /// - Parameter color: The color to use for the disabled state in light mode.
    /// - Returns: A modified text field with the specified disabled color.
    public func setDisableColor(_ color: Color) -> Self {
        var copy = self
        copy.defaultDisableColor = color
        return copy
    }
    
    /// Sets the disabled state color for dark mode.
    /// - Parameter color: The color to use for the disabled state in dark mode.
    /// - Returns: A modified text field with the specified dark mode disabled color.
    public func setDarkModeDisableColor(_ color: Color) -> Self {
        var copy = self
        copy.darkModeDisableColor = color
        return copy
    }
    
    /// Sets the error state and error message for the text field.
    /// - Parameter errorText: A binding to a string that contains the error message.
    /// - Returns: A modified text field with the specified error state and message.
    public func setError(errorText: Binding<String>) -> Self {
        var copy = self
        if errorText.wrappedValue.isEmpty {
            copy.error = Binding.constant(false)
        } else {
            copy.error = Binding.constant(true)
        }
        copy.errorText = errorText
        return copy
    }
    
    /// Sets the error text color for light mode.
    /// - Parameter color: The color to use for the error text in light mode.
    /// - Returns: A modified text field with the specified error text color.
    public func setErrorTextColor(_ color: Color) -> Self {
        var copy = self
        copy.defaultErrorTextColor = color
        return copy
    }
    
    /// Sets the error text color for dark mode.
    /// - Parameter color: The color to use for the error text in dark mode.
    /// - Returns: A modified text field with the specified dark mode error text color.
    public func setDarkModeErrorTextColor(_ color: Color) -> Self {
        var copy = self
        copy.darkModeErrorTextColor = color
        return copy
    }
    
    /// Sets the font for the error text.
    /// - Parameter errorFont: The font to use for the error text.
    /// - Returns: A modified text field with the specified error font.
    public func setErrorFont(_ errorFont: Font) -> Self {
        var copy = self
        copy.errorFont = errorFont
        return copy
    }
    
    /// Sets a trailing icon and its click handler.
    /// - Parameters:
    ///   - image: The image to display as the trailing icon.
    ///   - click: A closure to execute when the trailing icon is tapped.
    /// - Returns: A modified text field with the specified trailing icon and click handler.
    public func setTrailingImage(_ image: Image, click: @escaping (() -> Void)) -> Self {
        var copy = self
        copy._trailingImage = State(initialValue: image)
        copy.trailingImageClick = click
        return copy
    }
    
    /// Sets whether the text field should mask its input (for password fields).
    /// - Parameter secure: A boolean indicating whether the text should be masked.
    /// - Returns: A modified text field with the specified secure text state.
    public func setSecureMasking(_ secure: Bool) -> Self {
        var copy = self
        copy._secureText = State(initialValue: secure)
        if secure {
            copy._trailingImage = State(initialValue: copy.secureTextImageClose)
        }
        copy.isSecureText = secure
        return copy
    }
    
    /// Sets whether the text field should be a secure text field.
    /// - Parameter secure: A boolean indicating whether the text field should be secure.
    /// - Returns: A modified text field with the specified secure state.
    public func setSecureField(_ secure: Bool) -> Self {
        var copy = self
        copy._secureText = State(initialValue: secure)
        copy.isSecureText = secure
        return copy
    }
    
    /// Sets the images to use for the secure text field toggle.
    /// - Parameters:
    ///   - open: The image to show when the text is visible.
    ///   - close: The image to show when the text is masked.
    /// - Returns: A modified text field with the specified secure text images.
    public func setSecureTextImages(open: Image, close: Image) -> Self {
        var copy = self
        copy.secureTextImageOpen = open
        copy.secureTextImageClose = close
        copy._trailingImage = State(initialValue: copy.secureTextImageClose)
        return copy
    }
    
    /// Sets the maximum number of characters allowed in the text field.
    /// - Parameter count: The maximum number of characters allowed, or nil for no limit.
    /// - Returns: A modified text field with the specified character limit.
    public func setMaxCount(_ count: Int?) -> Self {
        var copy = self
        copy.maxCount = count
        return copy
    }
    
    /// Sets the truncation mode for the text field.
    /// - Parameter mode: The truncation mode to use when text overflows.
    /// - Returns: A modified text field with the specified truncation mode.
    public func setTruncateMode(_ mode: Text.TruncationMode) -> Self {
        var copy = self
        copy.truncationMode = mode
        return copy
    }
    
    /// Sets the border color for light mode.
    /// - Parameter color: The color to use for the border in light mode.
    /// - Returns: A modified text field with the specified border color.
    public func setBorderColor(_ color: Color) -> Self {
        var copy = self
        copy.defaultBorderColor = color
        return copy
    }
    
    /// Sets the border color for dark mode.
    /// - Parameter color: The color to use for the border in dark mode.
    /// - Returns: A modified text field with the specified dark mode border color.
    public func setDarkModeBorderColor(_ color: Color) -> Self {
        var copy = self
        copy.darkModeBorderColor = color
        return copy
    }
    
    /// Sets the foreground color for the trailing icon in light mode.
    /// - Parameter color: The color to use for the trailing icon in light mode.
    /// - Returns: A modified text field with the specified trailing icon color.
    public func setTrailingImageForegroundColor(_ color: Color) -> Self {
        var copy = self
        copy.defaultTrailingImageForegroundColor = color
        return copy
    }
    
    /// Sets the foreground color for the trailing icon in dark mode.
    /// - Parameter color: The color to use for the trailing icon in dark mode.
    /// - Returns: A modified text field with the specified dark mode trailing icon color.
    public func setDarkModeTrailingImageForegroundColor(_ color: Color) -> Self {
        var copy = self
        copy.darkModeTrailingImageForegroundColor = color
        return copy
    }
    
    /// Sets whether the focused border color should be enabled.
    /// - Parameter enable: A boolean indicating whether to use the focused border color.
    /// - Returns: A modified text field with the specified focused border color state.
    public func setFocusedBorderColorEnable(_ enable: Bool) -> Self {
        var copy = self
        copy.focusedBorderColorEnable = enable
        return copy
    }
    
    /// Sets the focused border color for light mode.
    /// - Parameter color: The color to use for the focused border in light mode.
    /// - Returns: A modified text field with the specified focused border color.
    public func setFocusedBorderColor(_ color: Color) -> Self {
        var copy = self
        copy.defaultFocusedBorderColor = color
        return copy
    }
    
    /// Sets the focused border color for dark mode.
    /// - Parameter color: The color to use for the focused border in dark mode.
    /// - Returns: A modified text field with the specified dark mode focused border color.
    public func setDarkModeFocusedBorderColor(_ color: Color) -> Self {
        var copy = self
        copy.darkModeFocusedBorderColor = color
        return copy
    }
    
    /// Sets the width of the border.
    /// - Parameter width: The width of the border in points.
    /// - Returns: A modified text field with the specified border width.
    public func setBorderWidth(_ width: CGFloat) -> Self {
        var copy = self
        copy.borderWidth = width
        return copy
    }
    
    /// Sets the background color for light mode.
    /// - Parameter color: The color to use for the background in light mode.
    /// - Returns: A modified text field with the specified background color.
    public func setBackgroundColor(_ color: Color) -> Self {
        var copy = self
        copy.defaultBackgroundColor = color
        return copy
    }
    
    /// Sets the background color for dark mode.
    /// - Parameter color: The color to use for the background in dark mode.
    /// - Returns: A modified text field with the specified dark mode background color.
    public func setDarkModeBackgroundColor(_ color: Color) -> Self {
        var copy = self
        copy.darkModeBackgroundColor = color
        return copy
    }
    
    /// Sets the corner radius of the text field.
    /// - Parameter radius: The corner radius in points.
    /// - Returns: A modified text field with the specified corner radius.
    public func setCornerRadius(_ radius: CGFloat) -> Self {
        var copy = self
        copy.cornerRadius = radius
        return copy
    }
    
    /// Sets the border type of the text field.
    /// - Parameter type: The border type to use.
    /// - Returns: A modified text field with the specified border type.
    public func setBorderType(_ type: BorderType) -> Self {
        var copy = self
        copy.borderType = type
        return copy
    }
    
    /// Sets whether autocorrection should be disabled.
    /// - Parameter disable: A boolean indicating whether to disable autocorrection.
    /// - Returns: A modified text field with the specified autocorrection state.
    public func setDisableAutoCorrection(_ disable: Bool) -> Self {
        var copy = self
        copy.disableAutoCorrection = disable
        return copy
    }
    
    /// Sets the height of the text field.
    /// - Parameter height: The height of the text field in points.
    /// - Returns: A modified text field with the specified height.
    public func setTextFieldHeight(_ height: CGFloat) -> Self {
        var copy = self
        copy.textFieldHeight = height
        return copy
    }
    
    /// Sets the left icon and its properties.
    /// - Parameters:
    ///   - leftIconImage: A binding to an optional image for the left icon.
    ///   - frame: The size of the left icon.
    ///   - color: The color of the left icon.
    ///   - onTap: A closure to execute when the left icon is tapped.
    /// - Returns: A modified text field with the specified left icon and properties.
    public func setLeftIcon(_ leftIconImage: Binding<Image?>?, frame: CGSize = CGSize(width: 25, height: 25), color: Color? = nil, onTap: (() -> Void)? = nil) -> Self {
        var copy = self
        if let leftIconImage = leftIconImage {
            copy._leftImage = leftIconImage
            copy.onTapLeftIcon = onTap
            copy.leftIconFrame = frame
            copy.leftIconColor = color
        }
        return copy
    }
    
    /// Sets the keyboard type for the text field.
    /// - Parameter keyboardType: The keyboard type to use.
    /// - Returns: A modified text field with the specified keyboard type.
    public func setKeyboardType(_ keyboardType: UIKeyboardType) -> Self {
        var copy = self
        copy._keyBoardType = State(initialValue: keyboardType)
        return copy
    }
    
    /// Sets the accessibility label for the left image.
    /// - Parameter label: The accessibility label to use for the left image.
    /// - Returns: A modified text field with the specified left image accessibility label.
    public func setLeftImageAccesiblityLabel(label: String) -> Self {
        var copy = self
        copy.leftImageAccesiblityLabel = label
        return copy
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    ScrollView {
        Spacer()
            .frame(height: 100)
        HDMaterialTextField(text: .constant(""))
            .setTitleText("TextField2")
            .setPlaceHolderText("Enter Text 2")
            .setBorderType(.square)
            .setSecureField(false)
            .padding()
    }
}
