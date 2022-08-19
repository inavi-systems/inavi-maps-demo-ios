import UIKit
import iNaviMaps

class MapClickEventViewController: MapViewController {
    
    @IBOutlet weak var consumeEventSwitch: UISwitch!
    
    var useClickEvent = true
    var useLongClickEvent = true
    var useDoubleClickEvent = true
    var consumeDoubleClickEvent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didTapMapView(_ point: CGPoint, latLng latlng: INVLatLng) {
        if useClickEvent {
            showAlertMessage("지도 클릭", point: point, latlng: latlng)
        }
    }
    
    func didDoubleTapMapView(_ point: CGPoint, latLng latlng: INVLatLng) -> Bool {
        if useDoubleClickEvent {
            showAlertMessage("지도 더블 클릭", point: point, latlng: latlng)
        }
        
        return useDoubleClickEvent && consumeDoubleClickEvent
    }
    
    func didLongTapMapView(_ point: CGPoint, latLng latlng: INVLatLng) {
        if useLongClickEvent {
            showAlertMessage("지도 롱 클릭", point: point, latlng: latlng)
        }
    }
    
    func showAlertMessage(_ title: String, point: CGPoint, latlng: INVLatLng) {
        let message = String(format: "화면 : (%.0f, %.0f)\n지도 : %@", point.x, point.y, latlng.formattedString)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 1.5), execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func respondToMapClickEvent(_ sender: UISwitch) {
        switch (sender.tag) {
        case 0: // use map click event
            self.useClickEvent = sender.isOn
        case 1: // use map long click event
            self.useLongClickEvent = sender.isOn
        case 2: // use map double click event
            self.useDoubleClickEvent = sender.isOn
            self.consumeEventSwitch?.isEnabled = sender.isOn
        case 3: // consmue double click event
            self.consumeDoubleClickEvent = sender.isOn
        default:
            break
        }
    }
}

extension INVLatLng {
    var formattedString: String {
        return String(format: "(%.5f, %.5f)", lat, lng)
    }
}
