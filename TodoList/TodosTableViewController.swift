//
//  TodosTableViewController.swift
//  TodoList
//
//  Created by Mendy Barouk on 22/03/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class TodosTableViewController: UITableViewController, TodosViewControllerDelegate {
    
    var todosList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let defaults = UserDefaults.standard
        todosList = defaults.stringArray(forKey: "todoList") ?? []
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
 
    
    override func viewDidDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(todosList, forKey: "todoList")
        defaults.synchronize()
        
        super.viewDidDisappear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todosList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = todosList[indexPath.row]

        return cell
    }
    
    //MARK: --TodoViewController Delegate
    func addTodo(sender: ViewController, todo: String, index: Int?) {
        if index == nil {
            todosList.append(todo)
        } else {
            todosList[index!] = todo
        }
        tableView.reloadData()
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todosList.remove(at: indexPath.row)
            tableView.reloadData()
            //tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addTodo" {
            let vc = segue.destination as! ViewController
            vc.delegate = self
        } else if let cell = sender as? UITableViewCell {
            let i = tableView.indexPath(for: cell)!.row
            if segue.identifier == "detailSegue" {
                let vc = segue.destination as! ViewController
                vc.delegate = self
                vc.todo = todosList[i]
                vc.index = i
            }
        }
    }
    
}
