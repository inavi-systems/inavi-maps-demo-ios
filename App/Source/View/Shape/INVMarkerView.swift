import SwiftUI
import iNaviMaps

private final class INVMarkerStore {
    var mapRef: InaviMapView?
    var markers: [INVMarker] = []
}

struct INVMarkerView: View {
    @State private var store = INVMarkerStore()
    @State private var hidden = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                store.markers = makeMarkers(on: mapView)
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("마커 숨김", isOn: $hidden)
                    .onChange(of: hidden) { on in
                        store.markers.forEach { $0.mapView = on ? nil : store.mapRef }
                    }
            }
        }
        .navigationTitle("INVMarker")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func makeMarkers(on mapView: InaviMapView) -> [INVMarker] {
        let m1 = INVMarker()
        m1.position = INVLatLng(lat: 37.40219, lng: 127.11077)
        m1.title = "타이틀"
        m1.mapView = mapView

        let m2 = INVMarker()
        m2.position = INVLatLng(lat: 37.40465, lng: 127.10986)
        if let img = UIImage(named: "inv_marker_right_bottom") {
            m2.iconImage = INVImage(image: img)
            m2.anchor = CGPoint(x: 0.9, y: 0.9)
            m2.angle = 90
        }
        m2.mapView = mapView

        let m3 = INVMarker()
        m3.position = INVLatLng(lat: 37.40274, lng: 127.10806)
        m3.iconImage = INV_MARKER_IMAGE_BLUE
        m3.titleColor = .green
        m3.title = "타이틀 색상 적용"
        m3.mapView = mapView

        let m4 = INVMarker()
        m4.position = INVLatLng(lat: 37.39990, lng: 127.10965)
        m4.iconImage = INV_MARKER_IMAGE_YELLOW
        m4.titleSize = 16
        m4.title = "타이틀 크기 적용"
        m4.mapView = mapView

        let m5 = INVMarker()
        m5.position = INVLatLng(lat: 37.40324, lng: 127.11276)
        m5.iconImage = INV_MARKER_IMAGE_GREEN
        m5.alpha = 0.5
        m5.title = "반투명 마커"
        m5.mapView = mapView

        let m6 = INVMarker()
        m6.position = INVLatLng(lat: 37.40058, lng: 127.11231)
        m6.iconImage = INVImage(name: "baseline_star_black_24pt")
        m6.iconScale = 2.0
        m6.anchor = CGPoint(x: 0.5, y: 0.5)
        m6.mapView = mapView

        return [m1, m2, m3, m4, m5, m6]
    }
}
