import SwiftUI
import iNaviMaps

private final class RouteDelegate: NSObject, INVRouteDelegate {
    var onPassPositionChange: ((INVLatLng, Double, Double) -> Void)?
    func route(_ route: INVRoute, didChangePassPosition position: INVLatLng, passAngle angle: Double, passDistance distance: Double) {
        onPassPositionChange?(position, angle, distance)
    }
}

private final class INVRouteStore {
    var mapRef: InaviMapView?
    var routeShape = INVRoute()
    var passMarker = INVMarker()
    var routeDelegate = RouteDelegate()
}

struct INVRouteView: View {
    @State private var store = INVRouteStore()
    @State private var progress: Double = 0
    @State private var visible = true
    @State private var flat = false

    private let normalIcon = INVImage(name: "inv_marker_route_normal")
    private let flatIcon = INVImage(name: "inv_marker_route_flat")
    private let links: [INVRouteLink] = [
        INVRouteLink(coords: [
            INVLatLng(lat: 37.39475, lng: 127.11271),
            INVLatLng(lat: 37.39606, lng: 127.11274),
            INVLatLng(lat: 37.39608, lng: 127.11273),
            INVLatLng(lat: 37.39611, lng: 127.11270),
            INVLatLng(lat: 37.39614, lng: 127.11262),
            INVLatLng(lat: 37.39614, lng: 127.11141),
            INVLatLng(lat: 37.39616, lng: 127.11134),
            INVLatLng(lat: 37.39620, lng: 127.11127),
            INVLatLng(lat: 37.39624, lng: 127.11124),
            INVLatLng(lat: 37.39629, lng: 127.11122),
            INVLatLng(lat: 37.39633, lng: 127.11121),
        ], lineColor: .red, stroke: .white),
        INVRouteLink(coords: [
            INVLatLng(lat: 37.39633, lng: 127.11121),
            INVLatLng(lat: 37.39976, lng: 127.11123),
        ], lineColor: .green, stroke: .white),
        INVRouteLink(coords: [
            INVLatLng(lat: 37.39976, lng: 127.11123),
            INVLatLng(lat: 37.40091, lng: 127.11120),
        ], lineColor: .blue, stroke: .white),
        INVRouteLink(coords: [
            INVLatLng(lat: 37.40091, lng: 127.11120),
            INVLatLng(lat: 37.40156, lng: 127.11118),
            INVLatLng(lat: 37.40160, lng: 127.11116),
            INVLatLng(lat: 37.40162, lng: 127.11112),
            INVLatLng(lat: 37.40162, lng: 127.11085),
            INVLatLng(lat: 37.40164, lng: 127.11081),
            INVLatLng(lat: 37.40167, lng: 127.11078),
            INVLatLng(lat: 37.40170, lng: 127.11077),
            INVLatLng(lat: 37.40217, lng: 127.11077),
        ], lineColor: .red, stroke: .white),
    ]

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                mapView.moveCamera(INVCameraUpdate(targetTo: INVLatLng(lat: 37.39797, lng: 127.11120), zoomTo: 14.0))
                store.routeDelegate.onPassPositionChange = { [store] _, _, _ in
                    store.passMarker.position = store.routeShape.passPosition
                    store.passMarker.angle = CGFloat(store.passMarker.isIconFlat ? store.routeShape.passAngle : 0)
                }
                store.routeShape.delegate = store.routeDelegate
                store.routeShape.links = links
                store.routeShape.lineWidth = 10
                store.routeShape.strokeWidth = 2
                store.routeShape.passLineColor = .lightGray
                store.routeShape.passStrokeColor = .white
                store.routeShape.mapView = mapView
                store.routeShape.patternImage = INVImage(name: "inv_pattern_arrow")
                store.routeShape.patternMargin = 15
                store.routeShape.patternScale = 0.8

                store.passMarker.position = links[0].coords[0]
                store.passMarker.mapView = mapView
                applyFlat(false)
                applyVisible(true)
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                HStack {
                    Slider(value: $progress, in: 0...1)
                        .onChange(of: progress) { v in onProgressChange(Double(v)) }
                    Text("\(Int(progress * 100))%")
                        .frame(width: 50, alignment: .trailing)
                }
                Toggle("아이콘 표시", isOn: $visible)
                    .onChange(of: visible) { v in applyVisible(v) }
                Toggle("플랫 아이콘", isOn: $flat)
                    .disabled(!visible)
                    .onChange(of: flat) { v in applyFlat(v) }
            }
        }
        .navigationTitle("INVRoute")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func onProgressChange(_ value: Double) {
        guard let mapView = store.mapRef else { return }
        store.routeShape.passRatio = CGFloat(value)
        let params = INVCameraUpdateParams()
        params.target(to: store.passMarker.position)
        params.zoom(to: 16.0)
        params.tilt(to: 40.0)
        params.bearing(to: Double(store.routeShape.passAngle))
        let cu = INVCameraUpdate(params: params)
        cu.animation = .linear
        cu.animationDuration = 0.5
        mapView.moveCamera(cu)
    }

    private func applyVisible(_ on: Bool) {
        store.passMarker.isVisible = on
    }

    private func applyFlat(_ on: Bool) {
        if on {
            store.passMarker.anchor = CGPoint(x: 0.5, y: 0.5)
            store.passMarker.iconImage = flatIcon
            store.passMarker.isIconFlat = true
        } else {
            store.passMarker.anchor = CGPoint(x: 0.5, y: 1.0)
            store.passMarker.iconImage = normalIcon
            store.passMarker.isIconFlat = false
        }
        store.passMarker.position = store.routeShape.passPosition
        store.passMarker.angle = CGFloat(store.passMarker.isIconFlat ? store.routeShape.passAngle : 0)
    }
}
