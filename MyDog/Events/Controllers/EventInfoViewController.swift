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
    
    var dogsEvent = DogsEvent(title: "", date: "", comment: "")
    var goToNewFeed: (() -> Void)?

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLable.text = dogsEvent.title
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        let dateString = dateFormatter.string(from: date as Date)
        dateLabel.text = "\(dateString)"
        
        commentsTextView.text = "Добавить комментарий..."
        commentsTextView.textColor = UIColor.lightGray

    }
    
    func createEvent(type: String, time: String, comment: String, photo: UIImage) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            if let eventEntity = NSEntityDescription.entity(forEntityName: "Event", in: context){
                
                let event = NSManagedObject(entity: eventEntity, insertInto: context) as! Event
                
                let data = photo.pngData()
                
                event.type = type
                event.date = time
                event.comment = comment
                
                event.photo = data
                
                try? context.save()
            }
        }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        createEvent(type: titleLable.text ?? "", time: dateLabel.text ?? "", comment: commentsTextView.text ?? "", photo: ((photoImage.image ?? UIImage(named: "emptyPhoto"))!))
        
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
