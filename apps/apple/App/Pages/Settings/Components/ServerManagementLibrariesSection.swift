import SwiftUI

struct ServerManagementLibrariesSection: View {
    let libraries: [LibraryShelf]
    let onToggleVisibility: (Int, Bool) -> Void
    let onMoveLibrary: (Int, Int) -> Void

    var body: some View {
        ServerManagementSection("Libraries") {
            VStack(spacing: AppTheme.Spacing.small) {
                ForEach(Array(libraries.enumerated()), id: \.element.id) { index, library in
                    ServerManagementLibraryRow(
                        title: library.title,
                        isHidden: library.isHidden,
                        canMoveUp: index > 0,
                        canMoveDown: index < libraries.count - 1,
                        onToggleVisibility: {
                            onToggleVisibility(index, !library.isHidden)
                        },
                        onMoveUp: {
                            onMoveLibrary(index, -1)
                        },
                        onMoveDown: {
                            onMoveLibrary(index, 1)
                        }
                    )
                }
            }
        }
    }
}

private struct ServerManagementLibraryRow: View {
    let title: String
    let isHidden: Bool
    let canMoveUp: Bool
    let canMoveDown: Bool
    let onToggleVisibility: () -> Void
    let onMoveUp: () -> Void
    let onMoveDown: () -> Void

    var body: some View {
        Group {
            if PlatformMetadata.isPhone {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.small) {
                    titleText
                    HStack(spacing: AppTheme.Spacing.medium) {
                        rowButtons
                        Spacer(minLength: 0)
                        eyeButton
                    }
                }
            } else {
                HStack(spacing: AppTheme.Spacing.medium) {
                    rowButtons
                    titleText
                    Spacer(minLength: 0)
                    eyeButton
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var titleText: some View {
        Text(title)
            .font(.body.weight(.medium))
            .lineLimit(1)
            .strikethrough(isHidden, color: AppTheme.secondaryText)
            .foregroundStyle(isHidden ? AppTheme.secondaryText : AppTheme.primaryText)
    }

    private var rowButtons: some View {
        Group {
            Button(action: onMoveUp) {
                rowIcon("arrow.up")
            }
            .buttonStyle(rowButtonStyle)
            .disabled(!canMoveUp)

            Button(action: onMoveDown) {
                rowIcon("arrow.down")
            }
            .buttonStyle(rowButtonStyle)
            .disabled(!canMoveDown)
        }
    }

    private var eyeButton: some View {
        Button(action: onToggleVisibility) {
            rowIcon(isHidden ? "eye.slash" : "eye")
        }
        .buttonStyle(rowButtonStyle)
    }

    private var rowButtonStyle: MediaGlassButtonStyle {
        MediaGlassButtonStyle(size: .square)
    }

    private func rowIcon(_ systemName: String) -> some View {
        Image(systemName: systemName)
            .font(PlatformMetadata.controlFont)
            .frame(width: AppTheme.Spacing.large, height: AppTheme.Spacing.large)
    }
}
