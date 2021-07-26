//
//  PersistenceController.swift
//  HarryPotterApp
//
//  Created by Anton on 22.07.2021.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        // Create 10 example human.
        
        for index in 0..<10 {
            
            let human = Human(context: controller.container.viewContext)
            human.name = "Name\(index)"
            human.gender = "male"
        }
        return controller
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Stash")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(handler: @escaping (Error?) -> () = { _ in} ) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                handler(nil)
            } catch {
                handler(error)
            }
        }
    }
    
    func delete(object: NSManagedObject, handler: @escaping (Error?) -> () = { _ in}) {
        let context = container.viewContext
        context.delete(object)
        save(handler: handler)
    }
}
