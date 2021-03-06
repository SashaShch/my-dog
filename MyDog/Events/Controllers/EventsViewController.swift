//
//  EventsViewController.swift
//  MyDog
//
//  Created by Рома on 29.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    let cellCountPerRow = 2
    let cellMargin: CGFloat = 10
    var events = Events()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}


extension EventsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return events.count()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = events.events[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Event Cell", for: indexPath) as! EventCell
        
        cell.eventLabel.text = item.title
        let image = UIImage(named: item.image)
            cell.eventImage.image = image
        
        return cell
    }
    
}

extension EventsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = floor((UIScreen.main.bounds.width - CGFloat(cellCountPerRow + 1) * cellMargin) / CGFloat(cellCountPerRow))
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return cellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return cellMargin
    }
    
}

extension EventsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = events.events[indexPath.item]
        
        if let vc = self.storyboard?.instantiateViewController(identifier: "EventInfoViewController") as EventInfoViewController? {
            vc.dogsEvent = item
            vc.goToNewFeed = {
                self.tabBarController?.selectedIndex = 0
                vc.dismiss(animated: true, completion:nil)
            }
            present(vc, animated: true, completion: nil)
            
        }
    }
}
