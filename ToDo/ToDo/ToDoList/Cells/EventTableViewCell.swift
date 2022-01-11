//
//  EventTableViewCell.swift
//  ToDo
//
//  Created by Mert Demirtaş on 19.12.2021.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDate: UIDatePicker!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellTitle.font = UIFont(name: "ChalkboardSE-Bold", size: 20)
        cellDate.overrideUserInterfaceStyle = .dark
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}
