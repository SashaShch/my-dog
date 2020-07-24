//
//  EventInfoViewController.swift
//  MyDog
//
//  Created by Рома on 29.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit
import CoreData

class EventInfoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    var dogsEvent = DogsEvent(title: "", date: "", comment: "", image: "")
    var goToNewFeed: (() -> Void)?
    let commentConstraint = 270

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var commentBottomConstraint: NSLayoutConstraint!
    
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
        commentsTextView.inputAccessoryView = accessoryView
        
        commentsTextView.layer.cornerRadius = 20
        commentsTextView.layer.borderWidth = 1
        commentsTextView.layer.borderColor = UIColor(red: 201/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        
        titleLable.text = dogsEvent.title
        eventImage.image = UIImage(named: dogsEvent.image)
        
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
        addPhotoButton.clipsToBounds = true
        addPhotoButton.layer.borderWidth = 1
        addPhotoButton.layer.borderColor = UIColor(red: 201/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        
        photoImage.layer.cornerRadius = addPhotoButton.frame.width / 2
        photoImage.clipsToBounds = true
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        let dateString = dateFormatter.string(from: date as Date)
        dateLabel.text = dateString
        
        commentsTextView.text = "Добавить комментарий..."
        commentsTextView.textColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

    }
    
    func createEvent(type: String, time: String, comment: String, photo: UIImage?) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            if let eventEntity = NSEntityDescription.entity(forEntityName: "Event", in: context){
                
                let event = NSManagedObject(entity: eventEntity, insertInto: context) as! Event
                
                event.type = type
                event.date = time
                event.comment = comment
                
                event.photo = photo?.pngData()
                
                try? context.save()
            }
        }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                commentBottomConstraint.constant = keyboardFrame.height
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        commentBottomConstraint.constant = CGFloat(commentConstraint)
        
    }
    
    @objc func accessoryDonePressed() {
        commentsTextView.endEditing(true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if commentsTextView.text == "Добавить комментарий..." {
            commentsTextView.text = ""
        }
        
        createEvent(type: titleLable.text ?? "", time: dateLabel.text ?? "", comment: commentsTextView.text ?? "", photo: photoImage.image)
        
        goToNewFeed?()
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
            addPhotoButton.setImage(image, for: .normal)
            photoImage.image = image
            dismiss(animated:true, completion: nil)
        }
    }
}


extension EventInfoViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentsTextView.textColor == UIColor.lightGray {
            commentsTextView.text = nil
            commentsTextView.textColor = UIColor.black
        }
    }
}
