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
    }


    @IBAction func nextButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as! AddPhotoViewController
        dog.name = dogNameTextField.text ?? ""
        vc.dog = dog
        defaults.set(dog.name, forKey: "DogName")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FirstViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        dog.name = dogNameTextField.text ?? ""
    }
}
