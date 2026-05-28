import SwiftUI
import iNaviMaps

private final class CameraFitBoundsStore {
    var mapRef: InaviMapView?
    var isInitPosition = true
}

struct CameraFitBoundsView: View {
    @State private var store = CameraFitBoundsStore()
    @State private var buttonImage = "baseline_control_camera_white_24pt"

    private let position1 = INVLatLng(lat: 37.40219, lng: 127.11077)
    private let position2 = INVLatLng(lat: 36.99473, lng: 127.81832)

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(
                onMapViewReady: { mapView in
                    store.mapRef = mapView
                    INVMarker(position: position1).mapView = mapView
                    INVMarker(position: position2, iconImage: INV_MARKER_IMAGE_BLUE).mapView = mapView
                },
                onRegionIsChanging: { reason in
                    if store.isInitPosition && reason == INV_CAMERA_UPDATE_REASON_GESTURE {
                        store.isInitPosition = false
                        buttonImage = "baseline_replay_white_24pt"
                    }
                }
            )
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Button {
                    fitBoundsTap()
                } label: {
                    Image(buttonImage)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.accentColor)
                        .cornerRadius(6)
                }
            }
        }
        .navigationTitle("Camera Fit Bounds")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func fitBoundsTap() {
        guard let mapView = store.mapRef else { return }
        let cu: INVCameraUpdate
        if store.isInitPosition {
            cu = INVCameraUpdate(fit: INVLatLngBounds(southWest: position1, northEast: position2), padding: 24)
        } else {
            cu = INVCameraUpdate(position: INVCameraPosition(position1, zoom: 15.0))
        }
        cu.animation = .fly
        cu.animationDuration = 3
        mapView.moveCamera(cu)
        buttonImage = store.isInitPosition ? "baseline_replay_white_24pt" : "baseline_control_camera_white_24pt"
        store.isInitPosition.toggle()
    }
}
