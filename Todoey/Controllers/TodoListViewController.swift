//
//  ViewController.swift
//  Todoey
//
//  Created by Yi Ting Lu on 2019/7/31.
//  Copyright © 2019 Yi Ting Lu. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
  

  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
    }

    // TableView datasource method
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            //Ternary operator
            //value = condition ? valueIfTrue : valueIfFalse
            
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
      
        
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

        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            } catch{
                print("Error")
            }
           
        }
        
        tableView.reloadData()
       // todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)

       // saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    // Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
               
                do {
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        
                        currentCategory.items.append(newItem)
                   }
                } catch {
                    print("Error saving new items, \(error)")
                }
                
            }
           
            self.tableView.reloadData()

            
          //  newItem.parentCategory = self.selectedCategory
           // self.itemArray.append(newItem)
            
           // self.saveItems()
            
         //   self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
//    func saveItems() {
//
//        do {
//           try context.save()
//
//
//        }catch {
//          print("Error saving context, \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    

        tableView.reloadData()

    }

 
    
}

//Mark: - SearchBar Methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }
        }
    }

}



