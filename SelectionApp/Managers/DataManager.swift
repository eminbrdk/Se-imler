//
//  DataManager.swift
//  Selection
//
//  Created by Muhammed Emin Bardakcı on 17.05.2023.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save() {
        do {
            try context.save()
        } catch {
            print("update user name hatası")
        }
    }
    
    func getAllChestsData() -> [Chest] {
        do {
            let chests = try context.fetch(Chest.fetchRequest())
            return chests
        } catch {
            return [Chest]()
        }
    }
    
    func createChest(number: String) {
        let newChest = Chest(context: self.context)
        newChest.chestNumber = number
        newChest.kkCount = 0
        newChest.rteCount = 0

        do {
            try self.context.save()
        } catch {
            print("create user hatası")
        }
    }
    
    func deleteChest(chest: Chest) {
        context.delete(chest)
    }
}
