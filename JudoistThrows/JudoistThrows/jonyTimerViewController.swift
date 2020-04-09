//
//  TimerViewController.swift
//  JudoistThrows
//
//  Created by Nazar on 12.09.2019.
//  Copyright © 2019 Nazar. All rights reserved.
//



import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    
    private var prepareTimeSec = 5
    var timeSec: Int = 30
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var labelTimeSec: UILabel!
    @IBOutlet weak var viewProgress: KDCircularProgress!
    @IBOutlet weak var exerciseImage: UIImageView!
    
    private var progressMax: Int = 0
    private var timer: Timer!
    
    var prepareExerciseList = ["Подготовся к броске через спину...", "Подготовся к броскам через бедро...", "Подготовся к заднем \n броске..."]
    var startExerciseList = ["Делай бросок!", "Делай бросок!", "Делай бросок!"]
    var currentExercise = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTimeSec.font = UIFont.monospacedDigitSystemFont(ofSize: 82, weight: .light)
        labelTimeSec.text = String(prepareTimeSec)
        
        // New
        // Random Exercise
        currentExercise = Int.random(in: 0 ..< 3)
        exerciseImage.image = UIImage(named: "\(currentExercise)")
        
        hintLabel.text = prepareExerciseList[currentExercise]
        viewProgress.progressColors[0] = #colorLiteral(red: 0.4, green: 0.6549019608, blue: 0.7647058824, alpha: 1)
        progressMax = prepareTimeSec
        viewProgress.angle = 360.0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        if let gestures = self.view.gestureRecognizers {
            for gesture in gestures {
                self.view.removeGestureRecognizer(gesture)
            }
        }
    }
    
    @objc func onTimer(sender: Any?) {
        if prepareTimeSec >= 0 {
            prepareTimeSec -= 1
            labelTimeSec.text = String(prepareTimeSec+1)
            if prepareTimeSec < 0 {
                AudioServicesPlayAlertSound(SystemSoundID(1313))
                progressMax = timeSec
                viewProgress.animate(toAngle: 360.0, duration: 0.0, completion: nil)
                hintLabel.text = startExerciseList[currentExercise]
                labelTimeSec.text = String(timeSec)
            } else {
                let angle: CGFloat = CGFloat((360 * prepareTimeSec) / progressMax)
                viewProgress.animate(toAngle: Double(angle), duration: 1, completion: nil)
            }
        } else {
            labelTimeSec.text = String(timeSec)
            if timeSec <= 0 {
                AudioServicesPlayAlertSound(SystemSoundID(1313))
                timer.invalidate()
                // TODO: - show yes-no successed view
                // dismiss(animated: true, completion: nil)
                let f = storyboard?.instantiateViewController(withIdentifier: "FinalViewController")
                self.navigationController?.pushViewController(f!, animated: true)
                return
            } else {
                let angle: CGFloat = CGFloat((360 * (timeSec-1)) / progressMax)
                viewProgress.animate(toAngle: Double(angle), duration: 1.0, completion: nil)
                timeSec -= 1
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        UIApplication.shared.isIdleTimerDisabled = false
    }

    @IBAction func backTap(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
