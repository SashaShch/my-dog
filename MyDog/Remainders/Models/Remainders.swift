//
//  Remainders.swift
//  MyDog
//
//  Created by Рома on 06.07.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import Foundation

class Remainder: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(time, forKey: "time")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! String
        let time = aDecoder.decodeObject(forKey: "time") as! String
        self.init(name: name, date: date, time: time)
    }
    
    var name: String
    var date: String
    var time: String
    
    init(name: String, date: String, time: String) {
        self.name = name
        self.date  = date
        self.time = time
    }
}
