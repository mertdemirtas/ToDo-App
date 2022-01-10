//
//  ToDoListViewController.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import UIKit

class ToDoListViewController: UIViewController, ToDoListViewProtocol {


    @IBOutlet weak var doneCount: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    
    @IBOutlet weak var toDoCount: UILabel!
    @IBOutlet weak var toDoLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addEventButton: UIBarButtonItem!
    @IBOutlet weak var sortByDateButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.presenter.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: EventTableViewCell.self), bundle: nil), forCellReuseIdentifier: "ToDoListTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.barStyle  = .black
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.tintColor = .white
        
        doneCount.font = UIFont(name: "ChalkboardSE-Bold", size: 28)
        doneLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 28)
        
        toDoCount.font = UIFont(name: "ChalkboardSE-Bold", size: 28)
        toDoLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 28)
    }
    
    var presenter: ToDoListPresenterProtocol!
    var events: [ToDoListPresentation] = []
    var eventsWithSections = [[ToDoListPresentation]]()
    var numberOfSections : Int = 0
    
    func handleOutput(_ output: ToDoListPresenterOutput) {
        switch output {
        case .showEventList(let events):
            self.events = events
            let result = self.presenter.prepareDataForTableView(data: self.events)
        
            self.eventsWithSections = result.0
            numberOfSections = result.1
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addEventButton(_ sender: Any) {
        presenter.addEvent()
    }
    
    @IBAction func sortByDate(_ sender: Any) {
        self.eventsWithSections[0].sort { $0.date < $1.date }
        self.eventsWithSections[1].sort { $0.date < $1.date }
        self.tableView.reloadData()
    }
}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
            case 0:
                presenter.didSelectRow(createDate: self.eventsWithSections[0][indexPath.row].createDate)
                break
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var doneAction =  UIContextualAction()
        
        let deleteAction = UIContextualAction(style: .normal, title: "") {
            (deleteAction, view, completionHandler) in
            
            self.presenter.deleteNotification(Data: self.eventsWithSections[indexPath.section][indexPath.row])
            
            self.presenter.deleteEventByRow(Data: self.eventsWithSections[indexPath.section][indexPath.row])
            
            self.eventsWithSections[indexPath.section].remove(at: indexPath.row)
            
            self.presenter.viewDidLoad()
            self.tableView.reloadData()
                completionHandler(true)
        }
        
        doneAction = UIContextualAction(style: .normal, title: "") {
            (doneAction, view, completionHandler) in
            self.presenter.deleteNotification(Data: self.eventsWithSections[indexPath.section][indexPath.row])
            
            self.presenter.updateEventIsDone(Data: self.eventsWithSections[indexPath.section][indexPath.row])
            
            self.presenter.viewDidLoad()
            self.tableView.reloadData()
                completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        doneAction.image = UIImage(systemName: "checkmark")
        
        deleteAction.backgroundColor = .systemRed
        doneAction.backgroundColor = .systemGreen
        
        switch indexPath.section{
            case 0:
                return UISwipeActionsConfiguration(actions: [deleteAction, doneAction])
            case 1:
                return UISwipeActionsConfiguration(actions: [deleteAction])
            default:
                return UISwipeActionsConfiguration(actions: [deleteAction, doneAction])
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
        }
    }
  }
    
extension ToDoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoCount.text = String(eventsWithSections[0].count)
        doneCount.text = String(eventsWithSections[1].count)
        switch section{
            case 0:
                return eventsWithSections[0].count
            case 1:
                return eventsWithSections[1].count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
            case 0:
                return "Tamamlanmayan"
            case 1:
                return "Tamamlanan"
            default:
                return "Other"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as? EventTableViewCell else {return UITableViewCell()}
        
        switch indexPath.section{
            case 0:
                cell.cellTitle.text = eventsWithSections[indexPath.section][indexPath.row].title
                cell.cellDate.date = eventsWithSections[indexPath.section][indexPath.row].date
                cell.cellView.backgroundColor = UIColor.systemBlue
                return cell
            case 1:
                cell.cellTitle.text = eventsWithSections[indexPath.section][indexPath.row].title
                cell.cellDate.date = eventsWithSections[indexPath.section][indexPath.row].date
                cell.cellView.backgroundColor = UIColor.systemIndigo
                return cell
            default:
                return cell
        }
    }
}


