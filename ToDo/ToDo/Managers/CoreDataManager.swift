//
//  CoreDataManager.swift
//  ToDo
//
//  Created by Mert Demirtaş on 20.12.2021.
//

import Foundation


import Foundation
import CoreData
import UIKit



protocol CoreManager {
    
    func getData() -> [NSManagedObject]
    func addData(Data: EventModel)
    func updateData(Data: EventModel)
    func updateIsDone(Data: ToDoListPresentation)
    func deleteDataByRow(Data: ToDoListPresentation)

    var appDelegate: AppDelegate { get set }
    var managedContext: NSManagedObjectContext { get set }
    var entity: NSEntityDescription { get set}
    var fetchRequest: NSFetchRequest<NSManagedObject> { get set }
    var request: NSFetchRequest<NSFetchRequestResult> { get set}
}

class CoreDataManager : CoreManager {
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var managedContext = appDelegate.persistentContainer.viewContext
    lazy var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Events")
    lazy var entity = NSEntityDescription.entity(forEntityName: "Events", in: managedContext)!
    lazy var request = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
    
    func getData() -> [NSManagedObject]{
        var result = [NSManagedObject]()
        
        do{
            result = try managedContext.fetch(fetchRequest)
            
        } catch let err as NSError{
            print("Error", err)
        }
        
        return result
    }
    
    func addData(Data: EventModel){
        let event = NSManagedObject(entity: entity, insertInto: managedContext)
        
        event.setValue(Data.title, forKeyPath: "eventTitle")
        event.setValue(Data.date, forKeyPath: "eventDate")
        event.setValue(Data.description, forKeyPath: "eventDescription")
        event.setValue(Data.createDate, forKeyPath: "dateCreated")
        event.setValue(Data.isDone, forKey: "eventIsDone")

        saveContext()
    }
    
    func updateData(Data: EventModel){
        do {
            let results = try managedContext.fetch(request) as! [NSManagedObject]
            for result in results{
                if(result.value(forKey: "dateCreated") as! Date == Data.createDate){
                    result.setValue(Data.title, forKey: "eventTitle")
                    result.setValue(Data.date, forKey: "eventDate")
                    result.setValue(Data.description, forKey: "eventDescription")
                    result.setValue(Data.createDate, forKey: "dateCreated")
                    result.setValue(Data.isDone, forKey: "eventIsDone")
                }
            }

        } catch{
            print("error in updating")
        }

        saveContext()
    }
   
    func deleteDataByRow(Data: ToDoListPresentation) {
        do {
            let results = try managedContext.fetch(request) as! [NSManagedObject]
            for result in results{
                if(result.value(forKey: "dateCreated") as! Date == Data.createDate){
                    managedContext.delete(result)
                }
            }
        } catch{
            print("error in deleting")
        }
        saveContext()
    }
    
    func updateIsDone(Data: ToDoListPresentation){
        do {
            let results = try managedContext.fetch(request) as! [NSManagedObject]
            for result in results{
                if(result.value(forKey: "dateCreated") as! Date == Data.createDate){
                    result.setValue(true, forKey: "eventIsDone")
                }
            }

        } catch{
            print("error in updating")
        }
        saveContext()
    }
    
    func saveContext(){
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

