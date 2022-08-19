import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.92, green: 0.16, blue: 0.19, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        if !clearsSelectionOnViewWillAppear {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
