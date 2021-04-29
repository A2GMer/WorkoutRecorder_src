//
//  AddListViewController.swift
//  WorkoutRecorder_src
//
//  Created by Tanaka Hiroto on 2021/04/17.
//

import UIKit

class AddListViewController: UIViewController {
    @IBOutlet weak var isGood: UISwitch!
    @IBOutlet weak var txt_dateTime: UITextField!
    @IBOutlet weak var txt_part: UITextField!
    @IBOutlet weak var txt_event_name: UITextField!
    @IBOutlet weak var txt_weight: UITextField!
    @IBOutlet weak var txt_rep: UITextField!
    @IBOutlet weak var txt_set: UITextField!
    var tappedCnt: Decimal = 0
    var dateTime: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 数字のみ許容
        self.txt_weight.keyboardType = UIKeyboardType.numberPad
        self.txt_rep.keyboardType = UIKeyboardType.numberPad
        self.txt_set.keyboardType = UIKeyboardType.numberPad
        // 現在の日時を取得し、表示
        dateTime = Date()
        txt_dateTime?.text = DateUtils.stringFromDate(date: dateTime)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let list = WorkoutHistory(context: context)
        tappedCnt += 1
        // DB格納データ取得
        list.no = NSDecimalNumber(decimal: tappedCnt)
        list.record_date = dateTime
        list.part = txt_part.text!
        list.event_name = txt_event_name.text!
        list.weight = Double(txt_weight.text!) ?? 0
        list.rep = Int32(txt_rep.text!) ?? 0
        list.set = Int32(txt_set.text!) ?? 0
        list.good = isGood.isOn
        // 保存
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
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
