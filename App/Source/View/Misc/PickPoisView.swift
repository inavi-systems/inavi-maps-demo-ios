import SwiftUI
import iNaviMaps

private final class PickPoisStore {
    var mapRef: InaviMapView?
}

struct PickPoisView: View {
    private struct LanguageOption: Identifiable, Hashable {
        let label: String
        let code: String
        var id: String { code }
    }

    @State private var store = PickPoisStore()
    @State private var pickRect: CGRect = .zero
    @State private var alertMessage = ""
    @State private var showAlert = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(
                onMapViewReady: { mapView in
                    store.mapRef = mapView
                },
                onRegionWillChange: { _, _ in
                    pickRect = .zero
                    store.mapRef?.clearShapes()
                },
                onMapTap: { point, _ in
                    handleTap(at: point)
                }
            )
            .edgesIgnoringSafeArea(.bottom)

            if pickRect != .zero {
                Rectangle()
                    .fill(Color.red.opacity(0.2))
                    .frame(width: pickRect.width, height: pickRect.height)
                    .position(x: pickRect.midX, y: pickRect.midY)
                    .allowsHitTesting(false)
            }
        }
        .alert("Pick POIs", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .navigationTitle("Pick POIs")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func handleTap(at point: CGPoint) {
        guard let mapView = store.mapRef else { return }
        let rect = CGRect(x: point.x - 15, y: point.y - 15, width: 30, height: 30)
        pickRect = rect
        mapView.clearShapes()
        let pois = mapView.pickPois(rect)
        if !pois.isEmpty {
            alertMessage = pois.map { "name: \($0.name), POI ID: \($0.poiId)" }.joined(separator: "\n")
            pois.forEach { poi in
                let marker = INVMarker(position: poi.position, iconImage: INV_MARKER_IMAGE_RED)
                marker.mapView = mapView
                marker.isAllowOverlapMarkers = true
                marker.isAllowOverlapSymbols = true
                marker.iconScale = 0.5
            }
        } else {
            alertMessage = "선택된 POI가 없습니다."
        }
        showAlert = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showAlert = false
        }
    }
}
