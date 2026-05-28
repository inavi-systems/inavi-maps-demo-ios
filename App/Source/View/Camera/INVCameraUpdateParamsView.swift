import SwiftUI
import iNaviMaps

private final class INVCameraUpdateParamsStore {
    var mapRef: InaviMapView?
    var isInitPosition = true
}

struct INVCameraUpdateParamsView: View {
    @State private var store = INVCameraUpdateParamsStore()
    @State private var updateTarget = false
    @State private var updateZoom = true
    @State private var updateTilt = true
    @State private var updateBearing = true

    private let position1 = INVLatLng(lat: 37.40219, lng: 127.11077)
    private let position2 = INVLatLng(lat: 36.99473, lng: 127.81832)
    private let maximumTilt: Double = 60.0

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                INVMarker(position: position1).mapView = mapView
                INVMarker(position: position2, iconImage: INV_MARKER_IMAGE_BLUE).mapView = mapView
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("Target", isOn: $updateTarget)
                Toggle("Zoom", isOn: $updateZoom)
                Toggle("Tilt", isOn: $updateTilt)
                Toggle("Bearing", isOn: $updateBearing)
                Button("카메라 이동") {
                    runCameraUpdate()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(6)
            }
        }
        .navigationTitle("INVCameraUpdateParams")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func runCameraUpdate() {
        guard let mapView = store.mapRef else { return }
        let params = INVCameraUpdateParams()
        let cp = mapView.cameraPosition
        var duration = 1.0
        if updateTarget {
            params.target(to: store.isInitPosition ? position2 : position1)
            store.isInitPosition.toggle()
            duration = 5.0
        }
        if updateZoom {
            var zoomDelta = 3.0
            if cp.zoom + zoomDelta >= mapView.maximumZoomLevel { zoomDelta *= -1 }
            params.zoom(by: zoomDelta)
        }
        if updateTilt {
            var tiltDelta = 10.0
            if cp.tilt + tiltDelta >= maximumTilt { tiltDelta *= -1 }
            params.tilt(by: tiltDelta)
        }
        if updateBearing {
            params.bearing(by: 30)
        }
        let cu = INVCameraUpdate(params: params)
        cu.animation = .fly
        cu.animationDuration = duration
        mapView.moveCamera(cu)
    }
}
