import UIKit
import iNaviMaps

class MapSymbolScaleViewController: MapViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func respondToSwitch(_ sender: UISwitch) {
        if sender.isOn {
            self.mapView.symbolScale = 1.5
        } else {
            self.mapView.symbolScale = 1.0
        }
    }
}
