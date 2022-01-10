//
//  ToDoListInteractor.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation
import CoreData
import UIKit

class ToDoListInteractor: NSObject, ToDoListInteractorProtocol {

    weak var delegate: ToDoListInteractorDelegate?
    private var events: [EventModel] = []
    private let coreDataManager : CoreManager
    private let notificationManager : NotificationManagerProtocol
    
    init(coreDataManager: CoreDataManager, notificationManager: LocalNotificationManager) {
        self.coreDataManager = coreDataManager
        self.notificationManager = notificationManager
    }
    
    func viewDidLoad() {
        getEvents()
    }
    
    func getEvents() {
        events = []
        
        let results = coreDataManager.getData()
           // self.events = results
            for result in results {
                events.append(EventModel(title: result.value(forKey: "eventTitle") as! String, date: result.value(forKey: "eventDate") as! Date, description: result.value(forKey: "eventDescription") as! String, createDate: result.value(forKey: "dateCreated") as! Date, isDone: (result.value(forKey: "eventIsDone")) as? Bool))
            }
            
            self.delegate?.handleOutput(.showEventList(events))
    }
    
    func didSelectRow(createDate: Date) {
        for element in events{
            if(element.createDate == createDate){
                self.delegate?.handleOutput(.showEventDetail(element))
            }
        }
    }
    
    func updateEventIsDone(Data: ToDoListPresentation) {
        coreDataManager.updateIsDone(Data: Data)
    }
    
    func deleteEventByRow(Data: ToDoListPresentation){
        coreDataManager.deleteDataByRow(Data: Data)
    }
    
    func deleteNotification(Data: ToDoListPresentation) {
        notificationManager.removeScheduledNotification(data: Data)
    }
    
}



