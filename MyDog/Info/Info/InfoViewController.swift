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
    let defaults = UserDefaults.standard
    var isEditingInfo = false
    let image = UIImage(systemName: "checkmark")
    let image2 = UIImage(systemName: "pencil")
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveEditButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        
        saveEditButton.layer.contents = image2?.cgImage
        
        if let savedArray = defaults.object(forKey: "SavedDict") as? [String: String] {
            info.userInfo = savedArray
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    @IBAction func editInfoButtonPressed(_ sender: Any) {
        view.endEditing(true)
        defaults.set(info.userInfo, forKey: "SavedDict")
        isEditingInfo = !isEditingInfo
        
        if isEditingInfo {
            saveEditButton.layer.contents = image?.cgImage
        } else {
            saveEditButton.layer.contents = image2?.cgImage
        }
        
        tableView.reloadData()
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
            cell.userInfoTextField.placeholder = info.personInfo[indexPath.item]
        } else {
            cell.infoLabel.text = info.careInfo[indexPath.item]
            cell.userInfoTextField.placeholder = info.careInfo[indexPath.item]
        }
        
        if let savedArray = defaults.object(forKey: "SavedDict") as? [String: String] {
            cell.userInfoTextField.text = savedArray[cell.infoLabel.text ?? ""]
        }
        
       
        cell.userInfoTextField.isEnabled = isEditingInfo
        
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
        return 80
    }
}

extension InfoViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        info.userInfo[textField.placeholder ?? ""] = textField.text
    }
}
