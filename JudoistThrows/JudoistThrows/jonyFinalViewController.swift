//
//  FinalViewController.swift
//  JudoistThrows
//
//  Created by Nazar on 12.09.2019.
//  Copyright © 2019 Nazar. All rights reserved.
//


import UIKit

class FinalViewController: UIViewController {
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var buttonYes: UIButton!
    var isSucceed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonNoTap(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    @IBAction func buttonYesTap(_ sender: Any) {
        // TODO: - increment day
        isSucceed = true
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let gestures = self.view.gestureRecognizers {
            for gesture in gestures {
                self.view.removeGestureRecognizer(gesture)
            }
        }
    }

    


}
