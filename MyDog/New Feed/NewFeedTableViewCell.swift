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
    @IBOutlet weak var eventCommentLabel: UILabel!
    
    let cornerRadius = 20
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red: 171/255, green: 201/255, blue: 197/255, alpha: 1).cgColor
        self.layer.borderWidth = 15
        
        eventPhotoImage.layer.cornerRadius = eventPhotoImage.frame.width/20
        eventPhotoImage.layer.masksToBounds = true
        
        dogPhotoImage.layer.cornerRadius = dogPhotoImage.frame.width / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
