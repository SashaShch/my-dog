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
        
        userInfoTextField.layer.cornerRadius = 20
        userInfoTextField.layer.borderWidth = 1
        userInfoTextField.layer.borderColor = UIColor(red: 201/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        
        userInfoTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userInfoTextField.frame.height))
        userInfoTextField.leftViewMode = .always
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func accessoryDonePressed() {
        userInfoTextField.endEditing(true)
    }

}
