//
//  EventsModel.swift
//  MyDog
//
//  Created by Рома on 29.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import Foundation

struct Events {
    
    
    let events = ["Еда",
                  "Осмотр",
                  "Прогулка",
                  "Контроль стула",
                  "Грунинг",
                  "Купание",
                  "Тренировка",
                  "Прививки",
                  "Паразитарная обработка",
                  "Лечение"]
    
    func count() -> Int {
        events.count
    }
    
    
}
