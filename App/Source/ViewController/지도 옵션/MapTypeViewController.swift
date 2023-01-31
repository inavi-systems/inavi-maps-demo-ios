import UIKit
import iNaviMaps

class MapTypeViewController: MapViewController {
    
    @IBOutlet weak var selectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectButton?.setTitle("일반 지도", for: .normal)
        
    }
    
    @IBAction func respondMapType(_ sender: UIButton) {
        let alertController = UIAlertController(title: "지도 타입", message: nil, preferredStyle: .actionSheet)
        var styleItems: Array<(title: String, mapType: INVMapType)> = [];
        styleItems.append((title: "일반 지도", mapType: .normal))
        styleItems.append((title: "항공 지도", mapType: .satellite))
        styleItems.append((title: "하이브리드 지도", mapType: .hybrid))
        
        styleItems.forEach { item in
            alertController.addAction(UIAlertAction(title: item.title, style: .default, handler: { alert in
                self.selectButton?.setTitle(item.title as String, for: .normal)
                self.mapView.mapType = item.mapType
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "닫기", style: .cancel))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
