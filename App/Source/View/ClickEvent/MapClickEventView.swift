import SwiftUI
import iNaviMaps

private final class MapClickEventStore {
    var mapRef: InaviMapView?
    var useClick = true
    var useLongClick = true
    var useDoubleClick = true
    var consumeDoubleClick = false
}

struct MapClickEventView: View {
    @State private var store = MapClickEventStore()
    @State private var useClick = true
    @State private var useLongClick = true
    @State private var useDoubleClick = true
    @State private var consumeDoubleClick = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(
                onMapViewReady: { store.mapRef = $0 },
                onMapTap: { point, latlng in
                    if store.useClick { showAlertMessage("지도 클릭", point: point, latlng: latlng) }
                },
                onMapDoubleTap: { point, latlng in
                    if store.useDoubleClick { showAlertMessage("지도 더블 클릭", point: point, latlng: latlng) }
                    return store.useDoubleClick && store.consumeDoubleClick
                },
                onMapLongPress: { point, latlng in
                    if store.useLongClick { showAlertMessage("지도 롱 클릭", point: point, latlng: latlng) }
                }
            )
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("클릭 이벤트", isOn: $useClick)
                    .onChange(of: useClick) { store.useClick = $0 }
                Toggle("롱 클릭 이벤트", isOn: $useLongClick)
                    .onChange(of: useLongClick) { store.useLongClick = $0 }
                Toggle("더블 클릭 이벤트", isOn: $useDoubleClick)
                    .onChange(of: useDoubleClick) { store.useDoubleClick = $0 }
                Toggle("더블 클릭 소비", isOn: $consumeDoubleClick).disabled(!useDoubleClick)
                    .onChange(of: consumeDoubleClick) { store.consumeDoubleClick = $0 }
            }
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .navigationTitle("Map Click")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func showAlertMessage(_ title: String, point: CGPoint, latlng: INVLatLng) {
        alertTitle = title
        alertMessage = String(format: "화면 : (%.0f, %.0f)\n지도 : %@", point.x, point.y, latlng.formattedString)
        showAlert = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showAlert = false
        }
    }
}
