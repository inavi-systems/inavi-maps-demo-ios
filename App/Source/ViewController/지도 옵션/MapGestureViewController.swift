import UIKit
import iNaviMaps

class MapGestureViewController: MapViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func respondToMapGestureSettings(_ sender: UISwitch) {
        switch (sender.tag) {
        case 0: // scroll
            self.mapView?.isScrollGesturesEnabled = sender.isOn
        case 1: // zoom
            self.mapView?.isZoomGesturesEnabled = sender.isOn
        case 2: // tilt
            self.mapView?.isTiltGesturesEnabled = sender.isOn
        case 3: // rotate
            self.mapView?.isRotateGesturesEnabled = sender.isOn
        case 4: // zoom/rotate geture by center of mapview
            self.mapView?.isFocalPointCenter = sender.isOn
        default:
            break
        }
    }
}
