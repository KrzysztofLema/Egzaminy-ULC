import CoreData
import Dependencies
import Helpers

extension DependencyValues {
    var storageProvider: StorageProvider {
        get { self[StorageProvider.self] }
        set { self[StorageProvider.self] = newValue }
    }
}

struct StorageProvider {
    var container: () throws -> NSPersistentContainer
    var context: () throws -> NSManagedObjectContext
    var backgroundContext: () throws -> NSManagedObjectContext
    var save: () -> Void
}

private let persistentContainer: NSPersistentContainer = {
    let bundle = Bundle.module
    let model = bundle
        .url(forResource: "ExamULC", withExtension: "momd")
        // swiftlint:disable:next force_unwrapping
        .flatMap { NSManagedObjectModel(contentsOf: $0) }!

    let persistentContainer = NSPersistentContainer(name: "ExamULC", managedObjectModel: model)
    // swiftlint:disable:next force_unwrapping
    let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let storeName = "DataStore-\(PlistConfiguration.App.currentSchemeName).sqlite"
    let storeDescription = NSPersistentStoreDescription(url: storeURL.appendingPathComponent(storeName))

    persistentContainer.persistentStoreDescriptions = [storeDescription]

    persistentContainer.loadPersistentStores(completionHandler: { _, error in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

    return persistentContainer
}()

extension StorageProvider: DependencyKey {
    static var liveValue: StorageProvider = Self {
        persistentContainer
    } context: {
        persistentContainer.viewContext
    } backgroundContext: {
        persistentContainer.newBackgroundContext()
    } save: {
        let context = persistentContainer.viewContext
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch {
            context.rollback()
            fatalError("""
              \(#file), \
              \(#function), \
              \(error.localizedDescription)
            """)
        }
    }
}
