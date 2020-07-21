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
    let image = UIImage(named: "infoCheckMark")
    let image2 = UIImage(named: "infoPencil")
    
    let datePicker = UIDatePicker()
    
    var onDateChange: ((String) -> Void)?
    var onAgeChange: ((String) -> Void)?
    
    
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
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
    }
    
    @objc func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
        self.onDateChange?(formatter.string(from: datePicker.date))
        let dataBirth = Calendar.current.date(from: DateComponents(year: componenets.year, month: componenets.month, day: componenets.day))!
        let dogAge = String(dataBirth.age)
        self.onAgeChange?(dogAge)
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor(red: 171/255, green: 201/255, blue: 197/255, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.textAlignment = .center
        header.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
        cell.layer.borderColor = UIColor(red: 171/255, green: 201/255, blue: 197/255, alpha: 1).cgColor
        cell.clipsToBounds = true
        
        cell.userInfoTextField.layer.cornerRadius = 8
        
        if cell.userInfoTextField.placeholder == "Дата рождения" {
            cell.userInfoTextField.inputView = datePicker
            datePicker.datePickerMode = .date
            self.onDateChange = { value in
                cell.userInfoTextField.text = value
            }
        }
        
       if cell.userInfoTextField.placeholder == "Возраст" {
            self.onAgeChange = { value in
                cell.userInfoTextField.text = value
                self.info.userInfo["Возраст"] = value
            }
        }
        
        return cell
    }
}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

extension InfoViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        info.userInfo[textField.placeholder ?? ""] = textField.text
    }
}

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}

