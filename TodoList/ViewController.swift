//
//  ViewController.swift
//  TodoList
//
//  Created by Mendy Barouk on 22/03/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

protocol TodosViewControllerDelegate {
    func addTodo(sender: ViewController, todo: String, index: Int?)
}

class ViewController: UIViewController {
    
    var delegate: TodosViewControllerDelegate?
    var todo: String?
    var index: Int?
    

    //Outlet
    @IBOutlet weak var todoTF: UITextField!
    
    //Actions
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard !(todoTF.text?.isEmpty)!, let todoStr = todoTF.text else {
            todoTF.backgroundColor = .red
            return
        }
        
        delegate?.addTodo(sender: self, todo: todoStr, index: index)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todoTF.becomeFirstResponder()
        if todo != nil {
            todoTF.text = todo
        }
    }


}

