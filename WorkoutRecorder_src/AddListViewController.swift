//
//  AddListViewController.swift
//  WorkoutRecorder_src
//
//  Created by Tanaka Hiroto on 2021/04/17.
//

import UIKit

class AddListViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isGood: UISwitch!
    var tappedCnt: Decimal = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let list = WorkoutHistory(context: context)
        tappedCnt += 1
        // DB格納データ取得
        list.no = NSDecimalNumber(decimal: tappedCnt)
        list.record_date = Date()
        list.part = "胸"
        list.event_name = textField.text!
        list.weight = 100
        list.rep = 10
        list.set = 3
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
