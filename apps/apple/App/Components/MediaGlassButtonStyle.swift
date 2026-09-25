import SwiftUI

struct MediaGlassButtonStyle: ButtonStyle {
    enum Size {
        case regular
        case compact
        case square
        case bare

        var horizontalPadding: CGFloat {
            switch self {
            case .regular: 28
            case .compact: PlatformMetadata.isPhone ? 16 : 24
            case .square: 14
            case .bare: 0
            }
        }

        var verticalPadding: CGFloat {
            switch self {
            case .regular, .compact: 16
            case .square: 14
            case .bare: 0
            }
        }
    }

    enum Role {
        case standard
        case tinted(Color)
        case destructive

        var tint: Color? {
            switch self {
            case .standard: nil
            case .tinted(let color): color
            case .destructive: AppTheme.destructive
            }
        }
    }

    var size: Size = .regular
    var role: Role = .standard

    func makeBody(configuration: Configuration) -> some View {
        MediaGlassButtonBody(
            configuration: configuration,
            tint: role.tint,
            horizontalPadding: size.horizontalPadding,
            verticalPadding: size.verticalPadding
        )
    }
}

private struct MediaGlassButtonBody: View {
    let configuration: ButtonStyle.Configuration
    let tint: Color?
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    @Environment(\.isFocused) private var isFocused
    @Environment(\.isEnabled) private var isEnabled

    var body: some View {
        configuration.label
            .font(Self.font)
            .foregroundStyle(isFocused ? AppTheme.inverseText : AppTheme.primaryText)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.Radius.control, style: .continuous))
            .scaleEffect(configuration.isPressed ? AppTheme.pressedScale : 1)
            .opacity(isEnabled ? 1 : AppTheme.disabledOpacity)
    }

    private var background: some View {
        RoundedRectangle(cornerRadius: AppTheme.Radius.control, style: .continuous)
            .fill(isFocused ? AppTheme.focusFill : fillColor)
            .overlay {
                if !isFocused {
                    RoundedRectangle(cornerRadius: AppTheme.Radius.control, style: .continuous)
                        .stroke(strokeColor, lineWidth: 1)
                }
            }
    }

    private var fillColor: Color {
        tint.map { $0.opacity(AppTheme.tintedFillOpacity) } ?? AppTheme.glassFill
    }

    private var strokeColor: Color {
        tint.map { $0.opacity(AppTheme.tintedStrokeOpacity) } ?? AppTheme.glassStroke
    }

    private static var font: Font {
        PlatformMetadata.controlFont
    }
}
