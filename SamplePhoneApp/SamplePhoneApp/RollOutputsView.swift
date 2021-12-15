import UIKit

class RollOutputsView: UIView {
    @IBOutlet var rollResultLabel: UILabel!

    func setRoll(_ value: Int) {
        rollResultLabel.text = "\(value)"
    }
}
