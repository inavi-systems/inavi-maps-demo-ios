import SwiftUI
import iNaviMaps

private final class MapControllerStore {
    var mapRef: InaviMapView?
}

struct MapControllerView: View {
    @State private var store = MapControllerStore()
    @State private var compass = true
    @State private var scaleBar = true
    @State private var zoomControl = true
    @State private var locationButton = true

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                mapView.moveCamera(INVCameraUpdate(bearingTo: 45))
                mapView.showZoomControl = true
                mapView.showLocationButton = true
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("나침반", isOn: $compass)
                    .onChange(of: compass) { store.mapRef?.showCompass = $0 }
                Toggle("스케일바", isOn: $scaleBar)
                    .onChange(of: scaleBar) { store.mapRef?.showScaleBar = $0 }
                Toggle("줌 컨트롤", isOn: $zoomControl)
                    .onChange(of: zoomControl) { store.mapRef?.showZoomControl = $0 }
                Toggle("내 위치 버튼", isOn: $locationButton)
                    .onChange(of: locationButton) { store.mapRef?.showLocationButton = $0 }
            }
        }
        .navigationTitle("Map Controller")
        .navigationBarTitleDisplayMode(.inline)
    }
}
