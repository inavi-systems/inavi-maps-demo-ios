import SwiftUI

struct DemoOverlayPanel<Content: View>: View {
    let alignment: Alignment
    let content: () -> Content

    init(alignment: Alignment = .bottom,
         @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            content()
        }
        .padding(12)
        .background(Color(.systemBackground).opacity(0.9))
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}
