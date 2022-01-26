import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var maxInputTextField: UITextField!
    @IBOutlet private(set) var rollOutputsView: RollOutputsView!

    @IBAction func roll() {
        rollOutputsView.setRoll(getRandomNumber(max: getMax()))
    }

    private func getMax() -> Int {
        let defaultDie = 6
        return Int(maxInputTextField.text!) ?? defaultDie
    }

    private func getRandomNumber(max: Int) -> Int {
        4
//        Int.random(in: 1...max)
    }
}
