//
//  Events.swift
//  MyDog
//
//  Created by Рома on 30.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class DogsEvent {
    var title: String
    let date: String
    let comment: String
    
    init(title: String, date: String, comment: String) {
        self.title = title
        self.date = date
        self.comment = comment
    }
}
