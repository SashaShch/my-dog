//
//  InfoViewController.swift
//  MyDog
//
//  Created by Рома on 24.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var info = Info()
    var isEdidting = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func editInfoButtonPressed(_ sender: Any) {
       if isEditing == false {
            
        }
    }
    
}



extension InfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return info.headerInfo.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return info.headerInfo[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return info.personInfo.count
        default:
            return info.careInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfoTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "info cell", for: indexPath) as! InfoTableViewCell
        if indexPath.section == 0 {
            cell.infoLabel.text = info.personInfo[indexPath.item]
        } else {
            cell.infoLabel.text = info.careInfo[indexPath.item]
        }
        
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor(red: 217/255, green: 215/255, blue: 250/255, alpha: 1).cgColor
        cell.clipsToBounds = true
        
        return cell
    }
}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
