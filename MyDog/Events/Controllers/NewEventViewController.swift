//
//  NewEventViewController.swift
//  MyDog
//
//  Created by Рома on 02.07.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {

    var dogsEvent = DogsEvent(title: "", date: "", comment: "")
    
    @IBOutlet weak var newEventTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


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
