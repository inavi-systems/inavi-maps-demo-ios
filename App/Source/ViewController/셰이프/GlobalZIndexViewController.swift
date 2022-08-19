import UIKit
import iNaviMaps

class GlobalZIndexViewController: MapViewController {
    
    var polyline: INVPolyline!
    
    let polyline_coords = [INVLatLng(lat: 37.40915, lng: 127.11400),
                           INVLatLng(lat: 37.40465, lng: 127.10986),
                           INVLatLng(lat: 37.40071, lng: 127.11590),
                           INVLatLng(lat: 37.39945, lng: 127.10839),
                           INVLatLng(lat: 37.39492, lng: 127.11127)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.moveCamera(INVCameraUpdate(position: INVCameraPosition(INVLatLng(lat: 37.40219, lng: 127.11077), zoom: 14.0)))
        shapeInit()
    }
    
    func shapeInit() {
        let circle = INVCircle()
        circle.center = INVLatLng(lat: 37.40219, lng: 127.11077)
        circle.radius = 500
        circle.fillColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        circle.strokeColor = UIColor.red
        circle.strokeWidth = 3
        circle.mapView = mapView
        
        polyline = INVPolyline()
        polyline.coords = polyline_coords
        polyline.color = UIColor.blue
        polyline.width = 3
        polyline.mapView = mapView
    }
    
    @IBAction func respondToGlobalZIndex(_ sender: UISwitch) {
        polyline?.globalZIndex = Int(INV_CIRCLE_DEFAULT_GLOBAL_Z_INDEX) + (sender.isOn ? -1 : 1)
    }
}
