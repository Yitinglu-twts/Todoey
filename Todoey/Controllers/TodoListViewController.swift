//
//  ViewController.swift
//  Todoey
//
//  Created by Yi Ting Lu on 2019/7/31.
//  Copyright © 2019 Yi Ting Lu. All rights reserved.
//

import UIKit


class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Sleep"
        itemArray.append(newItem3)
        

        
        
        
  
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        }
        
    }

    // TableView datasource method
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title

        //Ternary operator
        //value = condition ? valueIfTrue : valueIfFalse
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//
//        }else {
//            cell.accessoryType = .none
//        }
//
        return cell
    }
    
    // TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    // Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
            
         //   self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
        }catch {
            print("Error endoing item array, \(error)")
        }
    }
    
    
}

