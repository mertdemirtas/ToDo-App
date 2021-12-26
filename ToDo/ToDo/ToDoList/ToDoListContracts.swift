//
//  ToDoListContracts.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation

//MARK: View
protocol ToDoListViewProtocol: NSObject {
    func handleOutput(_ output: ToDoListPresenterOutput)
}

//MARK: Interactor
enum ToDoListInteractorOutput {
    case showEventDetail(EventModel)
    case showEventList([EventModel])
}

protocol ToDoListInteractorDelegate: NSObject {
    func handleOutput(_ output: ToDoListInteractorOutput)
}

protocol ToDoListInteractorProtocol: NSObject {
    var delegate: ToDoListInteractorDelegate? { get set }
    func viewDidLoad()
    func didSelectRow(createDate: Date)
    func updateEventIsDone(Data: ToDoListPresentation)
    func deleteEventByRow(Data: ToDoListPresentation)
    func deleteNotification(Data: ToDoListPresentation)
}

//MARK: Presenter
protocol ToDoListPresenterProtocol: NSObject {
    func viewDidLoad()
    func didSelectRow(createDate : Date)
    func addEvent()
    func updateEventIsDone(Data: ToDoListPresentation)
    func deleteEventByRow(Data: ToDoListPresentation)
    func deleteNotification(Data: ToDoListPresentation)
    func prepareDataForTableView(data: [ToDoListPresentation]) -> ([[ToDoListPresentation]], Int)
}

enum ToDoListPresenterOutput {
    case showEventList([ToDoListPresentation]) 
}

//MARK: Router
enum ToDoListRoute{
    case addEvent
    case updateEvent(EventModel)
}

protocol ToDoListRouterProtocol: NSObject {
   func navigate(to route: ToDoListRoute)
}


