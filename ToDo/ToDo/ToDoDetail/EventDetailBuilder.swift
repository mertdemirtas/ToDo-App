//
//  File.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation
import UIKit

class EventDetailBuilder {
    
    static func build(with event: EventModel) -> DetailViewController{
        let viewController = DetailViewController()
        
        viewController.viewModel = EventDetailViewModel(event: event)
        return viewController
    }
    
    static func buildForAdd() -> DetailViewController{
        let viewController = DetailViewController()
        
        viewController.viewModel = EventDetailViewModel(event: EventModel(title: "", date: Date(), description: "", createDate: Date(), isDone: false))
        return viewController
    }
    
}
