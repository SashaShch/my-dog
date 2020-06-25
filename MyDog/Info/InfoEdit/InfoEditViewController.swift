//
//  InfoEditViewController.swift
//  MyDog
//
//  Created by Рома on 25.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class InfoEditViewController: UIViewController {
    
     var info = Info()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

extension InfoEditViewController: UITableViewDataSource {
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
        let cell: InfoEditTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "info edit cell", for: indexPath) as! InfoEditTableViewCell
        if indexPath.section == 0 {
            cell.infoTextField.placeholder = info.personInfo[indexPath.item]
        } else {
            cell.infoTextField.placeholder = info.careInfo[indexPath.item]
        }
        
        return cell
    }
}

extension InfoEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

