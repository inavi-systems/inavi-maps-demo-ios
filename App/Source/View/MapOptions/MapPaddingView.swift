import SwiftUI
import iNaviMaps

private final class MapPaddingStore {
    var mapRef: InaviMapView?
}

struct MapPaddingView: View {
    @State private var store = MapPaddingStore()
    @State private var usePadding = false

    private let position = INVLatLng(lat: 37.40219, lng: 127.11077)

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                let marker = INVMarker(position: position)
                marker.mapView = mapView
            })
            .edgesIgnoringSafeArea(.bottom)

            if usePadding {
                Rectangle()
                    .strokeBorder(Color.blue, lineWidth: 2)
                    .background(Color.blue.opacity(0.1))
                    .padding(EdgeInsets(top: 25, leading: 25, bottom: 100, trailing: 100))
                    .allowsHitTesting(false)
            }

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("패딩 사용", isOn: $usePadding)
                    .onChange(of: usePadding) { on in
                        guard let mapView = store.mapRef else { return }
                        mapView.contentInset = UIEdgeInsets(
                            top: on ? 25 : 0,
                            left: on ? 25 : 0,
                            bottom: on ? 100 : 0,
                            right: on ? 100 : 0
                        )
                        mapView.moveCamera(INVCameraUpdate(targetTo: position))
                    }
            }
        }
        .navigationTitle("Map Padding")
        .navigationBarTitleDisplayMode(.inline)
    }
}
