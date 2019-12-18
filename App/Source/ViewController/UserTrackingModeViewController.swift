import UIKit
import iNaviMaps

class UserTrackingModeViewController: MapViewController {
    
    @IBOutlet weak var selectButton: UIButton!
    
    let userTrackingModes = ["None", "NoTracking", "Tracking", "TrackingCompass"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView?.userTrackingMode = .tracking
        mapView?.showLocationButton = true
    }
    
    func mapView(_ mapView: InaviMapView, didChange mode: INVUserTrackingMode, animated: Bool) {
        var index = 0
        switch mode {
        case .noTracking:
            index = 1
        case .tracking:
            index = 2
        case .trackingCompass:
            index = 3
        default:
            break
        }
        
        UIView.performWithoutAnimation {
            self.selectButton?.setTitle(self.userTrackingModes[index], for: .normal)
            self.selectButton?.layoutIfNeeded()
        }
    }
    
    @IBAction func respondToUserTrackingMode(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "위치 추적 모드 선택", message: nil, preferredStyle: .actionSheet)
        
        for (index, userTrackingMode) in userTrackingModes.enumerated() {
            actionSheet.addAction(UIAlertAction(title: userTrackingMode, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                switch index {
                case 1:
                    self.mapView.userTrackingMode = .noTracking
                case 2:
                    self.mapView.userTrackingMode = .tracking
                case 3:
                    self.mapView.userTrackingMode = .trackingCompass
                default:
                    self.mapView.userTrackingMode = .none
                    break
                }
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "닫기", style: .cancel))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}
