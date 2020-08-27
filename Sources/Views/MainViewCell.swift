//
//  MainViewCell.swift
//  TaskManager
//
//  Created by Roman on 31.07.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import UIKit

class MainViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = UIFont(name: "SFUIText-Bold", size: 14.0)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! 
    
   
    
    @IBOutlet weak var cellViewFormat: UIView! {
        didSet {
            cellViewFormat.layer.cornerRadius = 10
            cellViewFormat.layer.shadowOffset = CGSize(width: 0, height: 0)
            cellViewFormat.layer.shadowColor = UIColor.black.cgColor
            cellViewFormat.layer.shadowRadius = 4
            cellViewFormat.layer.shadowOpacity = 0.2
            cellViewFormat.layer.masksToBounds = false
            cellViewFormat.clipsToBounds = false
        }
    }
    

}
