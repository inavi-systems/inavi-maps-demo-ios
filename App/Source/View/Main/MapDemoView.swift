import SwiftUI
import iNaviMaps

private final class MapDemoStore {
    var mapRef: InaviMapView?
}

struct MapDemoView: View {
    @State private var store = MapDemoStore()

    var body: some View {
        InaviMapViewRepresentable(onMapViewReady: { store.mapRef = $0 })
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("InaviMapView")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Menu {
                    Button("Normal") { store.mapRef?.mapType = .normal }
                    Button("Hybrid") { store.mapRef?.mapType = .hybrid }
                    Button("Satellite") { store.mapRef?.mapType = .satellite }
                } label: {
                    Text("지도 타입")
                        .foregroundColor(.white)
                }
            )
    }
}
