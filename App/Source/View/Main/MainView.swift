import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(AppMenu.sections) { section in
                    Section(header: Text(section.header)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: item.destination()) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(item.title)
                                        .font(.system(size: 17))
                                    Text(item.subtitle)
                                        .font(.system(size: 12))
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("iNavi Maps Demo")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}
