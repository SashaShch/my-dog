//
//  EventsModel.swift
//  MyDog
//
//  Created by Рома on 29.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import Foundation

struct Events {
    
    let events = [DogsEvent(title: "Еда", date: "", comment: ""),
                  DogsEvent(title: "Осмотр", date: "", comment: ""),
                  DogsEvent(title: "Прогулка", date: "", comment: ""),
                  DogsEvent(title: "Контроль", date: "", comment: ""),
                  DogsEvent(title: "Грунинг", date: "", comment: ""),
                  DogsEvent(title: "Купание", date: "", comment: ""),
                  DogsEvent(title: "Тренировка", date: "", comment: ""),
                  DogsEvent(title: "Прививки", date: "", comment: ""),
                  DogsEvent(title: "Паразитарная обработка", date: "", comment: ""),
                  DogsEvent(title: "Лечение", date: "", comment: "")]
    
    
    func count() -> Int {
        events.count
    }
    
    
}
