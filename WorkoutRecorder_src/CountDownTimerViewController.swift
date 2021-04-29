//
//  CountDownTimerViewController.swift
//  WorkoutRecorder_src
//
//  Created by Tanaka Hiroto on 2021/04/29.
//

import UIKit

class CountDownTimerViewController: UIViewController {
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var btn_startstop: UIButton!
    @IBOutlet weak var dtpicker_timer: UIDatePicker!
    var timer = Timer()
    var secondsElapsed = 0
    var mode: watchMode = watchMode.stop
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_time.text = formatTimeLabelString(seconds: secondsElapsed)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startstopButtonTapped(_ sender: Any) {
        if mode == watchMode.stop {
            mode = watchMode.start
            btn_startstop.setTitle("STOP", for: .normal)
            secondsElapsed = Int(dtpicker_timer.countDownDuration)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [self]
                timer in secondsElapsed -= 1
                lbl_time.text = formatTimeLabelString(seconds: secondsElapsed)
            }
        } else if mode == watchMode.start {
            mode = watchMode.stop
            btn_startstop.setTitle("START", for: .normal)
            timer.invalidate()
            self.secondsElapsed = 0
            lbl_time.text = formatTimeLabelString(seconds: secondsElapsed)
        }
    }
    
    enum watchMode {
        case start
        case stop
    }
    
    func formatTimeLabelString(seconds: Int) -> String{
        let hour = NSString(format: "%02d", seconds / 3600)
        let min = NSString(format: "%02d", (seconds % 3600) / 60)
        let sec = NSString(format: "%02d", seconds % 60)
        return "\(hour):\(min):\(sec)"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
