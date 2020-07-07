//
//  RemainderInfoViewController.swift
//  MyDog
//
//  Created by Рома on 06.07.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit


class RemainderInfoViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let defaults = UserDefaults.standard
    var remaindersList = [Remainder]()
    var remainder = Remainder(name: "", date: "", time: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeTextField.inputView = timePicker
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGesture)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveTapped))
    }
    @objc func dateChanged() {
        getDataFromPicker()
    }
    
    @objc func timeChanged() {
        getTimeFromPicker()
    }
    
    func getDataFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        remainder.date = dateTextField.text ?? ""
    }
    
    func getTimeFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeTextField.text = formatter.string(from: timePicker.date)
        remainder.time = timeTextField.text ?? ""
    }
    
    @objc func tapGestureDone() {
        view.endEditing(true)
    }
    
    func saveToUserDefault() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: remaindersList)
        defaults.set(encodedData, forKey: "RemaindersList")
    }
    
    func loadFromUserDefault() {
        if let decoded = defaults.object(forKey: "RemaindersList") as? NSData {
            let array = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Remainder]
            remaindersList = array
        }
    }
    
    @objc func saveTapped() {
        loadFromUserDefault()
        remaindersList.append(remainder)
        saveToUserDefault()
        self.navigationController?.popViewController(animated: true)
    }
}

extension RemainderInfoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        remainder.name = titleTextField.text ?? ""
    }
}
