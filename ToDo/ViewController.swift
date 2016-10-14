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
    
    let realm = try! Realm()
    
    var todoCount = 0
    var todo_text_list = [String]()
    
    var selected_todo:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList.tableFooterView = UIView()
        
        let todos = realm.objects(Todo.self)
        
        todoCount = todos.count
        
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
        return todoCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.todoList.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.todo_text_list[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selected_todo = self.todo_text_list[indexPath.row]
        performSegueWithIdentifier("add_update_todo", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "add_update_todo" {
            if let destination = segue.destinationViewController as? AddViewController {
                if selected_todo.characters.count > 0{
                    destination.mode = "Update"
                }
                destination.selected_todo = selected_todo
            }
        }
    }
}

