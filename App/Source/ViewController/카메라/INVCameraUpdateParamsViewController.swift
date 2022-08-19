import UIKit
import iNaviMaps

class INVCameraUpdateParamsViewController: MapViewController {
    
    let position1 = INVLatLng(lat: 37.40219, lng: 127.11077)
    let position2 = INVLatLng(lat: 36.99473, lng: 127.81832)
    let maximumTilt = 60.0
    
    var updateTarget = false
    var updateZoom = true
    var updateTilt = true
    var updateBearing = true
    
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
    
    @IBAction func respondToCameraUpdateTarget(_ sender: UISwitch) {
        updateTarget = sender.isOn
    }
    
    @IBAction func respondToCameraUpdateZoom(_ sender: UISwitch) {
        updateZoom = sender.isOn
    }
    
    @IBAction func respondToCameraUpdateTilt(_ sender: UISwitch) {
        updateTilt = sender.isOn
    }
    
    @IBAction func respondToCameraUpdateBearing(_ sender: UISwitch) {
        updateBearing = sender.isOn
    }
    
    @IBAction func respondToCameraUpdate(_ sender: UIButton) {
        let params = INVCameraUpdateParams()
        let cameraPosition = mapView.cameraPosition
        var duration = 1.0
        if updateTarget {
            params.target(to: isInitPosition ? position2 : position1)
            isInitPosition.toggle()
            duration = 5.0
        }
        if updateZoom {
            var zoomDelta = 3.0
            if (cameraPosition.zoom + zoomDelta >= mapView.maximumZoomLevel) {
                zoomDelta *= -1
            }
            params.zoom(by: zoomDelta)
        }
        if (updateTilt) {
            var tiltDelta = 10.0
            if (cameraPosition.tilt + tiltDelta >= maximumTilt) {
                tiltDelta *= -1
            }
            params.tilt(by: tiltDelta)
        }
        if (updateBearing) {
            params.bearing(by: 30)
        }
        
        let cameraUpdate = INVCameraUpdate(params: params)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = duration
        
        mapView?.moveCamera(cameraUpdate)
    }
}
