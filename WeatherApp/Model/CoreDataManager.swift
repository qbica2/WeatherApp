//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Mehmet Kubilay Akdemir on 3.02.2023.
//

import CoreData
import UIKit


struct CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var idArray = [UUID]()
    var cityArray = [String]()
    
    mutating func fetchData(entityName: String) -> Bool {
        
        idArray.removeAll(keepingCapacity: false)
        cityArray.removeAll(keepingCapacity: false)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let cityName = data.value(forKey: "cityName") as? String {
                    cityArray.append(cityName)
                }
                if let id = data.value(forKey: "id") as? UUID {
                    idArray.append(id)
                }

            }
            return true
        } catch {
            print("error")
            return false
        }
    }
    
    func saveData (cityName: String, id: UUID, entityName: String) {
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName , into: context)
        object.setValue(cityName, forKey: "cityName")
        object.setValue(UUID(), forKey: "id")
        
        contextSave()
        
    }
    
    mutating func deleteSingleData(entityName: String, row: Int) -> Bool{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        let idString = idArray[row].uuidString
        
        request.predicate = NSPredicate(format: "id == %@", idString)
        
        do {
            
            let results = try context.fetch(request)
  
            if let result = results.first as? NSManagedObject {
                context.delete(result)
                idArray.remove(at: row)
                cityArray.remove(at: row)
                contextSave()
                return true
            }
            
        } catch {
            print("error")
            return false
        }
        return false
    }
    
    func contextSave(){
        do {
            try context.save()
        } catch {
            print("context save errror")
        }
    }
    
}


