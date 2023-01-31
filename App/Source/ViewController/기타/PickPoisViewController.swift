import UIKit
import iNaviMaps

class PickPoisViewController: MapViewController {
    let pickRectView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickRectView.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        pickRectView.isUserInteractionEnabled = false
        self.view.addSubview(pickRectView)
    }
    
    func didTapMapView(_ point: CGPoint, latLng latlng: INVLatLng) {
        let cgPickRect = CGRect.init(x: point.x-15, y: point.y-15, width: 30, height: 30)
        pickRectView.frame = cgPickRect
        
        mapView.clearShapes()
        let pois = mapView.pickPois(cgPickRect)
        if !pois.isEmpty {
            let message = pois.map { poi in
                "name: \(poi.name), POI ID: \(poi.poiId)"
            }.joined(separator: "\n")
            showAlertMessage(message)
            
            pois.forEach({
                let marker = INVMarker(position: $0.position, iconImage: INV_MARKER_IMAGE_RED)
                marker.mapView = mapView
                marker.isAllowOverlapMarkers = true
                marker.isAllowOverlapSymbols = true
                marker.iconScale = 0.5
            })
        } else {
            showAlertMessage("선택된 POI가 없습니다.")
        }
    }
    
    func mapView(_ mapView: InaviMapView, regionWillChangeAnimated animated: Bool, reason: Int) {
        pickRectView.frame = CGRect.zero
        mapView.clearShapes()
    }
    
    func showAlertMessage(_ message: String) {
        let alertController = UIAlertController(title: "Pick POIs", message: message, preferredStyle: .alert)
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 1.5), execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
    }
}
