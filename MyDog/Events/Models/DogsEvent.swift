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
    let image: String
    
    init(title: String, date: String, comment: String, image: String) {
        self.title = title
        self.date = date
        self.comment = comment
        self.image = image
    }
}
