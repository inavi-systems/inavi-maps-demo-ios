import UIKit
import iNaviMaps

class INVMultiLineViewController: MapViewController {
    
    let multiline_coords = [
        [
            INVLatLng(lat: 37.39481, lng: 127.11266),
            INVLatLng(lat: 37.39491, lng: 127.11284),
            INVLatLng(lat: 37.39513, lng: 127.11295),
            INVLatLng(lat: 37.39539, lng: 127.11295),
            INVLatLng(lat: 37.39566, lng: 127.11295),
            INVLatLng(lat: 37.39598, lng: 127.11294),
            INVLatLng(lat: 37.39615, lng: 127.11294),
            INVLatLng(lat: 37.39637, lng: 127.11294),
            INVLatLng(lat: 37.39660, lng: 127.11294),
            INVLatLng(lat: 37.39688, lng: 127.11295),
            INVLatLng(lat: 37.39737, lng: 127.11294),
            INVLatLng(lat: 37.39758, lng: 127.11294),
            INVLatLng(lat: 37.39802, lng: 127.11295),
            INVLatLng(lat: 37.39838, lng: 127.11294)],
        [
            INVLatLng(lat: 37.39838, lng: 127.11294),
            INVLatLng(lat: 37.39851, lng: 127.11295),
            INVLatLng(lat: 37.39876, lng: 127.11294),
            INVLatLng(lat: 37.39901, lng: 127.11294),
            INVLatLng(lat: 37.39925, lng: 127.11294),
            INVLatLng(lat: 37.39966, lng: 127.11295),
            INVLatLng(lat: 37.39977, lng: 127.11295),
            INVLatLng(lat: 37.39996, lng: 127.11296),
            INVLatLng(lat: 37.40025, lng: 127.11296),
            INVLatLng(lat: 37.40069, lng: 127.11295),
            INVLatLng(lat: 37.40108, lng: 127.11294),
            INVLatLng(lat: 37.40140, lng: 127.11294),
            INVLatLng(lat: 37.40173, lng: 127.11294),
            INVLatLng(lat: 37.40198, lng: 127.11295),
            INVLatLng(lat: 37.40281, lng: 127.11296)],
        [
            INVLatLng(lat: 37.40281, lng: 127.11296),
            INVLatLng(lat: 37.40301, lng: 127.11294),
            INVLatLng(lat: 37.40322, lng: 127.11292),
            INVLatLng(lat: 37.40344, lng: 127.11289),
            INVLatLng(lat: 37.40364, lng: 127.11285),
            INVLatLng(lat: 37.40386, lng: 127.11280),
            INVLatLng(lat: 37.40408, lng: 127.11272),
            INVLatLng(lat: 37.40420, lng: 127.11268),
            INVLatLng(lat: 37.40437, lng: 127.11262),
            INVLatLng(lat: 37.40459, lng: 127.11254),
            INVLatLng(lat: 37.40486, lng: 127.11241),
            INVLatLng(lat: 37.40501, lng: 127.11233),
            INVLatLng(lat: 37.40519, lng: 127.11222),
            INVLatLng(lat: 37.40532, lng: 127.11212),
            INVLatLng(lat: 37.40549, lng: 127.11201),
            INVLatLng(lat: 37.40563, lng: 127.11192),
            INVLatLng(lat: 37.40573, lng: 127.11184)],
        [
            INVLatLng(lat: 37.40573, lng: 127.11184),
            INVLatLng(lat: 37.40595, lng: 127.11168),
            INVLatLng(lat: 37.40617, lng: 127.11149),
            INVLatLng(lat: 37.40640, lng: 127.11125),
            INVLatLng(lat: 37.40656, lng: 127.11109),
            INVLatLng(lat: 37.40677, lng: 127.11089),
            INVLatLng(lat: 37.40694, lng: 127.11070),
            INVLatLng(lat: 37.40709, lng: 127.11052),
            INVLatLng(lat: 37.40726, lng: 127.11033),
            INVLatLng(lat: 37.40749, lng: 127.11008),
            INVLatLng(lat: 37.40763, lng: 127.10990),
            INVLatLng(lat: 37.40772, lng: 127.10978)],
        [
            INVLatLng(lat: 37.40772, lng: 127.10978),
            INVLatLng(lat: 37.40788, lng: 127.10959),
            INVLatLng(lat: 37.40807, lng: 127.10935),
            INVLatLng(lat: 37.40824, lng: 127.10914),
            INVLatLng(lat: 37.40840, lng: 127.10895),
            INVLatLng(lat: 37.40858, lng: 127.10874),
            INVLatLng(lat: 37.40876, lng: 127.10852),
            INVLatLng(lat: 37.40890, lng: 127.10834),
            INVLatLng(lat: 37.40913, lng: 127.10807),
            INVLatLng(lat: 37.40925, lng: 127.10792),
            INVLatLng(lat: 37.40944, lng: 127.10768),
            INVLatLng(lat: 37.40966, lng: 127.10739),
            INVLatLng(lat: 37.40990, lng: 127.10710),
            INVLatLng(lat: 37.41018, lng: 127.10672)
        ]]
    
    let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.red, UIColor.green]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.moveCamera(INVCameraUpdate(position: INVCameraPosition(INVLatLng(lat: 37.40219, lng: 127.11077), zoom: 14.0)))
        shapeInit()
    }
    
    func shapeInit() {
        var lines: [INVLine] = []
        for (i, coords) in multiline_coords.enumerated() {
            let line = INVLine(coords: coords, color: colors[i])
            lines.append(line)
        }
        
        let multiLine = INVMultiLine(lines: lines)
        multiLine.width = 3
        multiLine.pattern = [10, 10]
        multiLine.mapView = mapView
    }
}
