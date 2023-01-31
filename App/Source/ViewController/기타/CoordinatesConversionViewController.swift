import UIKit
import iNaviMaps

class CoordinatesConversionViewController: MapViewController {
    
    @IBOutlet weak var tvLatLng: UILabel!
    @IBOutlet weak var crossHair: UIImageView!
    
    private var currentPosition: INVLatLng = INVLatLng(lat: 0.00, lng: 0.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func showWGS84Info() {
        DispatchQueue.main.async { [weak self] in
            if let crossHair = self?.crossHair {
                if let latLng = self?.mapView.projection.latlng(from: crossHair.center) {
                    self?.currentPosition = latLng
                    self?.mapView.projection.point(from: latLng)
                    self?.tvLatLng.text = String(format: "(%.5f, %.5f)", latLng.lat, latLng.lng)
                }
            }
        }
    }
    
    func mapView(_ mapView: InaviMapView, regionWillChangeAnimated animated: Bool, reason: Int) {
        showWGS84Info()
    }
    
    func mapView(_ mapView: InaviMapView, regionIsChangingWithReason reason: Int) {
        showWGS84Info()
    }
    
    func mapView(_ mapView: InaviMapView, regionDidChangeAnimated animated: Bool, reason: Int) {
        showWGS84Info()
    }
    
    @IBAction func respondToCoordinatesConversion(_ sender: Any) {
        let wgs84 = currentPosition
        let katec = INVKatec(latLng: wgs84)
        let utmk = INVUtmk(latLng: wgs84)
        let tm = INVTm(latLng: wgs84)
        let grs80 = INVGrs80(latLng: wgs84)
        
        let message = """
        KATEC 좌표
        \(String(format: "(%.5f, %.5f)", katec.x, katec.y))\n
        UTM-K 좌표
        \(String(format: "(%.5f, %.5f)", utmk.x, utmk.y))\n
        TM 좌표
        \(String(format: "(%.5f, %.5f)", tm.x, tm.y))\n
        GRS80 좌표
        \(String(format: "(%.5f, %.5f)", grs80.x, grs80.y))
        """
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
