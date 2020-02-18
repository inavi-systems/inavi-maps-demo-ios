import UIKit
import iNaviMaps

class INVNumberItem: NSObject, INVClusterItem {
    var position: INVLatLng
    var number: Int
    
    init(position: INVLatLng, number: Int) {
        self.position = position
        self.number = number
    }
}

class MarkerClusteringViewController: MapViewController {
    private let backgroundColors = [UIColor(hex: 0x0099cc),
                                    UIColor(hex: 0x669900),
                                    UIColor(hex: 0xff8800),
                                    UIColor(hex: 0xcc0000),
                                    UIColor(hex: 0x9933cc)]
    private let criteria: [NSNumber] = [10, 50, 100, 200, 500];
    private let markerImages: [INVImage] = [INV_MARKER_IMAGE_RED, INV_MARKER_IMAGE_GREEN, INV_MARKER_IMAGE_BLUE, INV_MARKER_IMAGE_YELLOW, INV_MARKER_IMAGE_GRAY]
    
    let position = INVLatLng(lat: 37.40219, lng: 127.11077)
    var clusterManager: INVClusterManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clusterManager = INVClusterManager.init(mapView: mapView)
        clusterManager?.delegate = self
        
        let iconGenerator = INVDefaultClusterIconGenerator(colors: backgroundColors, criteria: criteria)
        clusterManager?.clusterIconGenerator = iconGenerator
        
        self.mapView?.moveCamera(INVCameraUpdate.init(zoomTo: 13.0))
        self.mapView?.showZoomControl = true
        
        for index in 1...1000 {
            let item = INVNumberItem(position: generateRandomPosition(),
                                     number: index)
            clusterManager?.add(item)
        }
    }
    
    private func generateRandomPosition() -> INVLatLng {
        func randomScale() -> Double {
            return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
        }
        
        let extent = 0.02
        return INVLatLng(lat: position.lat + extent * randomScale(),
                         lng: position.lng + extent * randomScale())
    }
}

extension MarkerClusteringViewController: INVClusterManagerDelegate {
    func clusterManager(_ clusterManager: INVClusterManager, willRenderCluster cluster: INVCluster, with markerOptions: INVMarkerOptions) {
        markerOptions.position = cluster.position
    }
    
    func clusterManager(_ clusterManager: INVClusterManager, willRenderClusterItem clusterItem: INVClusterItem, with markerOptions: INVMarkerOptions) {
        markerOptions.position = clusterItem.position
        markerOptions.iconScale = 0.8
        if let item = clusterItem as? INVNumberItem {
            markerOptions.iconImage = markerImages[item.number % markerImages.count]
            markerOptions.title     = "마커 #\(item.number)"
        }
    }
    
    func clusterManager(_ clusterManager: INVClusterManager, didTap cluster: INVCluster, with markerOptions: INVMarkerOptions) -> Bool {
        let position = cluster.position
        let count = cluster.count
        let message = "위치 : \(position.formattedString)\n포함된 아이템 개수 : \(count)개"
        let alert = UIAlertController(title: "클러스터 클릭",
                                      message: message,
                                      preferredStyle: .alert)
        self.present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        })
        
        let cameraUpdate = INVCameraUpdate.init(targetTo: position)
        cameraUpdate.animation = .easeIn
        self.mapView?.moveCamera(cameraUpdate)
        
        return true
    }
    
    func clusterManager(_ clusterManager: INVClusterManager, didTap clusterItem: INVClusterItem, with markerOptions: INVMarkerOptions) -> Bool {
        let position = clusterItem.position
        var message = "위치 : \(position.formattedString)"
        if let item = clusterItem as? INVNumberItem {
            message.append("\n번호 : \(item.number)")
        }
        let alert = UIAlertController(title: "아이템 클릭",
                                      message: message,
                                      preferredStyle: .alert)
        self.present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        })
        
        let cameraUpdate = INVCameraUpdate.init(targetTo: position)
        cameraUpdate.animation = .easeIn
        self.mapView?.moveCamera(cameraUpdate)
        
        return true
    }
}

extension UIColor {
    convenience init(hex: Int) {
        self.init(
            red:   CGFloat((hex & 0xff0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00ff00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000ff) >> 0)  / 255.0,
            alpha: 1.0
        )
    }
}
