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
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemArray.count
//    }
//
//    func a (){
//
//        let newItem = Item(context: self.context)
//        newItem.title = "yeah"
//        self.itemArray.append(newItem)
//        self.saveItems()
//
//    }
    
    
    //MARK - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //context.delete(
        self.saveItems()
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
