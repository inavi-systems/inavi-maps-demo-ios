import SwiftUI
import iNaviMaps

final class INVNumberItem: NSObject, INVClusterItem {
    var position: INVLatLng
    var number: Int
    init(position: INVLatLng, number: Int) {
        self.position = position
        self.number = number
    }
}

private final class ClusterDelegate: NSObject, INVClusterManagerDelegate {
    var mapView: InaviMapView?
    var onAlert: ((String, String) -> Void)?

    let markerImages: [INVImage] = [
        INV_MARKER_IMAGE_RED, INV_MARKER_IMAGE_GREEN, INV_MARKER_IMAGE_BLUE,
        INV_MARKER_IMAGE_YELLOW, INV_MARKER_IMAGE_GRAY,
    ]

    func clusterManager(_ clusterManager: INVClusterManager, willRenderCluster cluster: INVCluster, with markerOptions: INVMarkerOptions) {
        markerOptions.position = cluster.position
    }

    func clusterManager(_ clusterManager: INVClusterManager, willRenderClusterItem clusterItem: INVClusterItem, with markerOptions: INVMarkerOptions) {
        markerOptions.position = clusterItem.position
        markerOptions.iconScale = 0.8
        if let item = clusterItem as? INVNumberItem {
            markerOptions.iconImage = markerImages[item.number % markerImages.count]
            markerOptions.title = "마커 #\(item.number)"
        }
    }

    func clusterManager(_ clusterManager: INVClusterManager, didTap cluster: INVCluster, with markerOptions: INVMarkerOptions) -> Bool {
        let position = cluster.position
        onAlert?("클러스터 클릭", "위치 : \(position.formattedString)\n포함된 아이템 개수 : \(cluster.count)개")
        let cu = INVCameraUpdate(targetTo: position)
        cu.animation = .easeIn
        mapView?.moveCamera(cu)
        return true
    }

    func clusterManager(_ clusterManager: INVClusterManager, didTap clusterItem: INVClusterItem, with markerOptions: INVMarkerOptions) -> Bool {
        let position = clusterItem.position
        var msg = "위치 : \(position.formattedString)"
        if let item = clusterItem as? INVNumberItem {
            msg.append("\n번호 : \(item.number)")
        }
        onAlert?("아이템 클릭", msg)
        let cu = INVCameraUpdate(targetTo: position)
        cu.animation = .easeIn
        mapView?.moveCamera(cu)
        return true
    }
}

private final class MarkerClusteringStore {
    var mapRef: InaviMapView?
    var manager: INVClusterManager?
    var clusterDelegate = ClusterDelegate()
}

struct MarkerClusteringView: View {
    @State private var store = MarkerClusteringStore()
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false

    private let backgroundColors = [
        UIColor(hex: 0x0099cc),
        UIColor(hex: 0x669900),
        UIColor(hex: 0xff8800),
        UIColor(hex: 0xcc0000),
        UIColor(hex: 0x9933cc),
    ]
    private let criteria: [NSNumber] = [10, 50, 100, 200, 500]
    private let position = INVLatLng(lat: 37.40219, lng: 127.11077)

    var body: some View {
        InaviMapViewRepresentable(onMapViewReady: { mapView in
            store.mapRef = mapView
            let mgr = INVClusterManager(mapView: mapView)
            store.clusterDelegate.mapView = mapView
            store.clusterDelegate.onAlert = { title, msg in
                alertTitle = title
                alertMessage = msg
                showAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showAlert = false
                }
            }
            mgr.delegate = store.clusterDelegate
            mgr.clusterIconGenerator = INVDefaultClusterIconGenerator(colors: backgroundColors, criteria: criteria)
            mapView.moveCamera(INVCameraUpdate(zoomTo: 13.0))
            mapView.showZoomControl = true
            for index in 1...1000 {
                let item = INVNumberItem(position: randomPosition(), number: index)
                mgr.add(item)
            }
            store.manager = mgr
        })
        .edgesIgnoringSafeArea(.bottom)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .navigationTitle("Marker Clustering")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func randomPosition() -> INVLatLng {
        func r() -> Double { Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0 }
        let extent = 0.02
        return INVLatLng(lat: position.lat + extent * r(),
                         lng: position.lng + extent * r())
    }
}

extension UIColor {
    fileprivate convenience init(hex: Int) {
        self.init(red: CGFloat((hex & 0xff0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0x00ff00) >> 8) / 255.0,
                  blue: CGFloat((hex & 0x0000ff)) / 255.0,
                  alpha: 1.0)
    }
}
