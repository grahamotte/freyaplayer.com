import SwiftUI

struct MediaProviderLabel: View {
    let providerID: MediaProviderID
    var logoSize: CGFloat = 32

    var body: some View {
        HStack(spacing: AppTheme.Spacing.small) {
            Image(providerID.title)
                .resizable()
                .scaledToFit()
                .frame(width: logoSize, height: logoSize)
                .accessibilityHidden(true)

            Text(providerID.title)
        }
    }
}
