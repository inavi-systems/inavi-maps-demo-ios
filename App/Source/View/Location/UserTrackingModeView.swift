import SwiftUI
import iNaviMaps

private final class UserTrackingModeStore {
    var mapRef: InaviMapView?
}

struct UserTrackingModeView: View {
    @State private var store = UserTrackingModeStore()
    @State private var label = "Tracking"

    private let modes: [(String, INVUserTrackingMode)] = [
        ("None", .none),
        ("NoTracking", .noTracking),
        ("Tracking", .tracking),
        ("TrackingCompass", .trackingCompass),
    ]

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(
                onMapViewReady: { mapView in
                    store.mapRef = mapView
                    mapView.userTrackingMode = .tracking
                    mapView.showLocationButton = true
                },
                onTrackingModeChange: { mode, _ in
                    label = modeLabel(mode)
                }
            )
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Menu {
                    ForEach(modes, id: \.0) { item in
                        Button(item.0) {
                            store.mapRef?.userTrackingMode = item.1
                            label = item.0
                        }
                    }
                } label: {
                    HStack {
                        Text(label)
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
            }
        }
        .navigationTitle("User Tracking Mode")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func modeLabel(_ mode: INVUserTrackingMode) -> String {
        switch mode {
        case .noTracking: return "NoTracking"
        case .tracking: return "Tracking"
        case .trackingCompass: return "TrackingCompass"
        default: return "None"
        }
    }
}
