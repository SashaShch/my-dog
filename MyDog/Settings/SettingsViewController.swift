//
//  SettingsViewController.swift
//  MyDog
//
//  Created by Рома on 21.07.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var openSettingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openSettingsButton.layer.cornerRadius = 15
        openSettingsButton.layer.borderColor = UIColor(red: 201/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        openSettingsButton.layer.borderWidth = 1
        
    }
    
    @IBAction func openSettings(_ sender: Any) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") 
            })
        }
    }
    
}
