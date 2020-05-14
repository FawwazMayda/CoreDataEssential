//
//  ViewController.swift
//  CoreDataEssential
//
//  Created by Muhammad Fawwaz Mayda on 14/05/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var todoListTableView: UITableView!
    
    var allTask = [Task]() {
        didSet {
            todoListTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        taskTextField.delegate = self
        taskTextField.placeholder = "Enter your Task"
        allTask = Task.fetchAll(viewContext: getViewContext()!)
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        if let currentContext = getViewContext(),let currentTaskName = taskTextField.text {
            if let newTask = Task.save(viewContext: currentContext, taskName: currentTaskName) {
                allTask.append(newTask)
            }
        }
    }
    
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoListTableView.dequeueReusableCell(withIdentifier: "CellTo", for: indexPath)
        cell.textLabel?.text = "\(allTask[indexPath.row].taskName!)"
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        taskTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
    
}
