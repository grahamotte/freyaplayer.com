import SwiftUI

struct FeatureStubView: View {
    let title: String
    let message: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: AppTheme.Spacing.xLarge) {
            Spacer()

            VStack(alignment: .leading, spacing: AppTheme.Spacing.medium) {
                Button("Back to Libraries") {
                    dismiss()
                }

                Text(title)
                    .font(PlatformMetadata.sectionTitleFont)

                Text(message)
                    .foregroundStyle(AppTheme.secondaryText)
            }
            .frame(maxWidth: 720, alignment: .leading)
            .padding(PlatformMetadata.panelPadding)
            .background(PanelBackground())

            Spacer()
        }
        .padding(PlatformMetadata.pageGutter)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppBackground())
        .navigationTitle(title)
    }
}
