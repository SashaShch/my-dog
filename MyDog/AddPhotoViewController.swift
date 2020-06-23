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

    @IBOutlet weak var addPhotoLabel: UILabel!
    @IBOutlet weak var dogPhotoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoLabel.text = dog.name
        
        let rightButtonItem = UIBarButtonItem.init(
              title: "Сохранить",
              style: .done,
              target: self,
              action: #selector(rightButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as? TabBarViewController {
            self.present(viewController, animated: true, completion: nil)
        }
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
    
    func imagePickerController(_ picker: UIImagePickerController,
                                  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               dogPhotoImage.image = image
               dismiss(animated:true, completion: nil)
           }
       }
    
}
