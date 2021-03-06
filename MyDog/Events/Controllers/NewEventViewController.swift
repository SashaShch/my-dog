//
//  NewEventViewController.swift
//  MyDog
//
//  Created by Рома on 02.07.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {

    var dogsEvent = DogsEvent(title: "", date: "", comment: "", image: "eventCustom")
    
    @IBOutlet weak var newEventTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGesture)

        newEventTextField.layer.cornerRadius = 20
        newEventTextField.layer.borderWidth = 1
        newEventTextField.layer.borderColor = UIColor(red: 201/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        
        newEventTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: newEventTextField.frame.height))
        newEventTextField.leftViewMode = .always

    }
    
    @objc func tapGestureDone() {
        view.endEditing(true)
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        view.endEditing(true)
        if let vc = self.storyboard?.instantiateViewController(identifier: "EventInfoViewController") as EventInfoViewController? {
            vc.dogsEvent = self.dogsEvent
            vc.goToNewFeed = {
                vc.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {})
                if let tabBarController = self.presentingViewController as? UITabBarController {
                    tabBarController.selectedIndex = 0
                }
            }
        present(vc, animated: true, completion: nil)
        }
    }
}


extension NewEventViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        dogsEvent.title = textField.text ?? ""
    }
}
