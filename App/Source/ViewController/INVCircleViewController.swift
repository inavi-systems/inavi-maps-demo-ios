import UIKit
import iNaviMaps

class INVCircleViewController: MapViewController {
    
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
    }
}
