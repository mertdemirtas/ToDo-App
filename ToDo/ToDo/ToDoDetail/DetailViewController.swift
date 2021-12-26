//
//  DetailViewController.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var eventTitleTF: UITextField!
    @IBOutlet weak var eventDateDP: UIDatePicker!
    @IBOutlet weak var eventDescriptionTF: UITextField!
    @IBOutlet weak var eventTitleLabel: UILabel!
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
        
        eventTitleLabel.text = eventTitleTF.text
        eventDateDP.minimumDate = viewModel.currentDate()

        addButton = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItems = [addButton]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        eventTitleTF.addTarget(self, action: #selector(didChange(textField:)), for: .editingChanged)
        eventDateDP.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        eventDescriptionTF.addTarget(self, action: #selector(didChange(textField:)), for: .editingChanged)
        control()
        
    }
    
    @objc func addButtonTapped(){
        
        viewModel.dataControl(event: EventModel(title: eventTitleTF.text!, date: eventDateDP.date, description: eventDescriptionTF.text ?? "", createDate: Date(), isDone: false))
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didChange(textField: UITextField){
        eventTitleLabel.text = eventTitleTF.text
        control()
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        control()
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -view.frame.height/2.6 // Move view view.frame.height/4.3 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
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



