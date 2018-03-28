//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Axel Nunez on 3/28/18.
//  Copyright © 2018 Axel Nunez. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray : [Category] = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let categoryCellId = "categoryCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    //MARK:- Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //MARK:- Data Manipulation Methods
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
    
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching categories: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error occurred while saving categories: \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK:- Add new categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { (alertAction) in
            
            let category = Category(context: self.context)
            category.name = textField.text
            
            self.categoryArray.append(category)
            
            self.saveCategories()
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Category"
            
            textField = alertTextField
        }
        
        alert.addAction(alertAction)

        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    //MARK:- Navigation Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
}
