//
//  CoreDataService.swift
//  SportsApp
//
//  Created by Andrew Emad on 02/02/2025.
//

import Foundation
import CoreData
import UIKit


class CoreDataService{
    static func saveData(data : CoreDataModel){
       
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manager: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            // entity
        
            let leaugeEntity = NSEntityDescription.entity(forEntityName: "LeaugeData", in: manager)
            let leaugeDB = NSManagedObject(entity: leaugeEntity!, insertInto: manager)
            
            leaugeDB.setValue(data.id, forKey: "id")
            leaugeDB.setValue(data.logo, forKey: "logo")
            leaugeDB.setValue(data.name, forKey: "name")
            do{
                try manager.save()
               
            }catch let error{
                print(error)
            }
        print("data saved succseesfully")
    }
    static func removeData(data : CoreDataModel){
        let appdelegate = UIApplication.shared.delegate as!AppDelegate
        let managedContext=appdelegate.persistentContainer.viewContext
        let coordinator = managedContext.persistentStoreCoordinator
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeaugeData")
        var tempId : NSNumber
        tempId=data.id! as NSNumber
        let predicate = NSPredicate(format: "id == %@", tempId)
        fetchRequest.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try coordinator?.execute(deleteRequest, with: managedContext)
           
        }catch let error{
            print(error)
        }
        print("data removed succseesfully")
    }
    static func loadData()->[CoreDataModel]?{
        var coreDataList : [CoreDataModel]=[]
        var managedLeauges:[NSManagedObject]
        let appdelegate = UIApplication.shared.delegate as!AppDelegate
        let managedContext=appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeaugeData")
        do{
            managedLeauges = try managedContext.fetch(fetchRequest)
            for i in managedLeauges{
                var tempLeauge = CoreDataModel()
                tempLeauge.id = i.value(forKey: "id") as? Int64
                tempLeauge.logo = i.value(forKey: "logo") as? String
                tempLeauge.name = i.value(forKey: "name") as? String
                coreDataList.append(tempLeauge)
            }
        }catch let error as NSError{
            print(error)
        }
        print("data loaded succseesfully")
        return coreDataList
    }
}
