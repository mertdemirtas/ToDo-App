//
//  LocalNotificationManager.swift
//  ToDo
//
//  Created by Mert Demirtaş on 22.12.2021.
//

import Foundation
import UserNotifications

protocol NotificationManagerProtocol{
    func removeScheduledNotification(data: ToDoListPresentation)
    func scheduleNotification(data: EventModel)
    func updateNotification(data: EventModel)
    func dateFormat(date: Date) -> String
 
}
class LocalNotificationManager: NotificationManagerProtocol , ObservableObject {
    
    static let shared = LocalNotificationManager()
    
      
    func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.string(from: date)
    }
    
      func removeScheduledNotification(data: ToDoListPresentation) {
        UNUserNotificationCenter.current()
              .removePendingNotificationRequests(withIdentifiers: [dateFormat(date: data.createDate)])
      }

      func scheduleNotification(data: EventModel) {

        let content = UNMutableNotificationContent()
          
        content.title = "It's time for " + "\(data.title)"
        content.body = data.description
        content.categoryIdentifier = "To Do App"

        var trigger: UNNotificationTrigger?
          let date = data.date
            trigger = UNCalendarNotificationTrigger(
              dateMatching: Calendar.current.dateComponents(
                [.day, .month, .year, .hour, .minute],
                from: date),
              repeats: false)
          
        // 4
        if let trigger = trigger {
          let request = UNNotificationRequest(
            identifier: dateFormat(date: data.createDate),
            content: content,
            trigger: trigger)
          // 5
          UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
              print(error)
                    }
                }
            }
      }
    
    func updateNotification(data: EventModel){
        removeScheduledNotification(data: ToDoListPresentation(event: data))
        scheduleNotification(data: data)

     }
}


