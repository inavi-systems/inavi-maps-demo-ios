import UIKit
import iNaviMaps

class ShapeClickEventViewController: MapViewController {
    
    let marker = INVMarker(position: INVLatLng(lat: 37.40219, lng: 127.11077))
    
    var useClickEvent = true
    var consumeClickEvent = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeInit()
    }
    
    func shapeInit() {
        marker.tag = 0
        marker.titleColor = UIColor.red
        marker.titleSize = 14
        marker.touchEvent = { (shape) in
            if self.useClickEvent {
                if let marker = shape as? INVMarker {
                    marker.tag += 1
                    marker.title = "마커 \(marker.tag)회 클릭"
                }
            }
            return self.useClickEvent && self.consumeClickEvent
        }
        marker.mapView = mapView
    }
    
    func didTapMapView(_ point: CGPoint, latLng latlng: INVLatLng) {
        let message = String(format: "화면 : (%.0f, %.0f)\n지도 : %@", point.x, point.y, latlng.formattedString)
        let alertController = UIAlertController(title: "지도 클릭", message: message, preferredStyle: .alert)
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 1.5), execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func respondToShapeClickEvent(_ sender: UISwitch) {
        switch (sender.tag) {
        case 0: // use shape click event
            self.useClickEvent = sender.isOn
        case 1: // consmue click event
            self.consumeClickEvent = sender.isOn
        default:
            break
        }
    }
}
