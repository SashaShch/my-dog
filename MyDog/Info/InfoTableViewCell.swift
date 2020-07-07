//
//  InfoTableViewCell.swift
//  MyDog
//
//  Created by Рома on 24.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var userInfoTextField: UITextField!
    
    override func awakeFromNib() {
        userInfoTextField.isEnabled = false
        
        super.awakeFromNib()
        
        let accessoryView = UIView()
        accessoryView.backgroundColor = .lightGray
        accessoryView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 32)
        
        let doneButton = UIButton()
        doneButton.addTarget(self, action: #selector(accessoryDonePressed), for: .touchUpInside)
        doneButton.setTitle("Done", for: .normal)
        doneButton.frame = CGRect(x: 0, y: 0, width: 100, height: 32)
        
        accessoryView.addSubview(doneButton)
        userInfoTextField.inputAccessoryView = accessoryView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func accessoryDonePressed() {
        userInfoTextField.endEditing(true)
    }

}
