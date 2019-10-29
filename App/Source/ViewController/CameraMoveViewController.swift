import UIKit
import iNaviMaps

class CameraMoveViewController: MapViewController, UIActionSheetDelegate {
    
    @IBOutlet weak var selectButton: UIButton!
    
    let position1 = INVLatLng(lat: 37.40219, lng: 127.11077)
    let position2 = INVLatLng(lat: 36.99473, lng: 127.81832)
    
    var isInitPosition = true
    var cameraUpdateAnimation = INVCameraUpdateAnimation.none
    
    let animationTypes = ["None", "Linear", "Ease In", "Ease Out", "Fly"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeInit()
    }
    
    func shapeInit() {
        let marker1 = INVMarker(position: position1)
        marker1.mapView = mapView
        
        let marker2 = INVMarker(position: position2, iconImage: INV_MARKER_IMAGE_BLUE)
        marker2.mapView = mapView
    }
    
    @IBAction func respondToCameraUpdateAnimation(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "애니메이션 선택", message: nil, preferredStyle: .actionSheet)
        
        for (index, animationType) in animationTypes.enumerated() {
            actionSheet.addAction(UIAlertAction(title: animationType, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                switch index {
                case 1:
                    self.cameraUpdateAnimation = INVCameraUpdateAnimation.linear
                case 2:
                    self.cameraUpdateAnimation = INVCameraUpdateAnimation.easeIn
                case 3:
                    self.cameraUpdateAnimation = INVCameraUpdateAnimation.easeOut
                case 4:
                    self.cameraUpdateAnimation = INVCameraUpdateAnimation.fly
                default:
                    self.cameraUpdateAnimation = INVCameraUpdateAnimation.none
                    break
                }
                
                UIView.performWithoutAnimation {
                    self.selectButton?.setTitle(self.animationTypes[index], for: .normal)
                    self.selectButton?.layoutIfNeeded()
                }
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "닫기", style: .cancel))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func respondToCameraMove(_ sender: UIButton) {
        let cameraUpdate = INVCameraUpdate(targetTo: isInitPosition ? position2 : position1)
        cameraUpdate.animation = cameraUpdateAnimation
        cameraUpdate.animationDuration = 3
        mapView?.moveCamera(cameraUpdate)
        
        isInitPosition.toggle()
    }
}
