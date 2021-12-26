//
//  ListBuilder.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation
import UIKit

class ListBuilder {
    
    static func build() -> ToDoListViewController {
        
        let storyboard = UIStoryboard(name: "ToDoList", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "ToDoListViewController") as! ToDoListViewController
        
        let interactor = ToDoListInteractor(coreDataManager: CoreDataManager(), notificationManager: LocalNotificationManager())
        let router = ToDoListRouter(view: view)
        let presenter = ToDoListPresenter(interactor: interactor, view: view, router: router)
        
        view.presenter = presenter
        interactor.delegate = presenter
        
        return view
        
    }
}


