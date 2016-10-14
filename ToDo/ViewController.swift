//
//  ViewController.swift
//  ToDo
//
//  Created by Manish Dwibedy on 10/14/16.
//  Copyright © 2016 Manish Dwibedy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todoList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList.tableFooterView = UIView()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

