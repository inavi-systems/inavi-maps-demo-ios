import UIKit
import iNaviMaps

class MapViewController: UIViewController, INVMapViewDelegate {
	@IBOutlet weak var mapView: InaviMapView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView?.delegate = self
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.92, green: 0.16, blue: 0.19, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
