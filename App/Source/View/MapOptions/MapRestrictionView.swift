import SwiftUI
import iNaviMaps

private final class MapRestrictionStore {
    var mapRef: InaviMapView?
    var polyline: INVPolyline?
}

struct MapRestrictionView: View {
    @State private var store = MapRestrictionStore()
    @State private var restrict = false

    private let boundsRestriction = INVLatLngBounds(
        southWest: INVLatLng(lat: 37.413294, lng: 126.734086),
        northEast: INVLatLng(lat: 37.715133, lng: 127.269311)
    )
    private let boundsKorea = INVLatLngBounds(
        southWest: INVLatLng(lat: 31.43, lng: 122.37),
        northEast: INVLatLng(lat: 44.35, lng: 132.0)
    )

    var body: some View {
        ZStack {
            InaviMapViewRepresentable(onMapViewReady: { mapView in
                store.mapRef = mapView
                let pl = INVPolyline()
                pl.isVisible = false
                pl.color = .red
                pl.coords = [boundsRestriction.northWest,
                             boundsRestriction.northEast,
                             boundsRestriction.southEast,
                             boundsRestriction.southWest,
                             boundsRestriction.northWest]
                pl.mapView = mapView
                store.polyline = pl
                mapView.moveCamera(INVCameraUpdate(fit: boundsRestriction))
                mapView.moveCamera(INVCameraUpdate(zoomBy: -0.5))
            })
            .edgesIgnoringSafeArea(.bottom)

            DemoOverlayPanel(alignment: .bottom) {
                Toggle("영역 제한", isOn: $restrict)
                    .onChange(of: restrict) { on in
                        guard let mapView = store.mapRef, let pl = store.polyline else { return }
                        if on {
                            pl.isVisible = true
                            mapView.constraintBounds = boundsRestriction
                            let cp = mapView.cameraFitBounds(boundsRestriction)
                            mapView.cameraPosition = INVCameraPosition(cp.target, zoom: cp.zoom - 0.5)
                            mapView.minimumZoomLevel = cp.zoom - 0.5
                        } else {
                            pl.isVisible = false
                            mapView.constraintBounds = boundsKorea
                            mapView.minimumZoomLevel = 1
                        }
                    }
            }
        }
        .navigationTitle("Map Restriction")
        .navigationBarTitleDisplayMode(.inline)
    }
}
