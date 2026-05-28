import SwiftUI
import iNaviMaps

private final class CustomStyleAuth: NSObject, INVMapSdkDelegate {
    var onAuthSuccess: (([INVMapStyle]) -> Void)?
    func authSuccess(_ customMapStyles: [INVMapStyle]) {
        onAuthSuccess?(customMapStyles)
    }
}

private final class MapCustomStyleStore {
    var mapRef: InaviMapView?
    var authDelegate = CustomStyleAuth()
}

struct MapCustomStyleView: View {
    @State private var store = MapCustomStyleStore()
    @State private var selectedTitle = "기본 스타일"
    @State private var styles: [INVMapStyle] = []
    @State private var alertText: String?
    @State private var showAlert = false

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                shapeInit(on: mapView)
                store.authDelegate.onAuthSuccess = { customStyles in
                    DispatchQueue.main.async {
                        styles = customStyles
                        if customStyles.isEmpty {
                            alertText = "커스텀 지도 스타일이 없습니다."
                            showAlert = true
                        }
                    }
                }
                INVMapSdk.sharedInstance().delegate = store.authDelegate
                let saved = INVMapSdk.sharedInstance().savedCustomMapStyles
                DispatchQueue.main.async {
                    styles = saved
                }
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Menu {
                    Button("기본 스타일") {
                        selectedTitle = "기본 스타일"
                        store.mapRef?.customMapStyle = nil
                    }
                    ForEach(styles, id: \.styleName) { style in
                        Button(style.styleName) {
                            selectedTitle = style.styleName
                            store.mapRef?.customMapStyle = style
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedTitle)
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
                .onTapGesture {
                    if styles.isEmpty {
                        alertText = "커스텀 지도 스타일이 없습니다."
                        showAlert = true
                    }
                }
            }
        }
        .alert(alertText ?? "", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        }
        .navigationTitle("Map Custom Style")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func shapeInit(on mapView: InaviMapView) {
        let m1 = INVMarker()
        m1.position = INVLatLng(lat: 37.40219, lng: 127.11077)
        m1.mapView = mapView

        let m2 = INVMarker()
        m2.position = INVLatLng(lat: 37.40465, lng: 127.10986)
        if let img = UIImage(named: "inv_marker_right_bottom") {
            m2.iconImage = INVImage(image: img)
            m2.anchor = CGPoint(x: 0.9, y: 0.9)
            m2.angle = 90
        }
        m2.mapView = mapView

        let m3 = INVMarker()
        m3.position = INVLatLng(lat: 37.40274, lng: 127.10806)
        m3.iconImage = INV_MARKER_IMAGE_BLUE
        m3.titleColor = .green
        m3.mapView = mapView

        let m4 = INVMarker()
        m4.position = INVLatLng(lat: 37.39990, lng: 127.10965)
        m4.iconImage = INV_MARKER_IMAGE_YELLOW
        m4.titleSize = 16
        m4.mapView = mapView

        let m5 = INVMarker()
        m5.position = INVLatLng(lat: 37.40324, lng: 127.11276)
        m5.iconImage = INV_MARKER_IMAGE_GREEN
        m5.alpha = 0.5
        m5.mapView = mapView

        let m6 = INVMarker()
        m6.position = INVLatLng(lat: 37.40058, lng: 127.11231)
        m6.iconImage = INVImage(name: "baseline_star_black_24pt")
        m6.iconScale = 2.0
        m6.anchor = CGPoint(x: 0.5, y: 0.5)
        m6.mapView = mapView

        let p1 = INVPolyline(coords: [INVLatLng(lat: 37.40915, lng: 127.11400),
                                      INVLatLng(lat: 37.40465, lng: 127.10986),
                                      INVLatLng(lat: 37.40071, lng: 127.11590),
                                      INVLatLng(lat: 37.39945, lng: 127.10839)])
        p1.color = .red
        p1.width = 3
        p1.mapView = mapView

        let p2 = INVPolyline(coords: [INVLatLng(lat: 37.39945, lng: 127.10839),
                                      INVLatLng(lat: 37.39492, lng: 127.11127)])
        p2.color = .blue
        p2.pattern = [10, 10]
        p2.width = 3
        p2.mapView = mapView
    }
}
