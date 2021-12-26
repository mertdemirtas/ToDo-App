//
//  EventDetailContracts.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation
import UIKit

protocol EventDetailViewModelDelegate: NSObject {
    func showEventDetail(_ event: EventDetailPresentation)
}

protocol EventDetailViewModelProtocol {
    var delegate: EventDetailViewModelDelegate? { get set }
    func viewDidLoad()
    func addDataNavigate(to operation: ToDoAdd)
    func dataControl(event: EventModel)
    func currentDate() -> Date
//    func addButtonLoad() -> Bool
    func eventComparisionForUpdate(liveData: EventDetailPresentation) -> (UIColor, Bool)
    
}

enum ToDoAdd{
    case addEvent(EventModel)
    case updateEvent(EventModel)
}
