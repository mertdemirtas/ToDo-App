//
//  ToDoListPresentation.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation


struct ToDoListPresentation {
    let title: String
    let date : Date
    let isDone: Bool
    let createDate: Date
    
    init(title: String, date: Date, isDone: Bool, createDate: Date) {
        self.title = title
        self.date = date
        self.isDone = isDone
        self.createDate = createDate
    }
    
    init(event: EventModel) {
        self.init(title: event.title, date: event.date, isDone: event.isDone, createDate: event.createDate)
        
    }
}
