import UIKit
import iNaviMaps

class CameraEventViewController: MapViewController {
    
    @IBOutlet weak var cameraPositionLabel: UILabel!
    @IBOutlet weak var cameraMoveButton: UIActionButton!
    
    let position1 = INVLatLng(lat: 37.40219, lng: 127.11077)
    let position2 = INVLatLng(lat: 36.99473, lng: 127.81832)
    let labelTextFormat = "상태 : %@\n위치 : (%.5f, %.5f)\n줌 레벨 : %.2f\n기울기 : %.2f\n베어링 : %.2f"
    
    var isInitPosition = true
    var isMovingByButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeInit()
    }
    
    func shapeInit() {
        let marker1 = INVMarker(position: position1)
        marker1.mapView = mapView
        
        let marker2 = INVMarker(position: position2, iconImage: INV_MARKER_IMAGE_BLUE)
        marker2.mapView = mapView
        
        showCameraPositionInfo(false)
        cameraPositionLabel?.isHidden = false
    }
    
    func showCameraPositionInfo(_ isMoving: Bool) {
        if let mapView = self.mapView {
            let statusText = isMoving ? "이동" : "대기"
            let cameraPosition = mapView.cameraPosition
            cameraPositionLabel?.text = String(format: labelTextFormat, statusText, cameraPosition.target.lat, cameraPosition.target.lng, cameraPosition.zoom, cameraPosition.tilt, cameraPosition.bearing)
        }
    }

    func mapView(_ mapView: InaviMapView, regionIsChangingWithReason reason: Int) {
        showCameraPositionInfo(true)
    }

    func mapView(_ mapView: InaviMapView, regionDidChangeAnimated animated: Bool, reason: Int) {
        showCameraPositionInfo(false)
    }

    @IBAction func respondToCameraMove(_ sender: UIActionButton) {
        if isMovingByButton {
            mapView?.cancelTransitions()
            return
        }
        
        let cameraUpdate = INVCameraUpdate(position: INVCameraPosition(isInitPosition ? position2 : position1, zoom: 14.0))
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 3
        mapView?.moveCamera(cameraUpdate, completion: { [weak self] (isCancelled) in
            self?.isMovingByButton = false
            self?.cameraMoveButton?.isSelected = false

            let alert = UIAlertController(title: isCancelled ? "카메라 이동 취소" : "카메라 이동 완료",
                                          message: nil,
                                          preferredStyle: .alert)
            self?.present(alert, animated: true, completion: {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                    alert.dismiss(animated: true, completion: nil)
                })
            })
            self?.cameraMoveButton?.setImage(UIImage(named: "baseline_play_arrow_white_24pt"), for: .normal)
        })
        
        isMovingByButton = true
        cameraMoveButton?.setImage(UIImage(named: "baseline_stop_white_24pt"), for: .normal)
        
        isInitPosition.toggle()
    }
}
