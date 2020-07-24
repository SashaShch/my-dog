//
//  RemainderInfoViewController.swift
//  MyDog
//
//  Created by Рома on 06.07.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit
import UserNotifications

class RemainderInfoViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    
    var center: UNUserNotificationCenter {
        UNUserNotificationCenter.current()
    }
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    let defaults = UserDefaults.standard
    var remaindersList = RemainderStore()
    var remainder = Remainder(name: "", date: "", time: "")
    var day: Int?
    var month: Int?
    var year: Int?
    var hour: Int?
    var minute: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.layer.cornerRadius = 20
        titleTextField.layer.borderWidth = 1
        titleTextField.clipsToBounds = true
        titleTextField.layer.borderColor = UIColor(red: 201/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        
        timeTextField.inputView = timePicker
        timePicker.datePickerMode = .time
        timePicker.minimumDate = Date()
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        timeTextField.layer.cornerRadius = 20
        timeTextField.layer.borderWidth = 1
        timeTextField.clipsToBounds = true
        timeTextField.layer.borderColor = UIColor(red: 201/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        dateTextField.layer.cornerRadius = 20
        dateTextField.layer.borderWidth = 1
        dateTextField.clipsToBounds = true
        dateTextField.layer.borderColor = UIColor(red: 201/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGesture)
        

        
        if remainder.name.count > 0 {
            titleTextField.text = remainder.name
        }
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
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            self.day = day
            self.month = month
            self.year = year
        }
        dateTextField.text = formatter.string(from: datePicker.date)
        remainder.date = dateTextField.text ?? ""
    }
    
    func getTimeFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let componenets = Calendar.current.dateComponents([ .hour, .minute], from: timePicker.date)
        if let hour = componenets.hour, let minute = componenets.minute {
            self.hour = hour
            self.minute = minute
        }
        timeTextField.text = formatter.string(from: timePicker.date)
        remainder.time = timeTextField.text ?? ""
    }
    
    @objc func tapGestureDone() {
        view.endEditing(true)
    }
    
    

    
    func trigger() {
        let content = UNMutableNotificationContent()
        content.title = "My Dog"
        content.body = titleTextField.text ?? ""
        content.sound = .default
        content.badge = 1
        
        var monthly = DateComponents()
        monthly.hour = hour
        monthly.day = day
        monthly.month = month
        monthly.minute = minute
        monthly.year = year
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: monthly, repeats: false)
        trigger.nextTriggerDate()
        
        
        let request = UNNotificationRequest(identifier: titleTextField.text!, content: content, trigger: trigger)
        
        center.add(request) { error in
            if error != nil {
                print(error!)
            }
        }
    }
    
    func setReminderName(name: String) {
        remainder.name = name
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if titleTextField.text?.isEmpty == false && dateTextField.text?.isEmpty == false && timeTextField.text?.isEmpty == false {
            
            remaindersList.addItem(item: remainder)
            self.dismiss(animated: true, completion: nil)
            
            trigger()
        }
    }
}

extension RemainderInfoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        remainder.name = titleTextField.text ?? ""
    }
}

