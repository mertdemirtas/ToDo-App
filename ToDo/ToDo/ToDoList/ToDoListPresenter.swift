//
//  ToDoListPresenter.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import Foundation

class ToDoListPresenter: NSObject, ToDoListPresenterProtocol {

    private unowned let view: ToDoListViewProtocol
    private let router: ToDoListRouterProtocol
    private var interactor: ToDoListInteractorProtocol {
        didSet {
            self.interactor.delegate = self
        }
    }
    private let sortByDate = 0
    
    init(interactor: ToDoListInteractorProtocol,
         view: ToDoListViewProtocol,
         router: ToDoListRouterProtocol) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func didSelectRow(createDate: Date) {
        interactor.didSelectRow(createDate: createDate)
    }
    
    func addEvent(){
        router.navigate(to: .addEvent)
    }
    
    func updateEventIsDone(Data: ToDoListPresentation) {
        interactor.updateEventIsDone(Data: Data)
    }
    
    func deleteEventByRow(Data: ToDoListPresentation) {
        interactor.deleteEventByRow(Data: Data)
    }
    
    func deleteNotification(Data: ToDoListPresentation){
        interactor.deleteNotification(Data: Data)
    }
    
    func prepareDataForTableView(data: [ToDoListPresentation]) -> ([[ToDoListPresentation]], Int) {
        var result = [[ToDoListPresentation]]()
        var listOfUnCompleted = [ToDoListPresentation]()
        var listOfCompleted = [ToDoListPresentation]()
        var numberOfSections = 1
        
        for element in data{
            if(element.isDone == false){
                listOfUnCompleted.append(element)
            }
            else{
                listOfCompleted.append(element)
            }
        }
        
        result.append(listOfUnCompleted)
        result.append(listOfCompleted)
        
        if(listOfCompleted.count>0){
            numberOfSections+=1
        }
        return (result, numberOfSections)
    }
}

extension ToDoListPresenter: ToDoListInteractorDelegate {
    func handleOutput(_ output: ToDoListInteractorOutput) {
        switch output {
        case .showEventList(let events):
            view.handleOutput(.showEventList(events.map(ToDoListPresentation.init)))
        case .showEventDetail(let event):
            router.navigate(to: .updateEvent(event))
        }
    }
}
