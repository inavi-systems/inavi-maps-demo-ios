import SwiftUI
import iNaviMaps

private final class INVMarkerOverlapStore {
    var mapRef: InaviMapView?
    var markers: [INVMarker] = []
}

struct INVMarkerOverlapView: View {
    @State private var store = INVMarkerOverlapStore()
    @State private var allowMarker = false
    @State private var allowTitle = false
    @State private var allowSymbol = false
    @State private var animation = true

    private let markerImages: [INVImage] = [
        INV_MARKER_IMAGE_RED, INV_MARKER_IMAGE_GREEN, INV_MARKER_IMAGE_BLUE,
        INV_MARKER_IMAGE_YELLOW, INV_MARKER_IMAGE_GRAY,
    ]

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                let bounds = mapView.contentBounds
                var arr: [INVMarker] = []
                for index in 1...50 {
                    let m = INVMarker(position: INVLatLng(
                        lat: (bounds.northEast.lat - bounds.southWest.lat) * drand48() + bounds.southWest.lat,
                        lng: (bounds.northEast.lng - bounds.southWest.lng) * drand48() + bounds.southWest.lng
                    ))
                    let idx = Int(arc4random_uniform(UInt32(markerImages.count)))
                    m.iconImage = markerImages[idx]
                    m.title = "마커 #\(index)"
                    m.mapView = mapView
                    arr.append(m)
                }
                store.markers = arr
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("마커 겹침 허용", isOn: $allowMarker)
                    .onChange(of: allowMarker) { v in store.markers.forEach { $0.isAllowOverlapMarkers = v } }
                Toggle("타이틀 겹침 허용", isOn: $allowTitle)
                    .onChange(of: allowTitle) { v in store.markers.forEach { $0.isAllowOverlapTitle = v } }
                Toggle("심벌 겹침 허용", isOn: $allowSymbol)
                    .onChange(of: allowSymbol) { v in store.markers.forEach { $0.isAllowOverlapSymbols = v } }
                Toggle("애니메이션", isOn: $animation)
                    .onChange(of: animation) { v in store.markers.forEach { $0.isTransitionEnabled = v } }
            }
        }
        .navigationTitle("INVMarker Overlap")
        .navigationBarTitleDisplayMode(.inline)
    }
}
