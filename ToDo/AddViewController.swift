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
    var mode = "Add"
    var selected_todo: String = ""
    
    // Get the default Realm
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.topItem?.title = mode
        
        if mode == "Update"{
            todoText.text = selected_todo
            addUpdateButton.setTitle("Update", forState: UIControlState.Normal)
            deleteButton.alpha = 1.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTodo(sender: UIButton) {
        let todo = Todo()
        
        
        if mode != "Update"{
            // Add to the Realm inside a transaction
            try! realm.write {
                todo.text = todoText.text!
                realm.add(todo)
                print("saving to DB")
            }

        }
        else{
            
            let todo = realm.objects(Todo.self).filter("text == '" + selected_todo + "'").first
            try! realm.write {
                todo!.text = todoText.text!
            }
        }
    
        performSegueWithIdentifier("save_todo", sender: nil)

        
    }

    @IBAction func deleteTodo(sender: UIButton) {
        let todo = realm.objects(Todo.self).filter("text == '" + selected_todo + "'").first
        try! realm.write {
            realm.delete(todo!)
        }
        
        performSegueWithIdentifier("save_todo", sender: nil)
    }
}
