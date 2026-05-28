import SwiftUI
import iNaviMaps

private final class MapLanguageStore {
    var mapRef: InaviMapView?
}

struct MapLanguageView: View {
    private struct LanguageOption: Identifiable, Hashable {
        let label: String
        let code: String
        var id: String { code }
    }

    private static let options: [LanguageOption] = [
        LanguageOption(label: "한국어", code: "ko"),
        LanguageOption(label: "English", code: "en"),
        LanguageOption(label: "日本語", code: "ja"),
        LanguageOption(label: "中文", code: "zh"),
    ]

    @State private var store = MapLanguageStore()
    @State private var selectedCode: String = ""

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                let current = mapView.language
                DispatchQueue.main.async {
                    selectedCode = current
                }
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                HStack {
                    Text("언어 :")
                    Spacer()
                    Picker("언어", selection: $selectedCode) {
                        ForEach(Self.options) { option in
                            Text(option.label).tag(option.code)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: selectedCode) { code in
                        store.mapRef?.language = code
                    }
                }
            }
        }
        .navigationTitle("Map Language")
        .navigationBarTitleDisplayMode(.inline)
    }
}
