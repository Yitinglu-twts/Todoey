//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Yi Ting Lu on 2019/8/22.
//  Copyright © 2019 Yi Ting Lu. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    var categories: Results<Category>!
// let defaults = UserDefaults.standard
    
  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
       
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category added yet"
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving category, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategory() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()

//        let request: NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//            categories = try context.fetch(request)
//            
//        }catch{
//            print("Error fetching data from context\(error)")
//        }
//        
        
    }
    
    
    
    //Mark: Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Cat.", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
           // self.categories.append(newCategory)
            
            self.save(category: newCategory)
            
            //   self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Cat."
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
    }

   

  


}
