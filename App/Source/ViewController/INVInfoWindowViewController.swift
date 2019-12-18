import UIKit
import iNaviMaps

class CustomInfoWindowView: UIView {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
}

class CustomInfoWindowDataSource: NSObject, INVImageViewDataSource {
    var rootView: CustomInfoWindowView!
    func view(with shape: INVShape) -> UIView {
        guard let infoWindow = shape as? INVInfoWindow else { return rootView }
        if rootView == nil {
            rootView = Bundle.main.loadNibNamed("CustomInfoWindowView", owner: nil, options: nil)?.first as? CustomInfoWindowView
        }
        
        if let marker = infoWindow.marker {
            rootView.iconView.image = UIImage(named: "baseline_room_black_24pt")
            rootView.textLabel.text = marker.userInfo["title"] as? String
        } else {
            rootView.iconView.image = UIImage(named: "baseline_gps_fixed_black_24pt")
            rootView.textLabel.text = String(format: "(%.5f, %.5f)", infoWindow.position.lat, infoWindow.position.lng)
        }
        rootView.textLabel.sizeToFit()
        
        let textWidth = rootView.textLabel.frame.size.width
        let iconWidth = rootView.iconView.frame.size.width
        let viewWidth = iconWidth + textWidth + 32
        
        var rect = rootView.frame
        rect.size.width = viewWidth
        rect.size.height = 57
        rootView.frame = rect
        rootView.layoutIfNeeded()
        
        return rootView
    }
}

class TextInfoWindowDataSource: NSObject, INVImageTextDataSource {
    func title(with shape: INVShape) -> String {
        return shape.userInfo["title"] as? String ?? ""
    }
}

class INVInfoWindowViewController: MapViewController {
    
    let initPosition = INVLatLng(lat: 37.40219, lng: 127.11077)
    let infoWindow = INVInfoWindow()
    let customInfoWindowDataSource = CustomInfoWindowDataSource()
    let textInfoWindowDataSource = TextInfoWindowDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        shapeInit()
    }
    
    func shapeInit() {
        let title = String(format: "좌표 : (%.5f, %.5f)", initPosition.lat, initPosition.lng)
        infoWindow.position = initPosition
        infoWindow.userInfo["title"] = title
        infoWindow.touchEvent = { [weak self] (shape: INVShape) -> Bool in
            self?.infoWindow.mapView = nil
            return true
        }
        infoWindow.imageDataSource = textInfoWindowDataSource
        infoWindow.mapView = mapView
        
        let markerTouchEvent = { [weak self] (shape: INVShape) -> Bool in
            if let marker = shape as? INVMarker {
                let infoWindow = self?.infoWindow
                if let infoWindow = infoWindow {
                    infoWindow.userInfo["title"] = "마커 : \(marker.userInfo["title"] as! String)"
                    infoWindow.marker = marker
                    if (infoWindow.mapView == nil) {
                        infoWindow.mapView = self?.mapView
                    } else {
                        infoWindow.invalidate()
                    }
                }
            }
            return true
        }
        
        let marker1 = INVMarker(position: INVLatLng(lat: 37.40465, lng: 127.10986))
        marker1.iconImage = INV_MARKER_IMAGE_RED
        marker1.touchEvent = markerTouchEvent
        marker1.userInfo = ["title" : "RED"]
        marker1.mapView = mapView
        
        let marker2 = INVMarker(position: INVLatLng(lat: 37.40058, lng: 127.11231))
        marker2.iconImage = INV_MARKER_IMAGE_BLUE
        marker2.touchEvent = markerTouchEvent
        marker2.userInfo = ["title" : "BLUE"]
        marker2.mapView = mapView
    }
    
    func didTapMapView(_ point: CGPoint, latLng latlng: INVLatLng) {
        let title = String(format: "좌표 : (%.5f, %.5f)", latlng.lat, latlng.lng)
        infoWindow.position = latlng
        infoWindow.userInfo["title"] = title
        if (infoWindow.mapView == nil) {
            infoWindow.mapView = mapView
        } else {
            infoWindow.invalidate()
        }
    }
    
    @IBAction func respondToCustomInfoWindow(_ sender: UISwitch) {
        if (sender.isOn) {
            infoWindow.imageDataSource = customInfoWindowDataSource
        } else {
            infoWindow.imageDataSource = textInfoWindowDataSource
        }
    }
}
