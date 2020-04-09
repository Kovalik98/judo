//
//  ViewController.swift
//  JudoistThrows
//
//  Created by Nazar on 12.09.2019.
//  Copyright © 2019 Nazar. All rights reserved.
//



import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var labelCurrentDay: UILabel!
    @IBOutlet weak var imageViewCup: UIImageView!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var currentPosition: UIImageView!
    
    var currentDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.5725490196, blue: 0.537254902, alpha: 1)
        
        progressView.transform = progressView.transform.scaledBy(x: 1, y: self.view.frame.height - currentPosition.frame.origin.y - currentPosition.frame.height)
        
        startButton.frame.size = CGSize(width: startButton.frame.width, height: startButton.frame.width)
        historyButton.imageView?.contentMode = .scaleAspectFit
        currentDay = UserDefaults.standard.integer(forKey: "current-day")
        
        //Set progress
        if(currentDay > 0){
            progressView.progress = Float(currentDay)/29.0
            if(currentDay > 1 && currentDay < 29){
                let step = self.view.frame.width/29
                currentPosition.frame.origin = CGPoint(x: step * CGFloat(currentDay - 1), y: currentPosition.frame.origin.y)
            }else if (currentDay == 29){
                currentPosition.isHidden = true
                imageViewCup.frame.origin = CGPoint(x: self.view.frame.width - imageViewCup.frame.width, y: currentPosition.frame.origin.y)
            }
        }else{
            self.progressView.progress = Float(1/29.0)
        }
        
        let runCnt = UserDefaults.standard.integer(forKey: "run-count") + 1
        UserDefaults.standard.set(runCnt, forKey: "run-count")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCurrentDay()
    }
    
    @IBAction func showLastWorkout(_ sender: Any) {
        if let d = UserDefaults.standard.value(forKey: "last-workout") as? Date {
            let f = DateFormatter()
            f.timeStyle = .none
            f.dateStyle = .medium
            let alert = UIAlertController(title: "Последняя тренировка была:", message: f.string(from: d), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentDay == 30 {
            DispatchQueue.main.async {
    
            }
        }

    }
}

extension ViewController {
    @IBAction func buttonStartTap(_ sender: Any) {
        

        let t = storyboard?.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
        t.timeSec = WorkoutData.days[currentDay]
        self.navigationController?.pushViewController(t, animated: true)
    }
    
    @IBAction func unwindToMain(_ segue: UIStoryboardSegue) {
        if let f = segue.source as? FinalViewController {
            if f.isSucceed {
                incCurrentDay()
            }
            
            UserDefaults.standard.set(Date(), forKey: "last-workout")
        }
    }
}

extension ViewController {
    func incCurrentDay() {
        currentDay += 1
        UserDefaults.standard.set(currentDay, forKey: "current-day")
        setCurrentDay()
    }
    
    func setCurrentDay() {
        let timeSec = WorkoutData.days[currentDay]
        labelCurrentDay.text = "ДЕНЬ:" + " \(currentDay + 1) (\(timeSec) " + "СЕК)"
    }
    func restartChallenge() {
        currentDay = 0
        UserDefaults.standard.set(nil, forKey: "last-workout")
        setCurrentDay()
    }
}
