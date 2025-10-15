import UIKit
import iNaviMaps

class IndoorMapController: MapViewController {
    @IBOutlet weak var pickerBackgorund: UIView!
    @IBOutlet weak var picker: UIPickerView!

    private var currentPlaceId: NSNumber? = nil
    private var floors: [INVFloor] = []
    private var currentFloor: INVFloor? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        let marketTarget = INVLatLng(lat: 37.49380, lng: 127.11573)
        let marketCameraUpdate = INVCameraUpdate(targetTo: marketTarget, zoomTo: 16.0)
        mapView.moveCamera(marketCameraUpdate)

        pickerBackgorund.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        pickerBackgorund.layer.cornerRadius = 12
        pickerBackgorund.layer.masksToBounds = false
        picker.dataSource = self
        picker.delegate = self
        picker.isHidden = true
    }

    func mapView(_ mapView: InaviMapView, didChangeIndoor placeId: NSNumber?, floors: [INVFloor]?, floor: INVFloor?) {
        applyIndoorUpdate(placeId: placeId, floors: floors ?? [], floor: floor)
    }
    
    @IBAction func respondToSwitch(_ sender: UISwitch) {
        mapView.isIndoorMapEnabled = sender.isOn
    }
}

extension IndoorMapController {
    private func applyIndoorUpdate(placeId: NSNumber?, floors: [INVFloor], floor: INVFloor?) {
        print("applyIndoorUpdate - placeId: \(String(describing: placeId)), floor: \(String(describing: floor?.floorId))")

        let hasPlaceChanged = (currentPlaceId != placeId)

        if hasPlaceChanged {
            currentPlaceId = placeId
            self.floors = floors
            self.currentFloor = floor

            if placeId == nil {
                picker.isHidden = true
                picker.reloadAllComponents()
            } else {
                picker.isHidden = false
                picker.reloadAllComponents()
                selectCurrentFloor(newFloors: floors, selectedFloor: floor)
            }
        } else {
            self.currentFloor = floor
            selectCurrentFloor(newFloors: self.floors, selectedFloor: floor)
        }
    }

    private func selectCurrentFloor(newFloors: [INVFloor], selectedFloor: INVFloor?) {
        guard let selected = selectedFloor else { return }
        if let idx = newFloors.firstIndex(where: { $0.floorId == selected.floorId }) {
            picker.selectRow(idx, inComponent: 0, animated: true)
        }
    }
}

extension IndoorMapController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        floors.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        floors[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard floors.indices.contains(row) else { return }
        let floor = floors[row]
        currentFloor = floor
        mapView.setIndoorFloor(floor)
    }
}
