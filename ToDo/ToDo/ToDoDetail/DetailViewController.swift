//
//  DetailViewController.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var eventTitleTF: UITextField!
    @IBOutlet weak var eventDateDP: UIDatePicker!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventDescriptionTF: UITextView!
    
    var addButton = UIBarButtonItem()

    var viewModel: EventDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        
        
        eventTitleTF.delegate = self
        eventDescriptionTF.delegate = self
        
        eventDateDP.minimumDate = viewModel.currentDate()

        addButton = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItems = [addButton]
        
        eventDateDP.setValue(UIColor.white, forKeyPath: "textColor")
        
        navigationController?.navigationBar.barStyle  = .black
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.tintColor = .white
        
        eventDateDP.overrideUserInterfaceStyle = .dark
        
        eventTitleTF.addTarget(self, action: #selector(didChange(textField:)), for: .editingChanged)
        eventDateDP.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
        eventTitleLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 23)
        eventDescriptionTF.font = UIFont(name: "ChalkboardSE-Bold", size: 17)
        eventTitleTF.font = UIFont(name: "ChalkboardSE-Bold", size: 19)
        eventDescriptionLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 23)
        control()
        
    }
    
    @objc func addButtonTapped(){
        
        viewModel.dataControl(event: EventModel(title: eventTitleTF.text!, date: eventDateDP.date, description: eventDescriptionTF.text ?? "", createDate: Date(), isDone: false))
        self.navigationController?.popViewController(animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        control()
    }
    
    @objc func didChange(textField: UITextField){
        control()
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        control()
    }
    
    func control(){
        let result = viewModel.eventComparisionForUpdate(liveData: EventDetailPresentation(eventTitle: eventTitleTF.text ?? "", eventDate: eventDateDP.date, eventDescription: eventDescriptionTF.text ?? ""))
        addButton.tintColor = result.0
        addButton.isEnabled = result.1
    }
}

extension DetailViewController: EventDetailViewModelDelegate {

    func showEventDetail(_ event: EventDetailPresentation) {
        eventTitleTF.text = event.eventTitle
        eventDateDP.date = event.eventDate
        eventDescriptionTF.text = event.eventDescription
    }
}

extension DetailViewController: UITextFieldDelegate {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        eventTitleTF.endEditing(true)
        eventDescriptionTF.endEditing(true)
    }
}



