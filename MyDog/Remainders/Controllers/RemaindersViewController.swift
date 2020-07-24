//
//  RemaindersViewController.swift
//  MyDog
//
//  Created by Рома on 03.07.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit


class RemaindersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard
    var remaindersList = RemainderStore()
    var isPassed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RemainderTableViewCell", bundle: nil), forCellReuseIdentifier: "New Remainder")
        
        let imgView =  UIImageView(frame: self.tableView.frame)
        let img = UIImage(named: "backWithBones")
        imgView.image = img
        imgView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height)
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        self.tableView.addSubview(imgView)
        self.tableView.sendSubviewToBack(imgView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        remaindersList.loadFromUserDefault()
        tableView.reloadData()
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "RemaindersInfo") as RemainderInfoViewController? {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension RemaindersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return remaindersList.dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "New Remainder"
        var cell: RemainderTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! RemainderTableViewCell
        
        cell.nameLabel.text = remaindersList.dataItems[indexPath.item].name
        cell.dateLabel.text = remaindersList.dataItems[indexPath.item].date
        cell.timeLabel.text = remaindersList.dataItems[indexPath.item].time
        
        
        let input = remaindersList.dataItems[indexPath.item].date + " " + remaindersList.dataItems[indexPath.item].time
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        let currentDate = Date()
        
        if let date = formatter.date(from: input) {
            
            if currentDate >= date {
                cell.backgroundColor = UIColor(red: 188/255, green: 211/255, blue: 208/255, alpha: 1)
                cell.nameLabel.textColor = .white
                cell.dateLabel.textColor = .white
                cell.timeLabel.textColor = .white
                
            } else {
                cell.backgroundColor = UIColor(red: 213/255, green: 226/255, blue: 224/255, alpha: 1)
                cell.isUserInteractionEnabled = false
                cell.nameLabel.textColor = UIColor(red: 95/255, green: 110/255, blue: 118/255, alpha: 1)
                cell.dateLabel.textColor = UIColor(red: 95/255, green: 110/255, blue: 118/255, alpha: 1)
                cell.timeLabel.textColor = UIColor(red: 95/255, green: 110/255, blue: 118/255, alpha: 1)
            }
            
        }
        return cell
    }
}

extension RemaindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Выполнено", style: .default) { (action:UIAlertAction) in
            self.remaindersList.removeItem(indexPath: indexPath)
            tableView.reloadData()
        }
        let action2 = UIAlertAction(title: "Повторить", style: .default) { (action:UIAlertAction) in
            if let vc = self.storyboard?.instantiateViewController(identifier: "RemaindersInfo") as RemainderInfoViewController? {
                vc.setReminderName(name: self.remaindersList.dataItems[indexPath.item].name)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            self.remaindersList.removeItem(indexPath: indexPath)
            tableView.reloadData()
        }
        
        alertController.addAction(action)
        alertController.addAction(action2)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension Date {
    
    func isBefore(_ date1: Date = Date(), _ date2: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date1)
        let selfComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date2)
        
        return calendar.date(from: selfComponents)! < calendar.date(from: dateComponents)!
    }
}
