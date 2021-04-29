//
//  ViewController.swift
//  WorkoutRecorder_src
//
//  Created by Tanaka Hiroto on 2021/04/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var workHisList: [WorkoutHistory] = []
    
    override func viewDidLoad() {
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
        
        // Date型をString型に変換
        let datetime = DateUtils.stringFromDate(date: r.record_date!)
        
        // 表示するデータをCSV形式にフォーマット
        let text = datetime + "," + r.part! + "," + r.event_name! + "," + String(r.weight) + "," + String(r.rep) + "," + String(r.set) + "," + String(r.good)
        
        
        if r.good{
            // いいねの場合は、星マークを付与
            cell.textLabel?.text = "⭐️" + text
        } else {
            cell.textLabel?.text = text
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

