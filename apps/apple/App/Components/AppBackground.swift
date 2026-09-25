import SwiftUI

struct AppBackground: View {
    var body: some View {
        LinearGradient(
            colors: [AppTheme.backgroundTop, AppTheme.backgroundBottom],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct PanelBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AppTheme.Radius.panel, style: .continuous)
            .fill(AppTheme.surfaceFill)
            .overlay {
                RoundedRectangle(cornerRadius: AppTheme.Radius.panel, style: .continuous)
                    .strokeBorder(AppTheme.surfaceBorder, lineWidth: 1)
            }
    }
}
