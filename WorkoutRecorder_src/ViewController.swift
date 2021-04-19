//
//  ViewController.swift
//  WorkoutRecorder_src
//
//  Created by Tanaka Hiroto on 2021/04/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var workHisList : [WorkoutHistory] = []
    
    override func viewDidLoad() {
        // デバッグ用
        /// ==========ここから==========
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let list = WorkoutHistory(context: context)
        list.no = NSDecimalNumber(decimal: 1)
        list.record_date = Date()
        list.part = "胸"
        list.event_name = "sample"
        list.weight = 100
        list.rep = 10
        list.set = 3
        list.good = true
        /// ==========ここまで==========
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workHisList.count
    }
    
    // DBデータを表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let r = workHisList[indexPath.row]
        
        if r.good{
            // いいねの場合は、星マークを付与
            cell.textLabel?.text = "⭐️" + r.event_name!
        } else {
            cell.textLabel?.text = r.event_name!
        }
        return cell
    }
    
    // データ取得
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            workHisList = try context.fetch(WorkoutHistory.fetchRequest())
        }
        catch{
            // TODO: ログ出力？？
            print("読み込み失敗")
        }
    }
    
    // 削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete{
            let list = workHisList[indexPath.row]
            context.delete(list)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                workHisList = try context.fetch(WorkoutHistory.fetchRequest())
            }
            catch{
                // TODO: ログ出力？？
                print("読み込み失敗")
            }
        }
        tableView.reloadData()
    }
}

