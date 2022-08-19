import UIKit
import iNaviMaps

class LocationIconViewController: MapViewController {

    @IBOutlet weak var locationIconImageSwitch: UISwitch!
    @IBOutlet weak var locationIconScaleSwitch: UISwitch!
    @IBOutlet weak var locationIconCircleRadiusSwitch: UISwitch!
    @IBOutlet weak var locationIconCircleColorSwitch: UISwitch!
    @IBOutlet weak var locationIconBearingLabel: UILabel!
    @IBOutlet weak var locationIconBearingSlider: UISlider!
    @IBOutlet weak var locationIconBearingValueLabel: UILabel!
    
    let custom_location_icon_image = INVImage(name: "baseline_directions_run_black_36pt")
    var locationIcon: INVLocationIcon? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationIcon = mapView.locationIcon
        
        locationIcon?.position = mapView.cameraPosition.target
        locationIcon?.touchEvent = { [weak self] (shape: INVShape) in
            let alert = UIAlertController(title: "위치 아이콘 클릭됨",
                                          message: nil,
                                          preferredStyle: .alert)
            self?.present(alert, animated: true, completion: {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                    alert.dismiss(animated: true, completion: nil)
                })
            })
            return true
        }
    }
    
    func didTapMapView(_ point: CGPoint, latLng latlng: INVLatLng) {
        locationIcon?.position = latlng
    }
    
    @IBAction func respondToLocationIconVisible(_ sender: UISwitch) {
        locationIcon?.isVisible = sender.isOn
        
        locationIconImageSwitch.isEnabled = sender.isOn
        locationIconScaleSwitch.isEnabled = sender.isOn
        locationIconCircleRadiusSwitch.isEnabled = sender.isOn
        locationIconCircleColorSwitch.isEnabled = sender.isOn
        locationIconBearingLabel.isEnabled = sender.isOn
        locationIconBearingSlider.isEnabled = sender.isOn
        locationIconBearingValueLabel.isEnabled = sender.isOn
    }
    
    @IBAction func respondToLocationIconImage(_ sender: UISwitch) {
        locationIcon?.image = sender.isOn ? custom_location_icon_image : INV_LOCATION_ICON_IMAGE
    }
    
    @IBAction func respondToLocationIconScale(_ sender: UISwitch) {
        locationIcon?.scale = sender.isOn ? 2.0 : 1.0
    }
    
    @IBAction func respondToLocationIconCircleRadius(_ sender: UISwitch) {
        locationIcon?.circleRadius = sender.isOn ? 48.0 : 24.0
    }
    
    @IBAction func respondToLocationIconCircleColor(_ sender: UISwitch) {
        locationIcon?.circleColor = sender.isOn ? UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5) : INV_LOCATION_ICON_CIRCLE_COLOR
    }
    
    @IBAction func respondToLocationIconBearing(_ sender: UISlider) {
        locationIcon?.bearing = CGFloat(sender.value)
        locationIconBearingValueLabel.text = "\(Int(sender.value))°"
    }
}
