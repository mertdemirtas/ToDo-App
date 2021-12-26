//
//  ToDoListRouter.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//


import UIKit

class ToDoListRouter: NSObject, ToDoListRouterProtocol {
    private unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: ToDoListRoute) {
        switch route {
        case .updateEvent(let event):
            let viewController = EventDetailBuilder.build(with: event)
            self.view.navigationController?.pushViewController(viewController, animated: true)
            break
        
        case .addEvent:
            let viewController = EventDetailBuilder.buildForAdd()
            self.view.navigationController?.pushViewController(viewController, animated: true)
            break
        }
    }
}
