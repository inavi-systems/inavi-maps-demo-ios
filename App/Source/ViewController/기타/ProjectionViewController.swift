import UIKit
import iNaviMaps

class ProjectionViewController: MapViewController {

    @IBOutlet weak var tvLatLng: UILabel!
    @IBOutlet weak var tvScreenPoint: UILabel!
    @IBOutlet weak var crossHair: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showProjectionInfo() {
        DispatchQueue.main.async { [weak self] in
            if let crossHair = self?.crossHair {
                if let latLng = self?.mapView.projection.latlng(from: crossHair.center) {
                    self?.mapView.projection.point(from: latLng)
                    self?.tvScreenPoint.text = String(format: "화면상 좌표 : (%.1f, %.1f)", crossHair.center.x, crossHair.center.y)
                    self?.tvLatLng.text = String(format: "지도상 좌표 : (%.5f, %.5f)", latLng.lat, latLng.lng)
                }
            }
        }
    }
    
    func mapView(_ mapView: InaviMapView, regionWillChangeAnimated animated: Bool, reason: Int) {
        showProjectionInfo();
    }
    
    func mapView(_ mapView: InaviMapView, regionIsChangingWithReason reason: Int) {
        showProjectionInfo();
    }

    func mapView(_ mapView: InaviMapView, regionDidChangeAnimated animated: Bool, reason: Int) {
        showProjectionInfo();
    }
}
