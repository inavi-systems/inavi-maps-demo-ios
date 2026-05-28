import SwiftUI
import iNaviMaps
import CoreLocation

struct InaviMapViewRepresentable: UIViewRepresentable {
    var onMapViewReady: ((InaviMapView) -> Void)? = nil
    var onRegionWillChange: ((Bool, Int) -> Void)? = nil
    var onRegionIsChanging: ((Int) -> Void)? = nil
    var onRegionDidChange: ((Bool, Int) -> Void)? = nil
    var onMapTap: ((CGPoint, INVLatLng) -> Void)? = nil
    var onMapDoubleTap: ((CGPoint, INVLatLng) -> Bool)? = nil
    var onMapLongPress: ((CGPoint, INVLatLng) -> Void)? = nil
    var onTrackingModeChange: ((INVUserTrackingMode, Bool) -> Void)? = nil
    var onUserLocationUpdate: ((CLLocation?) -> Void)? = nil
    var onIndoorChange: ((NSNumber?, [INVFloor]?, INVFloor?) -> Void)? = nil

    init(onMapViewReady: ((InaviMapView) -> Void)? = nil,
         onRegionWillChange: ((Bool, Int) -> Void)? = nil,
         onRegionIsChanging: ((Int) -> Void)? = nil,
         onRegionDidChange: ((Bool, Int) -> Void)? = nil,
         onMapTap: ((CGPoint, INVLatLng) -> Void)? = nil,
         onMapDoubleTap: ((CGPoint, INVLatLng) -> Bool)? = nil,
         onMapLongPress: ((CGPoint, INVLatLng) -> Void)? = nil,
         onTrackingModeChange: ((INVUserTrackingMode, Bool) -> Void)? = nil,
         onUserLocationUpdate: ((CLLocation?) -> Void)? = nil,
         onIndoorChange: ((NSNumber?, [INVFloor]?, INVFloor?) -> Void)? = nil) {
        self.onMapViewReady = onMapViewReady
        self.onRegionWillChange = onRegionWillChange
        self.onRegionIsChanging = onRegionIsChanging
        self.onRegionDidChange = onRegionDidChange
        self.onMapTap = onMapTap
        self.onMapDoubleTap = onMapDoubleTap
        self.onMapLongPress = onMapLongPress
        self.onTrackingModeChange = onTrackingModeChange
        self.onUserLocationUpdate = onUserLocationUpdate
        self.onIndoorChange = onIndoorChange
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> InaviMapView {
        let mapView = InaviMapView(frame: .zero)
        mapView.delegate = context.coordinator
        onMapViewReady?(mapView)
        return mapView
    }

    func updateUIView(_ uiView: InaviMapView, context: Context) {
        context.coordinator.parent = self
    }

    final class Coordinator: NSObject, INVMapViewDelegate {
        var parent: InaviMapViewRepresentable

        init(_ parent: InaviMapViewRepresentable) {
            self.parent = parent
        }

        func mapView(_ mapView: InaviMapView, regionWillChangeAnimated animated: Bool, reason: Int) {
            parent.onRegionWillChange?(animated, reason)
        }

        func mapView(_ mapView: InaviMapView, regionIsChangingWithReason reason: Int) {
            parent.onRegionIsChanging?(reason)
        }

        func mapView(_ mapView: InaviMapView, regionDidChangeAnimated animated: Bool, reason: Int) {
            parent.onRegionDidChange?(animated, reason)
        }

        func didTapMapView(_ point: CGPoint, latLng: INVLatLng) {
            parent.onMapTap?(point, latLng)
        }

        func didDoubleTapMapView(_ point: CGPoint, latLng: INVLatLng) -> Bool {
            return parent.onMapDoubleTap?(point, latLng) ?? false
        }

        func didLongTapMapView(_ point: CGPoint, latLng: INVLatLng) {
            parent.onMapLongPress?(point, latLng)
        }

        func mapView(_ mapView: InaviMapView, didChange mode: INVUserTrackingMode, animated: Bool) {
            parent.onTrackingModeChange?(mode, animated)
        }

        func mapView(_ mapView: InaviMapView, didUpdateUserLocation userLocation: CLLocation?) {
            parent.onUserLocationUpdate?(userLocation)
        }

        func mapView(_ mapView: InaviMapView, didChangeIndoor placeId: NSNumber?, floors: [INVFloor]?, floor: INVFloor?) {
            parent.onIndoorChange?(placeId, floors, floor)
        }
    }
}
