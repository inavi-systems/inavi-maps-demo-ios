import SwiftUI
import iNaviMaps

private final class INVPolygonStore {
    var mapRef: InaviMapView?
    var polygons: [INVPolygon] = []
}

struct INVPolygonView: View {
    @State private var store = INVPolygonStore()
    @State private var hidden = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                mapView.moveCamera(INVCameraUpdate(position: INVCameraPosition(INVLatLng(lat: 37.40219, lng: 127.11077), zoom: 14.0)))

                let p1 = INVPolygon()
                p1.coords = [INVLatLng(lat: 37.41014, lng: 127.11011),
                             INVLatLng(lat: 37.40915, lng: 127.11400),
                             INVLatLng(lat: 37.40538, lng: 127.11440),
                             INVLatLng(lat: 37.40465, lng: 127.10986),
                             INVLatLng(lat: 37.40755, lng: 127.10610)]
                p1.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
                p1.strokeColor = .blue
                p1.strokeWidth = 3
                p1.mapView = mapView

                let p2 = INVPolygon(coords: [INVLatLng(lat: 37.39945, lng: 127.10839),
                                             INVLatLng(lat: 37.40071, lng: 127.11590),
                                             INVLatLng(lat: 37.39395, lng: 127.11575),
                                             INVLatLng(lat: 37.39554, lng: 127.10827)],
                                    fill: UIColor(red: 1, green: 1, blue: 0, alpha: 0.5))
                p2.strokeColor = .black
                p2.strokeWidth = 3
                p2.mapView = mapView

                store.polygons = [p1, p2]
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("폴리곤 숨김", isOn: $hidden)
                    .onChange(of: hidden) { on in
                        store.polygons.forEach { $0.mapView = on ? nil : store.mapRef }
                    }
            }
        }
        .navigationTitle("INVPolygon")
        .navigationBarTitleDisplayMode(.inline)
    }
}
