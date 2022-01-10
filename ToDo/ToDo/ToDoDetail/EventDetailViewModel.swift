//
//  EventDetailViewModel.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation
import UIKit

class EventDetailViewModel: NSObject, EventDetailViewModelProtocol {
    
    weak var delegate: EventDetailViewModelDelegate?
    private let CoreDataManager : CoreManager
    private let event: EventModel
    private let titleCheck: Bool
    private let createdDate: Date
    private let NotificationManager: LocalNotificationManager
    
    init(event: EventModel) {
        self.event = event
        self.titleCheck = event.title == "" ? false : true
        self.createdDate = event.createDate
        self.CoreDataManager = ToDo.CoreDataManager()
        self.NotificationManager = ToDo.LocalNotificationManager()
    }
    
    func viewDidLoad() {
        delegate?.showEventDetail(EventDetailPresentation(event: event))
    }
    
    func currentDate() -> Date {
        return Date()
    }
    
    func eventComparisionForUpdate(liveData: EventDetailPresentation) -> (UIColor, Bool) {
        
        if(liveData.eventTitle == ""){
            return (UIColor.darkGray, false)
        }
        
        if(liveData.eventTitle == self.event.title && liveData.eventDate == self.event.date && liveData.eventDescription == self.event.description){
            return (UIColor.darkGray, false)
        }
        else{
            return (UIColor.white, true)}
    }
    
    func dataControl(event: EventModel){
        self.titleCheck == false ? addDataNavigate(to: .addEvent(event)) : addDataNavigate(to: .updateEvent(event))
    }
    
    func addDataNavigate(to operation: ToDoAdd) {
        switch operation {
            
        case .addEvent(let eventModel):
            CoreDataManager.addData(Data: eventModel)
            NotificationManager.scheduleNotification(data: eventModel)
            break
            
        case .updateEvent(var eventModel):
            eventModel.createDate = self.createdDate
            CoreDataManager.updateData(Data: eventModel)
            NotificationManager.updateNotification(data: eventModel)
            break
        }
    }
    
}

    
    

