//
//  TagTableViewCell.swift
//  Notes
//
//  Created by Marian Stanciulica on 19/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let reuseIdentifier = "TagTableViewCell"
    
    // MARK: -
    
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
