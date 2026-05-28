import SwiftUI
import iNaviMaps

private final class INVCircleStore {
    var mapRef: InaviMapView?
    var circles: [INVCircle] = []
}

struct INVCircleView: View {
    @State private var store = INVCircleStore()
    @State private var hidden = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                mapView.moveCamera(INVCameraUpdate(position: INVCameraPosition(INVLatLng(lat: 37.40069, lng: 127.11077), zoom: 14.0)))

                let c1 = INVCircle()
                c1.center = INVLatLng(lat: 37.40219, lng: 127.11077)
                c1.radius = 300
                c1.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
                c1.strokeColor = .red
                c1.strokeWidth = 3
                c1.mapView = mapView

                let c2 = INVCircle()
                c2.center = INVLatLng(lat: 37.39478, lng: 127.11116)
                c2.radius = 200
                c2.fillColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
                c2.strokeColor = .green
                c2.strokeWidth = 3
                c2.mapView = mapView

                store.circles = [c1, c2]
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("원 숨김", isOn: $hidden)
                    .onChange(of: hidden) { on in
                        store.circles.forEach { $0.mapView = on ? nil : store.mapRef }
                    }
            }
        }
        .navigationTitle("INVCircle")
        .navigationBarTitleDisplayMode(.inline)
    }
}
