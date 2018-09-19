//
//  TagViewController.swift
//  Notes
//
//  Created by Marian Stanciulica on 19/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: -
    
    var tag: Tag?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Tag"
        
        setupView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Update Tag
        if let name = nameTextField.text, !name.isEmpty {
            tag?.name = name
        }
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupNameTextField()
    }
    
    // MARK: -
    
    private func setupNameTextField() {
        // Configure Name Text Field
        nameTextField.text = tag?.name
    }

}
