//CamelGame

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var Popup: UIView!
    var mainVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //popup
        Popup.layer.cornerRadius = 10
        Popup.layer.masksToBounds = true
    }
    
    @IBAction func yesRestart(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func noRestart(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
