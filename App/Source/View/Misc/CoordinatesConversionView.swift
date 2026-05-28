import SwiftUI
import iNaviMaps

private final class CoordinatesConversionStore {
    var mapRef: InaviMapView?
    var currentPosition = INVLatLng(lat: 0, lng: 0)
}

struct CoordinatesConversionView: View {
    @State private var store = CoordinatesConversionStore()
    @State private var wgs84Text = "(0, 0)"
    @State private var alertMessage = ""
    @State private var showAlert = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                InaviMapViewRepresentable(
                    onMapViewReady: { mapView in
                        store.mapRef = mapView
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            updateInfo(geo: geo)
                        }
                    },
                    onRegionWillChange: { _, _ in updateInfo(geo: geo) },
                    onRegionIsChanging: { _ in updateInfo(geo: geo) },
                    onRegionDidChange: { _, _ in updateInfo(geo: geo) }
                )
                .edgesIgnoringSafeArea(.bottom)

                Image("crosshair").allowsHitTesting(false)

                DemoOverlayPanel(alignment: .top) {
                    Text("WGS84").font(.headline)
                    Text(wgs84Text).font(.system(size: 13, design: .monospaced))
                    Button("좌표 변환") {
                        convert()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                }
            }
        }
        .alert("좌표 변환", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .navigationTitle("Coordinates Conversion")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func updateInfo(geo: GeometryProxy) {
        guard let mapView = store.mapRef else { return }
        let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
        let latLng = mapView.projection.latlng(from: center)
        store.currentPosition = latLng
        wgs84Text = String(format: "(%.5f, %.5f)", latLng.lat, latLng.lng)
    }

    private func convert() {
        let wgs84 = store.currentPosition
        let katec = INVKatec(latLng: wgs84)
        let utmk = INVUtmk(latLng: wgs84)
        let tm = INVTm(latLng: wgs84)
        let grs80 = INVGrs80(latLng: wgs84)
        alertMessage = """
        KATEC 좌표
        \(String(format: "(%.5f, %.5f)", katec.x, katec.y))

        UTM-K 좌표
        \(String(format: "(%.5f, %.5f)", utmk.x, utmk.y))

        TM 좌표
        \(String(format: "(%.5f, %.5f)", tm.x, tm.y))

        GRS80 좌표
        \(String(format: "(%.5f, %.5f)", grs80.x, grs80.y))
        """
        showAlert = true
    }
}
