//
//  TestcoreData.swift
//  bicalms
//
//  Created by michael tamsil on 02/06/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TestcoreData: UITableViewController {
    var itemArray = [Item]()
    let dataFilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.dataFilepath)
        self.loadItems()
    }
    
    //MARK - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //context.delete(
        self.saveItems()
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let newItem = Item(context: self.context)
        let df = DateFormatter()
        df.dateFormat="yyyy-MM-dd hh:mm:ss"
        let now = df.string(from: Date())
        newItem.title =  now
        
        self.itemArray.append(newItem)
        self.saveItems()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
//        self.itemArray.removeAll()
//
//        self.saveItems()
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try self.context.execute(request)
            try self.context.save()
            self.tableView.reloadData()
        } catch {
            print("error on delete \(error)")
        }
      
        
    }
    
    // MARK - Model Manipulation Methods
    
    func saveItems() {
        do {
            try self.context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
    }
}
