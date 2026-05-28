import SwiftUI
import iNaviMaps

private final class LocationIconStore {
    var mapRef: InaviMapView?
    var locationIcon: INVLocationIcon?
}

struct LocationIconView: View {
    @State private var store = LocationIconStore()
    @State private var visible = true
    @State private var customImage = false
    @State private var enlarge = false
    @State private var bigRadius = false
    @State private var customCircleColor = false
    @State private var bearing: Double = 0
    @State private var alertText: String?
    @State private var showAlert = false

    private let customIcon = INVImage(name: "baseline_directions_run_black_36pt")

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(
                onMapViewReady: { mapView in
                    store.mapRef = mapView
                    let icon = mapView.locationIcon
                    icon.position = mapView.cameraPosition.target
                    icon.touchEvent = { _ in
                        alertText = "위치 아이콘 클릭됨"
                        showAlert = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showAlert = false
                        }
                        return true
                    }
                    store.locationIcon = icon
                },
                onMapTap: { _, latlng in
                    store.locationIcon?.position = latlng
                }
            )
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("표시", isOn: $visible)
                    .onChange(of: visible) { v in store.locationIcon?.isVisible = v }
                Toggle("커스텀 이미지", isOn: $customImage).disabled(!visible)
                    .onChange(of: customImage) { v in store.locationIcon?.image = v ? customIcon : INV_LOCATION_ICON_IMAGE }
                Toggle("2배 확대", isOn: $enlarge).disabled(!visible)
                    .onChange(of: enlarge) { v in store.locationIcon?.scale = v ? 2.0 : 1.0 }
                Toggle("원 크기 48", isOn: $bigRadius).disabled(!visible)
                    .onChange(of: bigRadius) { v in store.locationIcon?.circleRadius = v ? 48.0 : 24.0 }
                Toggle("원 색상 노랑", isOn: $customCircleColor).disabled(!visible)
                    .onChange(of: customCircleColor) { v in
                        store.locationIcon?.circleColor = v ? UIColor(red: 1, green: 1, blue: 0, alpha: 0.5) : INV_LOCATION_ICON_CIRCLE_COLOR
                    }
                HStack {
                    Text("베어링").frame(width: 60, alignment: .leading)
                    Slider(value: $bearing, in: 0...360).disabled(!visible)
                        .onChange(of: bearing) { v in store.locationIcon?.bearing = CGFloat(v) }
                    Text("\(Int(bearing))°").frame(width: 40, alignment: .trailing)
                }
            }
        }
        .alert(alertText ?? "", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        }
        .navigationTitle("Location Icon")
        .navigationBarTitleDisplayMode(.inline)
    }
}
