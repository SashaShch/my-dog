//
//  RemainderTableViewCell.swift
//  MyDog
//
//  Created by Рома on 07.07.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class RemainderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}