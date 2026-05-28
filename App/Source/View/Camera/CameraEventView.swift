import SwiftUI
import iNaviMaps

private final class CameraEventStore {
    var mapRef: InaviMapView?
    var isInitPosition = true
}

struct CameraEventView: View {
    @State private var store = CameraEventStore()
    @State private var isMovingByButton = false
    @State private var infoText = "상태 : 대기"
    @State private var alertText: String?
    @State private var showAlert = false

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
                onRegionIsChanging: { _ in updateInfo(true) },
                onRegionDidChange: { _, _ in updateInfo(false) }
            )
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .top) {
                Text(infoText)
                    .font(.system(size: 13, design: .monospaced))
                    .multilineTextAlignment(.leading)
            }

            DemoOverlayPanel(alignment: .bottom) {
                Button(isMovingByButton ? "이동 취소" : "카메라 이동") {
                    handleTap()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(isMovingByButton ? Color.red : Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(6)
            }
        }
        .alert(alertText ?? "", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        }
        .navigationTitle("Camera Events")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func updateInfo(_ moving: Bool) {
        guard let mapView = store.mapRef else { return }
        let cp = mapView.cameraPosition
        infoText = String(format: "상태 : %@\n위치 : (%.5f, %.5f)\n줌 레벨 : %.2f\n기울기 : %.2f\n베어링 : %.2f",
                          moving ? "이동" : "대기", cp.target.lat, cp.target.lng, cp.zoom, cp.tilt, cp.bearing)
    }

    private func handleTap() {
        guard let mapView = store.mapRef else { return }
        if isMovingByButton {
            mapView.cancelTransitions()
            return
        }
        let cu = INVCameraUpdate(position: INVCameraPosition(store.isInitPosition ? position2 : position1, zoom: 14.0))
        cu.animation = .fly
        cu.animationDuration = 3
        mapView.moveCamera(cu) { isCancelled in
            isMovingByButton = false
            alertText = isCancelled ? "카메라 이동 취소" : "카메라 이동 완료"
            showAlert = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showAlert = false
            }
        }
        isMovingByButton = true
        store.isInitPosition.toggle()
    }
}
