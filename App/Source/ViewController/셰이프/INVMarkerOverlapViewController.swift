import UIKit
import iNaviMaps

class INVMarkerOverlapViewController: MapViewController {
    
    var markers: [INVMarker] = []
    let markerImages: [INVImage] = [INV_MARKER_IMAGE_RED, INV_MARKER_IMAGE_GREEN, INV_MARKER_IMAGE_BLUE, INV_MARKER_IMAGE_YELLOW, INV_MARKER_IMAGE_GRAY]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeInit()
    }
    
    func shapeInit() {
        let bounds = mapView.contentBounds
        for index in 1...50 {
            let marker = INVMarker(position:
                INVLatLng(
                    lat: (bounds.northEast.lat - bounds.southWest.lat) * drand48() + bounds.southWest.lat,
                    lng: (bounds.northEast.lng - bounds.southWest.lng) * drand48() + bounds.southWest.lng
                )
            )
            let idx = Int(arc4random_uniform(UInt32(markerImages.count)))
            marker.iconImage = markerImages[idx]
            marker.title = "마커 #\(index)"
            marker.mapView = mapView
            markers.append(marker)
        }
    }
    
    @IBAction func respondToAllowMarkerOverlap(_ sender: UISwitch) {
        for marker in markers {
            marker.isAllowOverlapMarkers = sender.isOn
        }
    }
    
    @IBAction func respondToAllowTitleOverlap(_ sender: UISwitch) {
        for marker in markers {
            marker.isAllowOverlapTitle = sender.isOn
        }
    }
    
	@IBAction func respondToAllowSymbolOverlapEnabled(_ sender: UISwitch) {
        for marker in markers {
            marker.isAllowOverlapSymbols = sender.isOn
        }
	}
    
	@IBAction func respondToAnimationEnabled(_ sender: UISwitch) {
        for marker in markers {
            marker.isTransitionEnabled = sender.isOn
        }
    }
}
