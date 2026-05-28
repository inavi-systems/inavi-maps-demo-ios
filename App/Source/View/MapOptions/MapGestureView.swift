import SwiftUI
import iNaviMaps

private final class MapGestureStore {
    var mapRef: InaviMapView?
}

struct MapGestureView: View {
    @State private var store = MapGestureStore()
    @State private var scroll = true
    @State private var zoom = true
    @State private var tilt = true
    @State private var rotate = true
    @State private var focal = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { store.mapRef = $0 })
                .edgesIgnoringSafeArea(.bottom)
            DemoOverlayPanel(alignment: .bottom) {
                Toggle("스크롤", isOn: $scroll)
                    .onChange(of: scroll) { store.mapRef?.isScrollGesturesEnabled = $0 }
                Toggle("줌", isOn: $zoom)
                    .onChange(of: zoom) { store.mapRef?.isZoomGesturesEnabled = $0 }
                Toggle("틸트", isOn: $tilt)
                    .onChange(of: tilt) { store.mapRef?.isTiltGesturesEnabled = $0 }
                Toggle("회전", isOn: $rotate)
                    .onChange(of: rotate) { store.mapRef?.isRotateGesturesEnabled = $0 }
                Toggle("줌/회전 중심을 지도 중심으로", isOn: $focal)
                    .onChange(of: focal) { store.mapRef?.isFocalPointCenter = $0 }
            }
        }
        .navigationTitle("Map Gesture")
        .navigationBarTitleDisplayMode(.inline)
    }
}
