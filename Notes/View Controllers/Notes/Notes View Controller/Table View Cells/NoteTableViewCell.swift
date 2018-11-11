//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Marian Stanciulica on 17/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    // MARK: - Static Properties
    
    static let reuseIdentifier = "NoteTableViewCell"
    
    // MARK: - Properties
    
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var categoryColorView: UIView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
