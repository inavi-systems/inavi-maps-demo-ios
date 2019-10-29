import UIKit
import iNaviMaps

class INVPolygonViewContoller: MapViewController {
    
    let polygon1_coords = [INVLatLng(lat: 37.41014, lng: 127.11011),
                           INVLatLng(lat: 37.40915, lng: 127.11400),
                           INVLatLng(lat: 37.40538, lng: 127.11440),
                           INVLatLng(lat: 37.40465, lng: 127.10986),
                           INVLatLng(lat: 37.40755, lng: 127.10610)]
    
    let polygon2_coords = [INVLatLng(lat: 37.39945, lng: 127.10839),
                           INVLatLng(lat: 37.40071, lng: 127.11590),
                           INVLatLng(lat: 37.39395, lng: 127.11575),
                           INVLatLng(lat: 37.39554, lng: 127.10827)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.moveCamera(INVCameraUpdate(position: INVCameraPosition(INVLatLng(lat: 37.40219, lng: 127.11077), zoom: 14.0)))
        shapeInit()
    }
    
    func shapeInit() {
        let polygon1 = INVPolygon()
        polygon1.coords = polygon1_coords
        polygon1.fillColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.5)
        polygon1.strokeColor = UIColor.blue
        polygon1.strokeWidth = 3
        polygon1.mapView = mapView
        
        let polygon2 = INVPolygon(coords: polygon2_coords, fill: UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5))
        polygon2.strokeColor = UIColor.black
        polygon2.strokeWidth = 3
        polygon2.mapView = mapView
    }
}
