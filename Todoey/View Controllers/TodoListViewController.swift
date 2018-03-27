//
//  ViewController.swift
//  Todoey
//
//  Created by Axel Nunez on 3/27/18.
//  Copyright © 2018 Axel Nunez. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let todoListCellId = "TodoListCellId"
    var itemArray = [TodoListItem]()

    let defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = TodoListItem()
        newItem1.itemTitle = "Find Mike"
        
        itemArray.append(newItem1)
        
        let newItem2 = TodoListItem()
        newItem2.itemTitle = "Buy Eggos"
        
        itemArray.append(newItem2)
        
        let newItem3 = TodoListItem()
        newItem3.itemTitle = "Destroy Demogorgon"
        
        itemArray.append(newItem3)
//
//        guard let todoListArray : [String] = defaults.value(forKey: "TodoListArray") as? [String] else {
//            return
//        }
//
//        itemArray = todoListArray
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK:- TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: todoListCellId, for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].itemTitle
    
        cell.accessoryType = itemArray[indexPath.row].isDone ? .checkmark : .none
        
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    
    //MARK:- Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            guard let text = textField.text else {
                return
            }
            
            let todoListItem = TodoListItem()
            todoListItem.itemTitle = text
            
            self.itemArray.append(todoListItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")

            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            
            textField = alertTextField
        }
        
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
        
    }
}

