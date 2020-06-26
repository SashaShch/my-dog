//
//  InfoEditTableViewCell.swift
//  MyDog
//
//  Created by Рома on 25.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class InfoEditTableViewCell: UITableViewCell {

    @IBOutlet weak var infoTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let accessoryView = UIView()
        accessoryView.backgroundColor = .lightGray
        accessoryView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 32)
        
        let doneButton = UIButton()
        doneButton.addTarget(self, action: #selector(accessoryDonePressed), for: .touchUpInside)
        doneButton.setTitle("Done", for: .normal)
        doneButton.frame = CGRect(x: 0, y: 0, width: 100, height: 32)
        
        accessoryView.addSubview(doneButton)
        infoTextField.inputAccessoryView = accessoryView
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func accessoryDonePressed() {
        infoTextField.endEditing(true)
    }

}
