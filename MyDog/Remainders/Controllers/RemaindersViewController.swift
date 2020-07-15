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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RemainderTableViewCell", bundle: nil), forCellReuseIdentifier: "New Remainder")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        remaindersList.loadFromUserDefault()
        tableView.reloadData()
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "RemaindersInfo") as RemainderInfoViewController? {
            self.navigationController?.pushViewController(vc, animated: true)
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
        
        return cell
    }
    
}

extension RemaindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Выполнено", style: .default) { (action:UIAlertAction) in
            self.remaindersList.removeItem(indexPath: indexPath)
            tableView.reloadData()
        }
        let action2 = UIAlertAction(title: "Повторить", style: .default) { (action:UIAlertAction) in
            //self.afterAlertLabel.isHidden = false
        }
        
        alertController.addAction(action)
        alertController.addAction(action2)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

