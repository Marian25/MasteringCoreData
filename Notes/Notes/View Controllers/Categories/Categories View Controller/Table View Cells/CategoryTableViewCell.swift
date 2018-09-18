//
//  CategoryTableViewCell.swift
//  Notes
//
//  Created by Marian Stanciulica on 18/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let reuseIdentifier = "CategoryTableViewCell"
    
    // MARK: -
    
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
