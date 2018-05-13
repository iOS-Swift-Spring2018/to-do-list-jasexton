//
//  DetailViewController.swift
//  chapter5
//
//  Created by Jack Sexton on 5/7/18.
//  Copyright © 2018 Jack Sexton. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var toDoField: UITextField!
    @IBOutlet weak var toDoNoteField: UITextView!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var toDoItem: String?
    var toDoNoteItem: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let toDoItem = toDoItem
        {
            toDoField.text = toDoItem
            self.navigationItem.title = "Edit To Do Item"
        }
        else
        {
            self.navigationItem.title = "New To Do Item"
        }
        if let toDoNoteItem = toDoNoteItem
        {
           toDoNoteField.text = toDoNoteItem
       }
        
        enableDisableSaveButton()
        toDoField.becomeFirstResponder()
     
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem)
    {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode
        {
            dismiss(animated: true, completion: nil)
        }
        else
        {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func enableDisableSaveButton()
    {
        if toDoField.text!.count > 0
        {
            saveButton.isEnabled = true
        }
        else
        {
            saveButton.isEnabled = false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "unwindFromDetail"
        {
            toDoItem = toDoField.text!
            toDoNoteItem = toDoNoteField.text!
        }
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField)
    {
        enableDisableSaveButton()
    }
    

}
