import SwiftUI

struct ServerManagementServerSection: View {
    let server: ConnectedServer
    let onDeactivate: () -> Void

    var body: some View {
        ServerManagementSection("Server") {
            VStack(alignment: .leading, spacing: AppTheme.Spacing.small) {
                Text(server.serverName)
                    .font(.headline)

                Text("\(server.serverURL) (\(server.providerID.title))")
                    .foregroundStyle(AppTheme.secondaryText)

                if PlatformMetadata.isPhone {
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.small) {
                        actionButtons
                    }
                } else {
                    HStack(spacing: AppTheme.Spacing.small) {
                        actionButtons
                    }
                }
            }
        }
    }

    private var actionButtons: some View {
        Group {
            Button("Deactivate") {
                onDeactivate()
            }
            .buttonStyle(MediaGlassButtonStyle(role: .destructive))
        }
    }
}
