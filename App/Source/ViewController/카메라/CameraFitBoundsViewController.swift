import UIKit
import iNaviMaps

class CameraFitBoundsViewController: MapViewController {
    
    @IBOutlet weak var fitBoundsButton: UIActionButton!
    
    let position1 = INVLatLng(lat: 37.40219, lng: 127.11077)
    let position2 = INVLatLng(lat: 36.99473, lng: 127.81832)
    
    var isInitPosition = true
    
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
    
    func mapView(_ mapView: InaviMapView, regionIsChangingWithReason reason: Int) {
        if (isInitPosition && reason == INV_CAMERA_UPDATE_REASON_GESTURE) {
            isInitPosition = false
            fitBoundsButton?.setImage(UIImage(named: "baseline_replay_white_24pt"), for: .normal)
        }
    }
    
    @IBAction func respondToFitBounds(_ sender: UIActionButton) {
        var cameraUpdate: INVCameraUpdate
        if (isInitPosition) {
            cameraUpdate = INVCameraUpdate(fit: INVLatLngBounds(southWest: position1, northEast: position2), padding: 24)
        } else {
            cameraUpdate = INVCameraUpdate(position: INVCameraPosition(position1, zoom: 15.0))
        }
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 3
        mapView?.moveCamera(cameraUpdate)
        
        let imageName = isInitPosition ? "baseline_replay_white_24pt" : "baseline_control_camera_white_24pt"
        fitBoundsButton?.setImage(UIImage(named: imageName), for: .normal)
        
        isInitPosition.toggle()
    }
}
