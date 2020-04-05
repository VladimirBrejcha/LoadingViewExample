//  Copyright © 2020 VladimirBrejcha. All rights reserved.

import UIKit
import LoadingView

final class ViewController: UIViewController {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var loadingView: LoadingView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
        loadingView.repeatTouchUpHandler = { _ in
            self.segmentedControl.selectedSegmentIndex = 1
            self.loadingView.state = .loading
        }
    }

    @IBAction func stateValueChanged(_ sender: UISegmentedControl) {
        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.contentView.alpha = sender.selectedSegmentIndex == 0
                ? 1
                : 0
        }.startAnimation()
        
        switch sender.selectedSegmentIndex {
        case 0: loadingView.state = .hidden
        case 1: loadingView.state = .loading
        case 2: loadingView.state = .info(message: "An information message")
        case 3: loadingView.state = .error(message: "An error message")
        default: break
        }
    }
}
