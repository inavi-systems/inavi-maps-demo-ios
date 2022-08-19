import UIKit
import iNaviMaps

class INVPolylineViewContoller: MapViewController {
    
    private let polyline1 = INVPolyline()
    private let polyline1_coords = [INVLatLng(lat: 37.40915, lng: 127.11400),
                                    INVLatLng(lat: 37.40465, lng: 127.10986),
                                    INVLatLng(lat: 37.40071, lng: 127.11590),
                                    INVLatLng(lat: 37.39945, lng: 127.10839)]
    
    private var polyline2 = INVPolyline()
    private let polyline2_coords = [INVLatLng(lat: 37.39945, lng: 127.10839),
                                    INVLatLng(lat: 37.39492, lng: 127.11127)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.moveCamera(INVCameraUpdate(position: INVCameraPosition(INVLatLng(lat: 37.40219, lng: 127.11077), zoom: 14.0)))
        shapeInit()
    }
    
    private func shapeInit() {
        
        polyline1.coords = polyline1_coords
        polyline1.color = UIColor.red
        polyline1.width = 3
        polyline1.mapView = mapView
        
        polyline2 = INVPolyline(coords: polyline2_coords)
        polyline2.color = UIColor.blue
        polyline2.pattern = [10, 10]
        polyline2.width = 3
        polyline2.mapView = mapView
    }
    
    private func deletePolyline() {
        polyline1.mapView = nil
        polyline2.mapView = nil
    }
    
    @IBAction func respondToDeletePolyline(_ sender: UISwitch) {
        let allPolylines = [polyline1, polyline2]
        if (sender.isOn) {
            allPolylines.forEach { $0.mapView = nil }
        } else {
            allPolylines.forEach { $0.mapView = mapView }
        }
    }
}
