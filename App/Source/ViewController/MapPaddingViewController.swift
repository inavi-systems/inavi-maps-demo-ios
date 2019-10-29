import UIKit
import iNaviMaps

class MapPaddingViewController: MapViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    let position = INVLatLng(lat: 37.40219, lng: 127.11077)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeInit()
    }
    
    func shapeInit() {
        let marker = INVMarker(position: position)
        marker.mapView = mapView
    }
    
    @IBAction func respondToMapPadding(_ sender: UISwitch) {
        if let mapView = self.mapView {
            let usePadding = sender.isOn
            mapView.contentInset = UIEdgeInsets(top: usePadding ? 25 : 0, left: usePadding ? 25 : 0, bottom: usePadding ? 100 : 0, right: usePadding ? 100 : 0)
            mapView.moveCamera(INVCameraUpdate(targetTo: position))
            
            self.contentView?.isHidden = !usePadding
        }
    }
}
