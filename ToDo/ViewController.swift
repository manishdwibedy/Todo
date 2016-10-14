//
//  ViewController.swift
//  ToDo
//
//  Created by Manish Dwibedy on 10/14/16.
//  Copyright © 2016 Manish Dwibedy. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var todoList: UITableView!
    
    // The default realm object
    let realm = try! Realm()
    
    // List of todo
    var todo_text_list = [String]()
    
    // The selected todo, if any
    var selected_todo:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Removing any seperators, where it's not needed
        todoList.tableFooterView = UIView()
        
        // Fetching the todo's from the local DB
        let todos = realm.objects(Todo.self)
        
        // Storing the todo's in a list
        for todo in todos{
            todo_text_list.append(todo.text)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo_text_list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.todoList.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.todo_text_list[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Setting the selected todo
        selected_todo = self.todo_text_list[indexPath.row]
        
        // Moving to the other screen to update or delete the todo
        performSegueWithIdentifier("add_update_todo", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "add_update_todo" {
            if let destination = segue.destinationViewController as? AddViewController {
                // If a todo was selected, then changing the mode of operation to update
                if selected_todo.characters.count > 0{
                    destination.mode = "Update"
                }
                // Setting the selected todo
                destination.selected_todo = selected_todo
            }
        }
    }
}

