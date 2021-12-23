//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

enum Constants {
    static let ToDoListArray = "ToDoListArray"
}

class ViewController: UITableViewController {

    var itemArray = [
        ToDoItem(title: "Get license", isDone: false),
        ToDoItem(title: "eat", isDone: true)
    ]
    var alertController: UIAlertController!
    var textField: UITextField!
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func addButtonPressed(_ sender: Any) {
        alertController = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)

        let addAction = UIAlertAction(title: "Add item", style: .default) { (action) in

            guard let newItemText = self.textField.text else { return }

            let newItem = ToDoItem(title: newItemText, isDone: false)

            self.itemArray.append(newItem)
            self.userDefaults.set(self.itemArray, forKey: Constants.ToDoListArray)
            
        }

        alertController.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            self.textField = alertTextField
            self.textField.delegate = self
        }

        alertController.addAction(addAction)
        self.alertController.actions[0].isEnabled = false
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension ViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return 44.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath)

        itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone

        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = UITableViewCell.AccessoryType.none
        }

        // flashes the default gray color
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - UITableViewDataSource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row].title

        if itemArray[indexPath.row].isDone {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }

        return cell
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if ((range.location == 4 && range.length == 0) || (range.location == 5 && range.length == 1)) {
        if ((textField.text?.count)! > 0) {
            self.alertController.actions[0].isEnabled = true
        } else {
            self.alertController.actions[0].isEnabled = false
        }
        return true
    }
}
