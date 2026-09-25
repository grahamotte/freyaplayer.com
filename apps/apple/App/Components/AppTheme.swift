import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

enum AppTheme {
    static let backgroundTop = Color(red: 0.08, green: 0.09, blue: 0.12)
    static let backgroundBottom = Color(red: 0.04, green: 0.05, blue: 0.07)

    static let primaryText = Color.white
    static let secondaryText = Color.white.opacity(0.72)
    static let inverseText = Color.black

    static let surfaceFill = Color.white.opacity(0.08)
    static let surfaceBorder = Color.white.opacity(0.12)
    static let subtleSurfaceFill = Color.white.opacity(0.05)
    static let emphasizedSurfaceFill = Color.white.opacity(0.16)

    static let glassFill = Color.white.opacity(0.12)
    static let glassStroke = Color.white.opacity(0.28)
    static let focusFill = primaryText
    static let focusStroke = primaryText.opacity(0.8)
    static let tintedFillOpacity = 0.18
    static let tintedStrokeOpacity = 0.4

    static let scrim = Color.black.opacity(0.4)
    static let modalScrim = Color.black.opacity(0.5)
    static let artworkShadow = Color.black.opacity(0.35)

    static let disabledOpacity = 0.45
    static let pressedScale = 0.98
    static let focusedCardScale = 1.02
    static let focusAnimation = Animation.easeOut(duration: 0.16)

#if canImport(UIKit)
    static let uiSeen = UIColor.systemYellow
    static let uiPrimaryText = UIColor.white
    static let uiSecondaryText = UIColor.white.withAlphaComponent(0.72)
    static let uiInverseText = UIColor.black
    static let uiSurfaceFill = UIColor.white.withAlphaComponent(0.08)
    static let uiGlassFill = UIColor.white.withAlphaComponent(0.12)
    static let uiGlassStroke = UIColor.white.withAlphaComponent(0.28)
    static let uiDisabledGlassStroke = UIColor.white.withAlphaComponent(0.1)

    static let seen = Color(uiColor: uiSeen)
#endif
    static let warning = Color.orange
    static let positive = Color.green
    static let destructive = Color.red

    enum Radius {
        static let inline: CGFloat = 16
        static let card: CGFloat = 20
        static let large: CGFloat = 28
        static let panel: CGFloat = 34
        static let control: CGFloat = 36

        static var artwork: CGFloat {
            PlatformMetadata.isTV ? 24 : 18
        }
    }

    enum Spacing {
        static let xxSmall: CGFloat = 4
        static let xSmall: CGFloat = 8
        static let small: CGFloat = 12
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let xLarge: CGFloat = 32
        static let xxLarge: CGFloat = 48
    }
}

extension AppTheme {
#if canImport(UIKit)
    static func uiGlassForeground(isFocused: Bool, isEnabled: Bool = true) -> UIColor {
        if !isEnabled {
            return uiSecondaryText.withAlphaComponent(disabledOpacity)
        }
        return isFocused ? uiInverseText : uiPrimaryText
    }

    static var uiGlassContentInsets: NSDirectionalEdgeInsets {
        let size = MediaGlassButtonStyle.Size.regular
        return NSDirectionalEdgeInsets(
            top: size.verticalPadding,
            leading: size.horizontalPadding,
            bottom: size.verticalPadding,
            trailing: size.horizontalPadding
        )
    }

    static func applyGlassBackground(
        to background: inout UIBackgroundConfiguration,
        isFocused: Bool,
        isEnabled: Bool = true
    ) {
        background.cornerRadius = Radius.control
        background.backgroundColor = isFocused ? uiPrimaryText : uiGlassFill
        background.strokeColor = isFocused ? .clear : isEnabled ? uiGlassStroke : uiDisabledGlassStroke
        background.strokeWidth = isFocused ? 0 : 1
    }
#endif
}

private struct AppChromeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(.dark)
            .foregroundStyle(AppTheme.primaryText)
    }
}

private struct GlassFieldModifier: ViewModifier {
    let isFocused: Bool

    func body(content: Content) -> some View {
        content
            .background(AppTheme.surfaceFill)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.Radius.inline, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: AppTheme.Radius.inline, style: .continuous)
                    .stroke(
                        isFocused ? AppTheme.focusStroke : AppTheme.surfaceBorder,
                        lineWidth: isFocused ? 2 : 1
                    )
            }
    }
}

private struct FocusSurfaceModifier<Background: ShapeStyle>: ViewModifier {
    let isFocused: Bool
    let restingFill: Background
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(isFocused ? AnyShapeStyle(AppTheme.emphasizedSurfaceFill) : AnyShapeStyle(restingFill))
            }
            .scaleEffect(isFocused && PlatformMetadata.isTV ? AppTheme.focusedCardScale : 1)
            .animation(AppTheme.focusAnimation, value: isFocused)
    }
}

struct MediaSurfaceButtonStyle<Background: ShapeStyle>: ButtonStyle {
    let restingFill: Background
    var cornerRadius: CGFloat = AppTheme.Radius.card

    func makeBody(configuration: Configuration) -> some View {
        MediaSurfaceButtonBody(configuration: configuration, restingFill: restingFill, cornerRadius: cornerRadius)
    }
}

private struct MediaSurfaceButtonBody<Background: ShapeStyle>: View {
    let configuration: ButtonStyle.Configuration
    let restingFill: Background
    let cornerRadius: CGFloat
    @Environment(\.isFocused) private var isFocused

    var body: some View {
        configuration.label
            .foregroundStyle(AppTheme.primaryText)
            .focusSurface(isFocused: isFocused, restingFill: restingFill, cornerRadius: cornerRadius)
            .scaleEffect(configuration.isPressed ? AppTheme.pressedScale : 1)
    }
}

extension View {
    func appChrome() -> some View {
        modifier(AppChromeModifier())
    }

    func glassField(isFocused: Bool) -> some View {
        modifier(GlassFieldModifier(isFocused: isFocused))
    }

    func focusSurface<Background: ShapeStyle>(
        isFocused: Bool,
        restingFill: Background,
        cornerRadius: CGFloat = AppTheme.Radius.card
    ) -> some View {
        modifier(FocusSurfaceModifier(isFocused: isFocused, restingFill: restingFill, cornerRadius: cornerRadius))
    }
}
