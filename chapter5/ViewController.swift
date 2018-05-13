//
//  ViewController.swift
//  chapter5
//
//  Created by Jack Sexton on 5/7/18.
//  Copyright © 2018 Jack Sexton. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
//    var toDoArray = ["African Diaspora",
//                     "CS 1",
//                     "Marriage & Family"]
//
//    var toDoNotes = ["Review all of the readings",
//                     "Do the final practice problems",
//                     "Write a long paper"]
    
    var defaultsData = UserDefaults.standard
    var toDoArray = [String]()
    var toDoNotes = [String]()
                     
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        toDoArray = defaultsData.stringArray(forKey: "toDoArray") ?? [String]()
        toDoNotes = defaultsData.stringArray(forKey: "toDoNotes") ?? [String]()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "EditItem"
        {
            let destination = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            destination.toDoItem = toDoArray[index]
            destination.toDoNoteItem = toDoNotes[index]
        }
        else
        {
            if let selectedPath = tableView.indexPathForSelectedRow
            {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    func saveTheData()
    {
        defaultsData.set(toDoArray, forKey: "toDoArray")
        defaultsData.set(toDoNotes, forKey: "toDoNotes")
    }
    
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue)
    {
        let segueSourceControll = segue.source as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow
        {
            toDoArray[indexPath.row] = segueSourceControll.toDoItem!
            toDoNotes[indexPath.row] = segueSourceControll.toDoNoteItem!
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        else
        {
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(segueSourceControll.toDoItem!)
            toDoNotes.append(segueSourceControll.toDoNoteItem!)
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
        saveTheData()
        
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem)
    {
        if tableView.isEditing
        {
            tableView.setEditing(false, animated: false)
            editButton.title = "Edit"
            addButton.isEnabled = true
        }
        else
        {
            tableView.setEditing(true, animated: false)
            editButton.title = "Done"
            addButton.isEnabled = false
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        cell.detailTextLabel?.text = toDoNotes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            toDoArray.remove(at: indexPath.row)
            toDoNotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            saveTheData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let itemToMove = toDoArray[sourceIndexPath.row]
        let noteItemToMove = toDoNotes[sourceIndexPath.row]
        toDoArray.remove(at: sourceIndexPath.row)
        toDoNotes.remove(at: sourceIndexPath.row)
        toDoArray.insert(itemToMove, at: destinationIndexPath.row)
        toDoNotes.insert(noteItemToMove, at: destinationIndexPath.row)
        
        saveTheData()
    }
}

