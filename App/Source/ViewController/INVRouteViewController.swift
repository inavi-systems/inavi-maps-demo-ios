import UIKit
import iNaviMaps

class INVRouteViewController: MapViewController {
    let links = [
        INVRouteLink(coords: [
            INVLatLng(lat: 37.39475, lng: 127.11271),
            INVLatLng(lat: 37.39606, lng: 127.11274),
            INVLatLng(lat: 37.39608, lng: 127.11273),
            INVLatLng(lat: 37.39611, lng: 127.11270),
            INVLatLng(lat: 37.39614, lng: 127.11262),
            INVLatLng(lat: 37.39614, lng: 127.11141),
            INVLatLng(lat: 37.39616, lng: 127.11134),
            INVLatLng(lat: 37.39620, lng: 127.11127),
            INVLatLng(lat: 37.39624, lng: 127.11124),
            INVLatLng(lat: 37.39629, lng: 127.11122),
            INVLatLng(lat: 37.39633, lng: 127.11121)
        ], lineColor: .red, stroke: .white),
        INVRouteLink(coords: [
            INVLatLng(lat: 37.39633, lng: 127.11121),
            INVLatLng(lat: 37.39976, lng: 127.11123)
        ], lineColor: .green, stroke: .white),
        INVRouteLink(coords: [
            INVLatLng(lat: 37.39976, lng: 127.11123),
            INVLatLng(lat: 37.40091, lng: 127.11120)
        ], lineColor: .blue, stroke: .white),
        INVRouteLink(coords: [
            INVLatLng(lat: 37.40091, lng: 127.11120),
            INVLatLng(lat: 37.40156, lng: 127.11118),
            INVLatLng(lat: 37.40160, lng: 127.11116),
            INVLatLng(lat: 37.40162, lng: 127.11112),
            INVLatLng(lat: 37.40162, lng: 127.11085),
            INVLatLng(lat: 37.40164, lng: 127.11081),
            INVLatLng(lat: 37.40167, lng: 127.11078),
            INVLatLng(lat: 37.40170, lng: 127.11077),
            INVLatLng(lat: 37.40217, lng: 127.11077)
        ], lineColor: .red, stroke: .white),
    ]
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lbProgress: UILabel!
    @IBOutlet weak var switchFlat: UISwitch!
    @IBOutlet weak var switchVisible: UISwitch!

    let normalIcon = INVImage(name: "inv_marker_route_normal");
    let flatIcon = INVImage(name: "inv_marker_route_flat");
    
    let routeShape  = INVRoute()
    let passMarker  = INVMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        
        self.mapView?.moveCamera(INVCameraUpdate(targetTo: INVLatLng(lat: 37.39797, lng: 127.11120), zoomTo: 14.0))
        shapeInit()
    }
    
    func shapeInit() {
        routeShape.delegate         = self
        routeShape.links            = links
        routeShape.lineWidth        = 10
        routeShape.strokeWidth      = 2
        routeShape.passLineColor    = .lightGray
        routeShape.passStrokeColor  = .white
        routeShape.mapView          = self.mapView
        routeShape.patternImage     = INVImage(name: "inv_pattern_arrow")
        routeShape.patternMargin    = 15
        routeShape.patternScale        = 0.8
        

        passMarker.position = links[0].coords[0]
        passMarker.mapView = self.mapView
        
        respondToVisibleIcon(switchVisible)
        respondToFlatIcon(switchFlat)
    }
    
    func updatePassMarker() {
        passMarker.position = routeShape.passPosition
        passMarker.angle    = CGFloat(passMarker.isIconFlat ? routeShape.passAngle : 0)
    }
}

extension INVRouteViewController {
    @IBAction func onValueChanged(_ sender: UISlider) {
        let progressPercent: Int = Int(sender.value * 100)
        lbProgress.text = "\(progressPercent)%"
        routeShape.passRatio = CGFloat(sender.value)
        
        let params = INVCameraUpdateParams()
        params.target(to: passMarker.position)
        params.zoom(to: 16.0)
        params.tilt(to: 40.0)
        params.bearing(to: Double(routeShape.passAngle))
        
        let cameraUpdate = INVCameraUpdate.init(params: params)
        cameraUpdate.animation = .linear
        cameraUpdate.animationDuration = 0.5
        mapView.moveCamera(cameraUpdate)
    }
    
    @IBAction func respondToVisibleIcon(_ sender: UISwitch) {
        passMarker.isVisible = sender.isOn
        switchFlat.isEnabled = sender.isOn
    }
    
    @IBAction func respondToFlatIcon(_ sender: UISwitch) {
        if sender.isOn {
            passMarker.anchor        = CGPoint(x: 0.5, y: 0.5)
            passMarker.iconImage     = flatIcon
            passMarker.isIconFlat    = true;
        } else {
            passMarker.anchor        = CGPoint(x: 0.5, y: 1.0)
            passMarker.iconImage     = normalIcon
            passMarker.isIconFlat    = false;
        }
        updatePassMarker()
    }
}

extension INVRouteViewController: INVRouteDelegate {
    func route(_ route: INVRoute, didChangePassPosition position: INVLatLng, passAngle angle: Double, passDistance distance: Double) {
        updatePassMarker()
    }
}
