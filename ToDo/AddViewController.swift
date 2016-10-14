//
//  AddViewController.swift
//  ToDo
//
//  Created by Manish Dwibedy on 10/14/16.
//  Copyright © 2016 Manish Dwibedy. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class AddViewController: UIViewController {

    @IBOutlet weak var todoText: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // The mode of operation - either add or update
    var mode = "Add"
    
    // The selected todo, if any
    var selected_todo: String = ""
    
    // Getting the default Realm
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.topItem?.title = mode
        
        // If a todo has been selected
        if mode == "Update"{
            // Setting the text of the todo
            todoText.text = selected_todo
            
            // Change the text of the button
            addUpdateButton.setTitle("Update", forState: UIControlState.Normal)
            
            // Showing the delete button
            deleteButton.alpha = 1.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTodo(sender: UIButton) {
        // If a new todo is being created
        if mode != "Update"{
            // Add to the Realm inside a transaction
            try! realm.write {
                let todo = Todo()
                todo.text = todoText.text!
                realm.add(todo)
            }

        }
        // If an existing todo is being updated
        else{
            // getting the selected todo object from the DB
            let todo = realm.objects(Todo.self).filter("text == '" + selected_todo + "'").first
            
            // Updating the text of the DB
            try! realm.write {
                todo!.text = todoText.text!
            }
        }
        
        // Moving back to the home page
        performSegueWithIdentifier("homepage", sender: nil)
    }

    @IBAction func deleteTodo(sender: UIButton) {
        // getting the selected todo object from the DB
        let todo = realm.objects(Todo.self).filter("text == '" + selected_todo + "'").first
        
        // Deleting the todo from the DB
        try! realm.write {
            realm.delete(todo!)
        }
        
        // Moving back to the home page
        performSegueWithIdentifier("homepage", sender: nil)
    }
}
