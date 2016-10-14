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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList.tableFooterView = UIView()
        
        let todos = realm.objects(Todo.self)
        
        todoCount = todos.count
        
        for todo in todos{
            print(todo.text)
            todo_text_list.append(todo.text)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
    }

}

