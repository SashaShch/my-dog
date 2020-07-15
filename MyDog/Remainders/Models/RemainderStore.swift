//
//  RemainderStore.swift
//  MyDog
//
//  Created by Рома on 13.07.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import Foundation

class RemainderStore {
    
    let defaults = UserDefaults.standard
    
    var dataItems = [Remainder]()
    
    func saveToUserDefault() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: dataItems)
        defaults.set(encodedData, forKey: "RemaindersList")
    }
    
    func loadFromUserDefault() {
        if let decoded = defaults.object(forKey: "RemaindersList") as? NSData {
            let array = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Remainder]
            dataItems = array
        }
    }
    
    func addItem(item: Remainder) {
        loadFromUserDefault()
        dataItems.append(item)
        saveToUserDefault()
    }
    
    func removeItem(indexPath: IndexPath) {
        dataItems.remove(at: indexPath.item)
        saveToUserDefault()
    }
    
}
