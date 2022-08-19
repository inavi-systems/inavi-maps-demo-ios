import UIKit
import iNaviMaps

class INVCircleViewController: MapViewController {
    
    private let circle1 = INVCircle()
    private let circle2 = INVCircle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.moveCamera(INVCameraUpdate(position: INVCameraPosition(INVLatLng(lat: 37.40069, lng: 127.11077), zoom: 14.0)))
        shapeInit()
    }
    
    private func shapeInit() {

        circle1.center = INVLatLng(lat: 37.40219, lng: 127.11077)
        circle1.radius = 300
        circle1.fillColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        circle1.strokeColor = UIColor.red
        circle1.strokeWidth = 3
        circle1.mapView = mapView
        
        circle2.center = INVLatLng(lat: 37.39478, lng: 127.11116)
        circle2.radius = 200
        circle2.fillColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
        circle2.strokeColor = UIColor.green
        circle2.strokeWidth = 3
        circle2.mapView = mapView
    }
    
    @IBAction func respondToDeleteCircle(_ sender: UISwitch) {
        let allCircles = [circle1, circle2]
        if (sender.isOn) {
            allCircles.forEach { $0.mapView = nil }
        } else {
            allCircles.forEach { $0.mapView = mapView }
        }
    }
}
