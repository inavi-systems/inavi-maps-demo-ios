import SwiftUI
import iNaviMaps

private final class ProjectionStore {
    var mapRef: InaviMapView?
}

struct ProjectionView: View {
    @State private var store = ProjectionStore()
    @State private var screenPointText = "화면상 좌표 : -"
    @State private var latLngText = "지도상 좌표 : -"

    var body: some View {
        GeometryReader { geo in
            ZStack {
                InaviMapViewRepresentable(
                    onMapViewReady: { mapView in
                        store.mapRef = mapView
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            updateInfo(geo: geo)
                        }
                    },
                    onRegionWillChange: { _, _ in updateInfo(geo: geo) },
                    onRegionIsChanging: { _ in updateInfo(geo: geo) },
                    onRegionDidChange: { _, _ in updateInfo(geo: geo) }
                )
                .edgesIgnoringSafeArea(.bottom)

                Image("crosshair")
                    .allowsHitTesting(false)

                DemoOverlayPanel(alignment: .top) {
                    Text(screenPointText).font(.system(size: 13, design: .monospaced))
                    Text(latLngText).font(.system(size: 13, design: .monospaced))
                }
            }
        }
        .navigationTitle("Projection")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func updateInfo(geo: GeometryProxy) {
        guard let mapView = store.mapRef else { return }
        let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
        let latLng = mapView.projection.latlng(from: center)
        screenPointText = String(format: "화면상 좌표 : (%.1f, %.1f)", center.x, center.y)
        latLngText = String(format: "지도상 좌표 : (%.5f, %.5f)", latLng.lat, latLng.lng)
    }
}
