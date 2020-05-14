//
//  TaskExtension.swift
//  CoreDataEssential
//
//  Created by Muhammad Fawwaz Mayda on 14/05/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    func getViewContext() -> NSManagedObjectContext? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        return container?.viewContext
    }
}

//Task is coming from Entity Task
extension Task {
    
    static func fetchAll(viewContext: NSManagedObjectContext)-> [Task] {
        let request : NSFetchRequest<Task> = Task.fetchRequest()
        guard let res = try? viewContext.fetch(request) else { fatalError("Not Res") }
        return res
    }
    
    static func save(viewContext : NSManagedObjectContext, taskName : String) -> Task? {
        let newTask = Task(context: viewContext)
        newTask.taskName = taskName
        do {
            try viewContext.save()
            return newTask
        } catch {
            return nil
        }
    }
    
    static func deleteAll(viewContext : NSManagedObjectContext) {
        let tasks = fetchAll(viewContext: viewContext)
        for task in tasks {
            self.delete(viewContext: viewContext, taskToBeDeleted: task)
        }
    }
    
    static func delete(viewContext : NSManagedObjectContext, taskToBeDeleted : Task) {
         print("\(String(describing: taskToBeDeleted.taskName)) is deleted")
        viewContext.delete(taskToBeDeleted)
        do {
            try viewContext.save()
        } catch {
            print("Erro deleting")
        }
    }
    
}
//SubTask is coming from Entity Task
extension SubTask {
    
}

