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
    var remaindersList = [Remainder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RemainderTableViewCell", bundle: nil), forCellReuseIdentifier: "New Remainder")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let decoded = defaults.object(forKey: "RemaindersList") as? NSData {
            let array = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Remainder]
            remaindersList = array
        }
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
        
        return remaindersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "New Remainder"
        var cell: RemainderTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! RemainderTableViewCell
        
        cell.nameLabel.text = remaindersList[indexPath.item].name
        cell.dateLabel.text = remaindersList[indexPath.item].date
        cell.timeLabel.text = remaindersList[indexPath.item].time
        
        return cell
    }
    
}

extension RemaindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

