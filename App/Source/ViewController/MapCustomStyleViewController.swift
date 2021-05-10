import UIKit
import iNaviMaps

class MapCustomStyleViewController: MapViewController, INVMapSdkDelegate {
    @IBOutlet weak var selectButton: UIButton!

    func showAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    func authSuccess(_ customMapStyles: [INVMapStyle]) {
        if customMapStyles.isEmpty {
            showAlert(title: "", text: "커스텀 지도 스타일이 없습니다.")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        shapeInit()
        self.selectButton?.setTitle("기본 스타일", for: .normal)
        INVMapSdk.sharedInstance().delegate = self
    }


    @IBAction func respondCustomMapStyle(_ sender: UIButton) {
        if INVMapSdk.sharedInstance().savedCustomMapStyles.isEmpty {
            showAlert(title: "", text: "커스텀 지도 스타일이 없습니다.")
            return;
        }

        let alertController = UIAlertController(title: "지도 스타일", message: nil, preferredStyle: .actionSheet)
        var styleItems: Array<(title: String, mapStyle: INVMapStyle?)> = [];
        styleItems.append((title: "기본 스타일", mapStyle: nil))
        styleItems.append(contentsOf: INVMapSdk.sharedInstance().savedCustomMapStyles.map { style in
            (title: style.styleName, mapStyle: style)
        })
        styleItems.forEach { item in
            alertController.addAction(UIAlertAction(title: item.title, style: .default, handler: { alert in
                self.selectButton?.setTitle(item.title as String, for: .normal)
                self.mapView.customMapStyle = item.mapStyle
            }))
        }

        alertController.addAction(UIAlertAction(title: "닫기", style: .cancel))

        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func shapeInit() {
        let marker1 = INVMarker()
        marker1.position = INVLatLng(lat: 37.40219, lng: 127.11077)
        marker1.mapView = mapView

        let rightBottomImage = UIImage(named: "inv_marker_right_bottom")
        var marker2Image: INVImage? = nil
        if let rightBottomImage = rightBottomImage {
            marker2Image = INVImage(image: rightBottomImage)
        }
        let marker2 = INVMarker()
        marker2.position = INVLatLng(lat: 37.40465, lng: 127.10986)
        if let marker2Image = marker2Image {
            marker2.iconImage = marker2Image
            marker2.anchor = CGPoint(x: 0.9, y: 0.9)
            marker2.angle = 90
        }
        marker2.mapView = mapView

        let marker3 = INVMarker()
        marker3.position = INVLatLng(lat: 37.40274, lng: 127.10806)
        marker3.iconImage = INV_MARKER_IMAGE_BLUE
        marker3.titleColor = UIColor.green
        marker3.mapView = mapView

        let marker4 = INVMarker()
        marker4.position = INVLatLng(lat: 37.39990, lng: 127.10965)
        marker4.iconImage = INV_MARKER_IMAGE_YELLOW
        marker4.titleSize = 16
        marker4.mapView = mapView

        let marker5 = INVMarker()
        marker5.position = INVLatLng(lat: 37.40324, lng: 127.11276)
        marker5.iconImage = INV_MARKER_IMAGE_GREEN
        marker5.alpha = 0.5
        marker5.mapView = mapView

        let marker6 = INVMarker()
        marker6.position = INVLatLng(lat: 37.40058, lng: 127.11231)
        marker6.iconImage = INVImage(name: "baseline_star_black_24pt")
        marker6.iconScale = 2.0
        marker6.anchor = CGPoint(x: 0.5, y: 0.5)
        marker6.mapView = mapView

        let polyline1 = INVPolyline(coords: [INVLatLng(lat: 37.40915, lng: 127.11400),
                                             INVLatLng(lat: 37.40465, lng: 127.10986),
                                             INVLatLng(lat: 37.40071, lng: 127.11590),
                                             INVLatLng(lat: 37.39945, lng: 127.10839)])
        polyline1.color = UIColor.red
        polyline1.width = 3
        polyline1.mapView = mapView

        let polyline2 = INVPolyline(coords: [INVLatLng(lat: 37.39945, lng: 127.10839),
                                             INVLatLng(lat: 37.39492, lng: 127.11127)])
        polyline2.color = UIColor.blue
        polyline2.pattern = [10, 10]
        polyline2.width = 3
        polyline2.mapView = mapView
    }
}
