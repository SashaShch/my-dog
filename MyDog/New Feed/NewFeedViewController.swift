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

    var events = [(String,String,String,Data)]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "New Feed")
    }
    

}


extension NewFeedViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Event")
        
        let eventList = try? context.fetch(request)
        
        return eventList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "New Feed"
        var cell: NewFeedTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! NewFeedTableViewCell
        

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
        
                let request = NSFetchRequest<NSManagedObject>(entityName: "Event")
        
                do {
                    let eventList = try context.fetch(request)
                    
                    let event = eventList[indexPath.item]
                    cell.eventTypeLabel.text = event.value(forKey: "type") as? String
                    cell.dateCommentLabel.text = "\(event.value(forKey: "date") as! String) \(event.value(forKey: "comment") as! String)"
                    
                    let data = event.value(forKey: "photo") as! Data
                    let image = UIImage(data: data)
                    cell.eventPhotoImage.image = image
                } catch {
                    print("Error")
                }
        
        return cell
    }
}

extension NewFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 300
       }
}
