import SwiftUI
import iNaviMaps

private final class CameraMoveStore {
    var mapRef: InaviMapView?
    var isInitPosition = true
    var animation: INVCameraUpdateAnimation = .fly
}

struct CameraMoveView: View {
    @State private var store = CameraMoveStore()
    @State private var animationLabel = "Fly"

    private let position1 = INVLatLng(lat: 37.40219, lng: 127.11077)
    private let position2 = INVLatLng(lat: 36.99473, lng: 127.81832)

    private let animations: [(String, INVCameraUpdateAnimation)] = [
        ("None", .none),
        ("Linear", .linear),
        ("Ease In", .easeIn),
        ("Ease Out", .easeOut),
        ("Fly", .fly),
    ]

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                INVMarker(position: position1).mapView = mapView
                INVMarker(position: position2, iconImage: INV_MARKER_IMAGE_BLUE).mapView = mapView
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Menu {
                    ForEach(animations, id: \.0) { item in
                        Button(item.0) {
                            store.animation = item.1
                            animationLabel = item.0
                        }
                    }
                } label: {
                    HStack {
                        Text(animationLabel)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(6)
                    .foregroundColor(.primary)
                }
                Button("카메라 이동") {
                    let cu = INVCameraUpdate(targetTo: store.isInitPosition ? position2 : position1)
                    cu.animation = store.animation
                    cu.animationDuration = 3
                    store.mapRef?.moveCamera(cu)
                    store.isInitPosition.toggle()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(6)
            }
        }
        .navigationTitle("Camera Move")
        .navigationBarTitleDisplayMode(.inline)
    }
}
