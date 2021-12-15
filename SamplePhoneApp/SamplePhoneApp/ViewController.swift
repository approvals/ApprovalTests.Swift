import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var rollOutputsView: RollOutputsView!

    @IBAction private func roll() {
        rollOutputsView.setRoll(4)
    }
}
