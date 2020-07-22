//
//  EventsModel.swift
//  MyDog
//
//  Created by Рома on 29.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import Foundation

struct Events {
    
    let events = [DogsEvent(title: "Еда", date: "", comment: "", image: "eventFood"),
                  DogsEvent(title: "Прогулка", date: "", comment: "", image: "eventWalk"),
                  DogsEvent(title: "Груминг", date: "", comment: "", image: "eventGruming"),
                  DogsEvent(title: "Купание", date: "", comment: "", image: "eventWashing"),
                  DogsEvent(title: "Тренировка", date: "", comment: "", image: "eventTrain"),
                  DogsEvent(title: "Прививки", date: "", comment: "", image: "eventVaccination"),
                  DogsEvent(title: "Паразитарная обработка", date: "", comment: "", image: "eventParasites"),
                  DogsEvent(title: "Лечение", date: "", comment: "", image: "eventMedication")]
    
    
    func count() -> Int {
        events.count
    }
    
    
}
