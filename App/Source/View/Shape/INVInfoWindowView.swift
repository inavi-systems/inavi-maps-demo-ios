import SwiftUI
import iNaviMaps

private final class CustomInfoWindowDataSource: NSObject, INVImageViewDataSource {
    var rootView: CustomInfoWindowView!
    func view(with shape: INVShape) -> UIView {
        guard let infoWindow = shape as? INVInfoWindow else { return rootView }
        if rootView == nil {
            rootView = Bundle.main.loadNibNamed("CustomInfoWindowView", owner: nil, options: nil)?.first as? CustomInfoWindowView
        }
        if let marker = infoWindow.marker {
            rootView.iconView.image = UIImage(named: "baseline_room_black_24pt")
            rootView.textLabel.text = marker.userInfo["title"] as? String
        } else {
            rootView.iconView.image = UIImage(named: "baseline_gps_fixed_black_24pt")
            rootView.textLabel.text = String(format: "(%.5f, %.5f)", infoWindow.position.lat, infoWindow.position.lng)
        }
        rootView.textLabel.sizeToFit()
        let textWidth = rootView.textLabel.frame.size.width
        let iconWidth = rootView.iconView.frame.size.width
        let viewWidth = iconWidth + textWidth + 32
        var rect = rootView.frame
        rect.size.width = viewWidth
        rect.size.height = 57
        rootView.frame = rect
        rootView.layoutIfNeeded()
        return rootView
    }
}

private final class TextInfoWindowDataSource: NSObject, INVImageTextDataSource {
    func title(with shape: INVShape) -> String {
        return shape.userInfo["title"] as? String ?? ""
    }
}

private final class INVInfoWindowStore {
    var mapRef: InaviMapView?
    var infoWindow = INVInfoWindow()
    var customDS = CustomInfoWindowDataSource()
    var textDS = TextInfoWindowDataSource()
}

struct INVInfoWindowView: View {
    @State private var store = INVInfoWindowStore()
    @State private var custom = false

    private let initPosition = INVLatLng(lat: 37.40219, lng: 127.11077)

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(
                onMapViewReady: { mapView in
                    store.mapRef = mapView
                    shapeInit(on: mapView)
                },
                onMapTap: { _, latlng in
                    let title = String(format: "좌표 : (%.5f, %.5f)", latlng.lat, latlng.lng)
                    store.infoWindow.position = latlng
                    store.infoWindow.userInfo["title"] = title
                    if store.infoWindow.mapView == nil {
                        store.infoWindow.mapView = store.mapRef
                    } else {
                        store.infoWindow.invalidate()
                    }
                }
            )
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("커스텀 인포윈도우", isOn: $custom)
                    .onChange(of: custom) { v in
                        store.infoWindow.imageDataSource = v ? store.customDS : store.textDS
                    }
            }
        }
        .navigationTitle("INVInfoWindow")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func shapeInit(on mapView: InaviMapView) {
        let title = String(format: "좌표 : (%.5f, %.5f)", initPosition.lat, initPosition.lng)
        let iw = store.infoWindow
        iw.position = initPosition
        iw.userInfo["title"] = title
        iw.touchEvent = { [weak iw] _ in
            iw?.mapView = nil
            return true
        }
        iw.imageDataSource = store.textDS
        iw.mapView = mapView

        let markerTouchEvent: (INVShape) -> Bool = { [weak iw] shape in
            guard let iw = iw else { return false }
            if let marker = shape as? INVMarker {
                iw.userInfo["title"] = "마커 : \(marker.userInfo["title"] as! String)"
                iw.marker = marker
                if iw.mapView == nil {
                    iw.mapView = mapView
                } else {
                    iw.invalidate()
                }
            }
            return true
        }

        let m1 = INVMarker(position: INVLatLng(lat: 37.40465, lng: 127.10986))
        m1.iconImage = INV_MARKER_IMAGE_RED
        m1.touchEvent = markerTouchEvent
        m1.userInfo = ["title": "RED"]
        m1.mapView = mapView

        let m2 = INVMarker(position: INVLatLng(lat: 37.40058, lng: 127.11231))
        m2.iconImage = INV_MARKER_IMAGE_BLUE
        m2.touchEvent = markerTouchEvent
        m2.userInfo = ["title": "BLUE"]
        m2.mapView = mapView
    }
}
