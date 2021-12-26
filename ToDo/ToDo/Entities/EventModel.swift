//
//  EventModel.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation

struct EventModel: Codable {
    var title: String
    var date: Date
    var description: String
    var createDate: Date
    var isDone: Bool!
}
