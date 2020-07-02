//
//  NewFeedTableViewCell.swift
//  MyDog
//
//  Created by Рома on 30.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class NewFeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var dateCommentLabel: UILabel!
    @IBOutlet weak var eventPhotoImage: UIImageView!
    @IBOutlet weak var dogPhotoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
