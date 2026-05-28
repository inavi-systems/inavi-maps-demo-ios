import SwiftUI
import iNaviMaps

private final class MapSymbolScaleStore {
    var mapRef: InaviMapView?
}

struct MapSymbolScaleView: View {
    @State private var store = MapSymbolScaleStore()
    @State private var enlarge = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { store.mapRef = $0 })
                .edgesIgnoringSafeArea(.bottom)
            DemoOverlayPanel(alignment: .bottom) {
                Toggle("심벌 크기 1.5배", isOn: $enlarge)
                    .onChange(of: enlarge) { on in
                        store.mapRef?.symbolScale = on ? 1.5 : 1.0
                    }
            }
        }
        .navigationTitle("Map Symbol Scale")
        .navigationBarTitleDisplayMode(.inline)
    }
}
