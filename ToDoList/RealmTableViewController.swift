//
//  RealmTableViewController.swift
//  ToDoList
//
//  Created by Виталий Крюков on 18.06.2021.
//

import UIKit

class TableViewController: UITableViewController {
        
    var persistance = PersistanceToDo()
 
    @IBAction func addButtom(_ sender: Any) {

        let alertController = UIAlertController(title: "Create new ToDo", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "New ToDo name"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
        
        }
        
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
        
            let newItem = alertController.textFields![0].text
            
            if newItem == "" {
                self.persistance.addRealm(addName: "New ToDo", addBool: true)
            }
            else {
                self.persistance.addRealm(addName: newItem!, addBool: true)
            }
            
            self.persistance.loadRealm()
            self.tableView.reloadData()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.persistance.loadRealm()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistance.allData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)

        cell.textLabel?.text = persistance.allData[indexPath.row].toDoName
        cell.accessoryType = persistance.allData[indexPath.row].toDoBool ? .none : .checkmark
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
      
            persistance.deleteRealm(delete: persistance.allData[indexPath.row])
            persistance.loadRealm()
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        persistance.update(note: persistance.allData[indexPath.row])
        persistance.arrayBool[indexPath.row] = !persistance.arrayBool[indexPath.row]

        if persistance.arrayBool[indexPath.row] == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            persistance.loadRealm()
        }
    }
}
