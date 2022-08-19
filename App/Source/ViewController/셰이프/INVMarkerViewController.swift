import UIKit
import iNaviMaps

class INVMarkerViewController: MapViewController {
    
    private let marker1 = INVMarker()
    private let marker2 = INVMarker()
    private let marker3 = INVMarker()
    private let marker4 = INVMarker()
    private let marker5 = INVMarker()
    private let marker6 = INVMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeInit()
    }
    
    private func shapeInit() {

        marker1.position = INVLatLng(lat: 37.40219, lng: 127.11077)
        marker1.title = "타이틀"
        marker1.mapView = mapView
        
        let rightBottomImage = UIImage(named: "inv_marker_right_bottom")
        var marker2Image: INVImage? = nil
        if let rightBottomImage = rightBottomImage {
            marker2Image = INVImage(image: rightBottomImage)
        }
        
        marker2.position = INVLatLng(lat: 37.40465, lng: 127.10986)
        if let marker2Image = marker2Image {
            marker2.iconImage = marker2Image
            marker2.anchor = CGPoint(x: 0.9, y: 0.9)
            marker2.angle = 90
        }
        marker2.mapView = mapView
        
        marker3.position = INVLatLng(lat: 37.40274, lng: 127.10806)
        marker3.iconImage = INV_MARKER_IMAGE_BLUE
        marker3.titleColor = UIColor.green
        marker3.title = "타이틀 색상 적용"
        marker3.mapView = mapView
        
        marker4.position = INVLatLng(lat: 37.39990, lng: 127.10965)
        marker4.iconImage = INV_MARKER_IMAGE_YELLOW
        marker4.titleSize = 16
        marker4.title = "타이틀 크기 적용"
        marker4.mapView = mapView
        
        marker5.position = INVLatLng(lat: 37.40324, lng: 127.11276)
        marker5.iconImage = INV_MARKER_IMAGE_GREEN
        marker5.alpha = 0.5
        marker5.title = "반투명 마커"
        marker5.mapView = mapView
        
        marker6.position = INVLatLng(lat: 37.40058, lng: 127.11231)
        marker6.iconImage = INVImage(name: "baseline_star_black_24pt")
        marker6.iconScale = 2.0
        marker6.anchor = CGPoint(x: 0.5, y: 0.5)
        marker6.mapView = mapView
    }
    
    @IBAction func respondToDeleteMarker(_ sender: UISwitch) {
        let allMarkers = [marker1, marker2, marker3, marker4, marker5, marker6]
        if (sender.isOn) {
            allMarkers.forEach { $0.mapView = nil }
        } else {
            allMarkers.forEach { $0.mapView = mapView }
        }
    }
}
