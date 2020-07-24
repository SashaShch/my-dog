//
//  ViewController.swift
//  MyDog
//
//  Created by Рома on 15.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var dog = Dog(name: "")
    
    @IBOutlet weak var dogNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accessoryView = UIView()
        accessoryView.backgroundColor = UIColor(red: 161/255, green: 184/255, blue: 198/255, alpha: 1)
        accessoryView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 32)
        
        let doneButton = UIButton()
        doneButton.addTarget(self, action: #selector(accessoryDonePressed), for: .touchUpInside)
        doneButton.setTitle("Готово", for: .normal)
        doneButton.frame = CGRect(x: 0, y: 0, width: 100, height: 32)
        
        accessoryView.addSubview(doneButton)
        dogNameTextField.inputAccessoryView = accessoryView
    }
    
    @objc func accessoryDonePressed() {
        dogNameTextField.endEditing(true)
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as! AddPhotoViewController
        dog.name = dogNameTextField.text ?? ""
        vc.dog = dog
        defaults.set(dog.name, forKey: "DogName")
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension FirstViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        dog.name = dogNameTextField.text ?? ""
    }
}
