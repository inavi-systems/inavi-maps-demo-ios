import UIKit
import iNaviMaps

class MapControllerViewController: MapViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.moveCamera(INVCameraUpdate(bearingTo: 45))
        self.mapView?.showZoomControl = true
        self.mapView?.showLocationButton = true
    }
    
    @IBAction func respondToMapControllerSettings(_ sender: UISwitch) {
        switch (sender.tag) {
        case 0: // compass
            self.mapView?.showCompass = sender.isOn
        case 1: // scale bar
            self.mapView?.showScaleBar = sender.isOn
        case 2: // zoom controller
            self.mapView?.showZoomControl = sender.isOn
        case 3: // location button
            self.mapView?.showLocationButton = sender.isOn
        default:
            break
        }
    }
}
