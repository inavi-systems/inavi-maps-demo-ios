import SwiftUI
import iNaviMaps

private final class GlobalZIndexStore {
    var mapRef: InaviMapView?
    var polyline: INVPolyline?
}

struct GlobalZIndexView: View {
    @State private var store = GlobalZIndexStore()
    @State private var polylineBelow = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                mapView.moveCamera(INVCameraUpdate(position: INVCameraPosition(INVLatLng(lat: 37.40219, lng: 127.11077), zoom: 14.0)))

                let circle = INVCircle()
                circle.center = INVLatLng(lat: 37.40219, lng: 127.11077)
                circle.radius = 500
                circle.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
                circle.strokeColor = .red
                circle.strokeWidth = 3
                circle.mapView = mapView

                let pl = INVPolyline()
                pl.coords = [INVLatLng(lat: 37.40915, lng: 127.11400),
                             INVLatLng(lat: 37.40465, lng: 127.10986),
                             INVLatLng(lat: 37.40071, lng: 127.11590),
                             INVLatLng(lat: 37.39945, lng: 127.10839),
                             INVLatLng(lat: 37.39492, lng: 127.11127)]
                pl.color = .blue
                pl.width = 3
                pl.mapView = mapView
                store.polyline = pl
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("폴리라인을 원 아래로", isOn: $polylineBelow)
                    .onChange(of: polylineBelow) { on in
                        store.polyline?.globalZIndex = Int(INV_CIRCLE_DEFAULT_GLOBAL_Z_INDEX) + (on ? -1 : 1)
                    }
            }
        }
        .navigationTitle("Global Z-Index")
        .navigationBarTitleDisplayMode(.inline)
    }
}
