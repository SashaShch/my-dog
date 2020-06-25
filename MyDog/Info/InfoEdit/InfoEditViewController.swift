//
//  InfoEditViewController.swift
//  MyDog
//
//  Created by Рома on 25.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

protocol InfoEditViewControllerDelegate: AnyObject {
    func infoEditViewControllerDidGetUserInfo(_ infoUser: [String: String])
}

class InfoEditViewController: UIViewController {
    
    weak var delegate: InfoEditViewControllerDelegate?
    var info = Info()
    let defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        //let defaults = UserDefaults.standard
        defaults.set(info.userInfo, forKey: "SavedDict")
        if let savedArray = defaults.object(forKey: "SavedDict") as? [String: String] {
            delegate?.infoEditViewControllerDidGetUserInfo(savedArray)
            print(savedArray)
        }
    
        //delegate?.infoEditViewControllerDidGetUserInfo(info.userInfo)
        self.dismiss(animated: true, completion: nil)
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
        if let savedArray = defaults.object(forKey: "SavedDict") as? [String: String] {
            if savedArray[cell.infoTextField.placeholder ?? ""] != "" {
                cell.infoTextField.text = savedArray[cell.infoTextField.placeholder ?? ""]
            }
            
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

extension InfoEditViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        info.userInfo[textField.placeholder ?? ""] = textField.text
        //defaults.set(info.userInfo, forKey: "SavedDict")
    }
}
