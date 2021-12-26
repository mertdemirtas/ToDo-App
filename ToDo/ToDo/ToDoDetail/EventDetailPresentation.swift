//
//  EventDetailPresentation.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation

struct EventDetailPresentation {
    let eventTitle: String
    let eventDate: Date
    let eventDescription: String
    
    init(eventTitle: String, eventDate: Date, eventDescription: String) {
        self.eventTitle = eventTitle
        self.eventDate = eventDate
        self.eventDescription = eventDescription
    }
    
    init(event: EventModel) {
        self.init(eventTitle: event.title,
                  eventDate: event.date,
                  eventDescription: event.description)
    }
}
