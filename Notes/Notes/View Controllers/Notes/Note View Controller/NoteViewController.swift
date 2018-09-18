//
//  NoteViewController.swift
//  Notes
//
//  Created by Marian Stanciulica on 17/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    // MARK: - Segues
    
    private enum Segue {
        
        static let Categories = "Categories"
        
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    
    // MARK: -
    var note: Note?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Note"
        
        setupView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Update Note
        if let title = titleTextField.text, !title.isEmpty {
            note?.title = title
        }
        
        note?.updatedAt = Date()
        note?.contents = contentsTextView.text
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.Categories:
            guard let destination = segue.destination as? CategoriesViewController else { return }
            
            // Configure Destination
            destination.managedObjectContext = note?.managedObjectContext
        default:
            break
        }
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupTitleTextField()
        setupContentsTextView()
    }
    
    // MARK: -
    
    private func setupTitleTextField() {
        // Configure Title Text Field
        titleTextField.text = note?.title
    }
    
    private func setupContentsTextView() {
        // Configure Contents Text View
        contentsTextView.text = note?.contents
    }
}
