import SwiftUI
import iNaviMaps

private final class ShapeClickEventStore {
    var mapRef: InaviMapView?
    var marker = INVMarker(position: INVLatLng(lat: 37.40219, lng: 127.11077))
    var useClick = true
    var consumeClick = true
}

struct ShapeClickEventView: View {
    @State private var store = ShapeClickEventStore()
    @State private var useClick = true
    @State private var consumeClick = true
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(
                onMapViewReady: { mapView in
                    store.mapRef = mapView
                    store.marker.tag = 0
                    store.marker.titleColor = .red
                    store.marker.titleSize = 14
                    store.marker.touchEvent = { [store] shape in
                        if store.useClick, let m = shape as? INVMarker {
                            m.tag += 1
                            m.title = "마커 \(m.tag)회 클릭"
                        }
                        return store.useClick && store.consumeClick
                    }
                    store.marker.mapView = mapView
                },
                onMapTap: { point, latlng in
                    alertTitle = "지도 클릭"
                    alertMessage = String(format: "화면 : (%.0f, %.0f)\n지도 : %@", point.x, point.y, latlng.formattedString)
                    showAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        showAlert = false
                    }
                }
            )
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("셰이프 클릭 이벤트", isOn: $useClick)
                    .onChange(of: useClick) { store.useClick = $0 }
                Toggle("클릭 소비", isOn: $consumeClick).disabled(!useClick)
                    .onChange(of: consumeClick) { store.consumeClick = $0 }
            }
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .navigationTitle("Shape Click")
        .navigationBarTitleDisplayMode(.inline)
    }
}
