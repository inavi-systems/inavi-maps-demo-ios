import SwiftUI
import iNaviMaps

private final class INVPolylineStore {
    var mapRef: InaviMapView?
    var polylines: [INVPolyline] = []
}

struct INVPolylineView: View {
    @State private var store = INVPolylineStore()
    @State private var hidden = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                mapView.moveCamera(INVCameraUpdate(position: INVCameraPosition(INVLatLng(lat: 37.40219, lng: 127.11077), zoom: 14.0)))

                let p1 = INVPolyline()
                p1.coords = [INVLatLng(lat: 37.40915, lng: 127.11400),
                             INVLatLng(lat: 37.40465, lng: 127.10986),
                             INVLatLng(lat: 37.40071, lng: 127.11590),
                             INVLatLng(lat: 37.39945, lng: 127.10839)]
                p1.color = .red
                p1.width = 3
                p1.mapView = mapView

                let p2 = INVPolyline(coords: [INVLatLng(lat: 37.39945, lng: 127.10839),
                                              INVLatLng(lat: 37.39492, lng: 127.11127)])
                p2.color = .blue
                p2.pattern = [10, 10]
                p2.width = 3
                p2.mapView = mapView

                store.polylines = [p1, p2]
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("폴리라인 숨김", isOn: $hidden)
                    .onChange(of: hidden) { on in
                        store.polylines.forEach { $0.mapView = on ? nil : store.mapRef }
                    }
            }
        }
        .navigationTitle("INVPolyline")
        .navigationBarTitleDisplayMode(.inline)
    }
}
