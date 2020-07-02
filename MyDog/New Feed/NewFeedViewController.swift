//
//  NewFeedViewController.swift
//  MyDog
//
//  Created by Рома on 22.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit
import CoreData

class NewFeedViewController: UIViewController {
    
    var events = [Event]()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "New Feed")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Event")
        
        do {
            let eventList = try context.fetch(request) as! [Event]
            events = eventList
        } catch {
            print("Error")
        }
    }
    
}


extension NewFeedViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "New Feed"
        var cell: NewFeedTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! NewFeedTableViewCell
        
        let event = events[indexPath.item]
        cell.eventTypeLabel.text = event.value(forKey: "type") as? String
        cell.dateCommentLabel.text = "\(event.value(forKey: "date") as! String) \(event.value(forKey: "comment") as! String)"
        
        let data = event.value(forKey: "photo") as! Data
        let image = UIImage(data: data)
        cell.eventPhotoImage.image = image
        
        if let dogName = defaults.object(forKey: "DogName") as? String {
            cell.dogName.text = dogName
        }
        
        if let data = defaults.object(forKey: "DogPhoto") as? Data {
            let dogPhoto = UIImage(data: data)
            cell.dogPhotoImage.image = dogPhoto
        }
        return cell
    }
}

extension NewFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
