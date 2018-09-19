//
//  NoteViewController.swift
//  Notes
//
//  Created by Marian Stanciulica on 17/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {

    // MARK: - Segues
    
    private enum Segue {
        
        static let Tags = "Tags"
        static let Categories = "Categories"
        
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var tagsLabel: UILabel!
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
        
        setupNotificationHandling()
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
        case Segue.Tags:
            guard let destination = segue.destination as? TagsViewController else { return }
            
            // Configure Destination
            destination.note = note
        case Segue.Categories:
            guard let destination = segue.destination as? CategoriesViewController else { return }
            
            // Configure Destination
            destination.note = note
        default:
            break
        }
    }
    
    // MARK: - Helper Methods
    
    private func setupNotificationHandling() {
        let notificationCenter  = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: note?.managedObjectContext)
    }
    
    // MARK: - Notification Handling
    
    @objc private func managedObjectContextObjectsDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> else { return }
        
        if (updates.filter { return $0 == note }).count > 0 {
            updateTagsLabel()
            updateCategoryLabel()
        }
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupTagsLabel()
        setupCategoryLabel()
        setupTitleTextField()
        setupContentsTextView()
    }
    
    // MARK: -
    
    private func setupTagsLabel() {
        updateTagsLabel()
    }
    
    private func updateTagsLabel() {
        
    }
    
    private func setupTitleTextField() {
        // Configure Title Text Field
        titleTextField.text = note?.title
    }
    
    private func setupContentsTextView() {
        // Configure Contents Text View
        contentsTextView.text = note?.contents
    }
    
    private func setupCategoryLabel() {
        updateCategoryLabel()
    }
    
    private func updateCategoryLabel() {
        // Configure Category Label
        categoryLabel.text = note?.category?.name ?? "No Category"
    }
    
}
