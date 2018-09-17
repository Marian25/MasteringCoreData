//
//  ViewController.swift
//  Notes
//
//  Created by Marian Stanciulica on 17/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController, NSFetchedResultsControllerDelegate {

    // MARK: - Segues
    
    private enum Segue {
        
        static let Note = "Note"
        static let AddNote = "AddNote"
        
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var notesVIew: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -
    
    private let coreDataManager = CoreDataManager(modelName: "Notes")
    
    // MARK: -
    
    private let estimatedRowHeight = CGFloat(44.0)
    
    // MARK: -
    
    private lazy var updatedAtDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter
    }()
    
    // MARK: -
    
    private var hasNotes: Bool {
        guard let fetchedObjects = fetchedResultsController.fetchedObjects else {return false }
        return fetchedObjects.count > 0
    }
    
    // MARK: -
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Note> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Note.updatedAt), ascending: false)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        
        setupView()
        fetchNotes()
        updateView()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case Segue.AddNote:
            guard let destination = segue.destination as? AddNoteViewController else { return }
            
            // Configure Destination
            destination.managedObjectContext = coreDataManager.managedObjectContext
        case Segue.Note:
            guard let destination = segue.destination as? NoteViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            // Fetch Note
            let note = fetchedResultsController.object(at: indexPath)
            
            // Configure Destination
            destination.note = note
        default:
            break
        }
        
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupMessageLabel()
        setupTableView()
    }
    
    // MARK: -
    
    private func updateView() {
        tableView.isHidden = !hasNotes
        messageLabel.isHidden = hasNotes
    }
    
    // MARK: -
    
    private func setupMessageLabel() {
        messageLabel.text = "You don't have any notes yet."
    }
    
    // MARK: -
    
    private func setupTableView() {
        tableView.isHidden = true
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: -
    
    private func fetchNotes() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print("Unable to Perform Fetch Request")
            print("\(error), \(error.localizedDescription)")
        }
    }

}

extension NotesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseIdentifier, for: indexPath) as? NoteTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Note
        let note = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.titleLabel.text = note.title
        cell.contentsLabel.text = note.contents
        cell.updatedAtLabel.text = updatedAtDateFormatter.string(from: note.updatedAtAsDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        // Fetch Note
        let note = fetchedResultsController.object(at: indexPath)
        
        // Delete note
        note.managedObjectContext?.delete(note)
    }
}

