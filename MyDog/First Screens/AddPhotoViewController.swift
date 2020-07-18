//
//  AddPhotoViewController.swift
//  MyDog
//
//  Created by Рома on 18.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    var dog = Dog(name: "")
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var addPhotoLabel: UILabel!
    @IBOutlet weak var dogPhotoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoLabel.text = dog.name
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "AddPhoto")))
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as? TabBarViewController {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dogPhotoImage.image = image
            if let data = dogPhotoImage.image?.pngData() {
                defaults.set(data, forKey: "DogPhoto")
            }

            dismiss(animated:true, completion: nil)
        }
    }
    
}
