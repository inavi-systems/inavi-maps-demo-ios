import UIKit
import iNaviMaps

class MapRestrictionViewController: MapViewController {
    let bounds_restriction = INVLatLngBounds(southWest: INVLatLng(lat: 37.413294, lng: 126.734086),
                                             northEast: INVLatLng(lat: 37.715133, lng: 127.269311))
    
    let bounds_korea = INVLatLngBounds(southWest: INVLatLng(lat: 31.43, lng: 122.37),
                                       northEast: INVLatLng(lat: 44.35, lng: 132.0))
    let polyline = INVPolyline()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeInit()
        mapView.moveCamera(INVCameraUpdate(fit: bounds_restriction))
        mapView.moveCamera(INVCameraUpdate(zoomBy: -0.5))
    }
    
    func shapeInit() {
        polyline.isVisible = false
        polyline.color = UIColor.red
        polyline.coords = [bounds_restriction.northWest,
                           bounds_restriction.northEast,
                           bounds_restriction.southEast,
                           bounds_restriction.southWest,
                           bounds_restriction.northWest]
        
        polyline.mapView = mapView
    }
    
    @IBAction func respondToMapPadding(_ sender: UISwitch) {
        if sender.isOn {
            polyline.isVisible = true
            mapView.constraintBounds = bounds_restriction;
            let cameraPosition = mapView.cameraFitBounds(bounds_restriction)
            
            mapView.cameraPosition = INVCameraPosition(cameraPosition.target,
                                                       zoom: cameraPosition.zoom - 0.5)
            
            mapView.minimumZoomLevel = cameraPosition.zoom - 0.5
        } else {
            polyline.isVisible = false
            mapView.constraintBounds = bounds_korea;
            mapView.minimumZoomLevel = 1;
        }
    }
}
