//
//  coreDataFunction.swift
//  bicalms
//
//  Created by michael tamsil on 02/06/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import Foundation
import CoreData
import UIKit


func coreDataAddItem(excercise: String){
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let newItem = Item(context: context)
    let df = DateFormatter()
    df.dateFormat="MMM dd hh:mm"
    let now = df.string(from: Date())
    
    newItem.title =  "\(excercise) at \(now)"
    itemArray.append(newItem)
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
