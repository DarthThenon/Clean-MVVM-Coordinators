//
//  DataBaseService.swift
//  CoreDataTesting
//
//  Created by Dmitriy Yurchenko on 24.01.2021.
//

import Foundation
import CoreData

protocol DatabaseServiceProtocol: AnyObject {
    func write(_ block: @escaping (NSManagedObjectContext) -> Void)
    func readInBackground(_ block: @escaping (NSManagedObjectContext) -> Void)
    func batchDelete(fetchRequest: NSFetchRequest<NSFetchRequestResult>)
}

final class DatabaseService: DatabaseServiceProtocol {
    private(set) lazy var uiMoc: NSManagedObjectContext = makeUIMoc()
    private lazy var writeMoc: NSManagedObjectContext = makeWriteMoc()
    private lazy var workMoc: NSManagedObjectContext = makeWorkMoc()
    
    private lazy var persistentContainer: NSPersistentContainer = {
       makePersistentContainer()
    }()
    private let modelName: String
    private let inMemory: Bool
    
    init(modelName: String = Bundle.main.infoDictionary!["CFBundleName"] as! String, inMemory: Bool = false) {
        self.modelName = modelName
        self.inMemory = inMemory
    }
    
    func write(_ block: @escaping (NSManagedObjectContext) -> Void) {
        writeMoc.perform { [weak self] in
            guard let self = self else { return }
            
            block(self.writeMoc)
            
            guard self.writeMoc.hasChanges else { return }
            
            do {
                try self.writeMoc.save()
            } catch {
                print("⛔️ \(error.localizedDescription)")
            }
        }
    }
    
    func readInBackground(_ block: @escaping (NSManagedObjectContext) -> Void) {
        workMoc.perform { [weak self] in
            guard let self = self else { return }
            
            block(self.workMoc)
        }
    }
    
    func batchDelete(fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        write { [unowned self] moc in
            let batchDelete = try? moc.execute(batchDeleteRequest) as? NSBatchDeleteResult

            guard let deleteResult = batchDelete?.result as? [NSManagedObjectID]
            else { return }

            let deletedObjects: [AnyHashable: Any] = [
                NSDeletedObjectsKey: deleteResult
            ]
            
            NSManagedObjectContext.mergeChanges(
                fromRemoteContextSave: deletedObjects,
                into: [writeMoc, uiMoc, workMoc]
            )
            
            print("⚠️ \(deleteResult.count) items were deleted")
        }
    }
    
    func deleteDatabase() {
        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        
        persistentStoreCoordinator.persistentStores.forEach {
            try? persistentStoreCoordinator.destroyPersistentStore(at: $0.url!, ofType: $0.type, options: nil)
        }
        
        persistentContainer = makePersistentContainer(onConfigured: { [unowned self] in
            writeMoc = makeWriteMoc()
            uiMoc = makeUIMoc()
            workMoc = makeWorkMoc()
        })
    }
}

private extension DatabaseService {
    func makeUIMoc() -> NSManagedObjectContext {
        makeMoc(concurrencyType: .mainQueueConcurrencyType, parent: writeMoc)
    }
    
    func makeWriteMoc() -> NSManagedObjectContext {
        let moc = makeMoc(concurrencyType: .privateQueueConcurrencyType, parent: nil)
        
        moc.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        
        return moc
    }
    
    func makeWorkMoc() -> NSManagedObjectContext {
        makeMoc(concurrencyType: .privateQueueConcurrencyType, parent: uiMoc)
    }
    
    func makeMoc(concurrencyType: NSManagedObjectContextConcurrencyType, parent: NSManagedObjectContext?) -> NSManagedObjectContext {
        let moc = NSManagedObjectContext(concurrencyType: concurrencyType)
        
        parent.flatMap {
            moc.parent = $0
        }
        moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        moc.automaticallyMergesChangesFromParent = true
        
        return moc
    }
    
    func makePersistentContainer(onConfigured: (() -> Void)? = nil) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: modelName)
        
        configureDescriptions(ofPersistentContainer: container)
        
        container.loadPersistentStores { (desc, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                assertionFailure(error.localizedDescription)
            } else {
                print("✅ \(desc.description) store has been loaded")
                
                onConfigured?()
            }
        }
        
        return container
    }
    
    func configureDescriptions(ofPersistentContainer container: NSPersistentContainer) {
        if inMemory {
            container.persistentStoreDescriptions = [makeInMemoryStoreDescription()]
        } else {
            container.persistentStoreDescriptions.append(makeDefaultStoreDescription())
        }
    }
    
    func makeInMemoryStoreDescription() -> NSPersistentStoreDescription {
        let description = NSPersistentStoreDescription()
        
        description.type = NSInMemoryStoreType
        
        return description
    }
    
    func makeDefaultStoreDescription() -> NSPersistentStoreDescription {
        NSPersistentStoreDescription()
    }
}
