//
//  AppDatabase.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

import Combine
import GRDB
import Foundation

// AppDatabase lets the applicaiton access the database
//

struct AppDatabase {
    // Creates an `AppDatabase`, and makes certain the database schema is ready.
    init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    // provides access to the database.
    private let dbWriter: DatabaseWriter
    var dbPool: DatabaseWriter {
        get {
            return dbWriter
        }
        set {
            // you literally cannot set it
        }
    }
    
    func getdbWriter() -> DatabaseWriter {
        return self.dbWriter
    }
    
    // The DatbaseMigrator that defines the database schema.
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        // Speed up development by nuking the database when migrations change
        // See https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md#the-erasedatabaseonschemachange-option
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        migrator.eraseDatabaseOnSchemaChange = true
        
        // make User table
        migrator.registerMigration("createTables") { db in
            // Create a table
            // See https://github.com/groue/GRDB.swift#create-tables

            // first create the store
            try db.create(table: "store") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("url", .text)
                t.column("name", .text).defaults(to: "")
                t.column("passport_user", .integer)
                t.column("remote", .boolean).notNull().defaults(to: false)
                t.column("personal", .boolean).notNull().defaults(to: false)

                t.column("created_at", .datetime)
                t.column("updated_at", .datetime)
            }
            
            try db.create(table: "user") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("first_name", .text)
                t.column("last_name", .text)
                t.column("username", .text)
                t.column("email", .text)
                t.column("has_plus", .boolean).notNull().defaults(to: false)
                t.column("settings", .text)
                t.column("features", .text)
                
                t.column("created_at", .datetime)
                t.column("updated_at", .datetime)
                
                t.column("parent_id", .integer)
                t.column("store_id", .integer)
                t.column("is_local", .boolean).notNull().defaults(to: false)
            }
            
//
//            try db.create(table: "token") { t in
//                t.autoIncrementedPrimaryKey("id")
//                t.column("storeId", .integer)
//                    .notNull()
//                    .indexed()
//                    .references("store", onDelete: .cascade)
//
//                t.column("userId", .integer)
//                    .notNull()
//                    .indexed()
//                    .references("user", onDelete: .cascade)
//
//                t.column("created_at", .datetime)
//                t.column("updated_at", .datetime)
//            }
//
//            try db.create(table: "task") { t in
//                t.autoIncrementedPrimaryKey("id")
//                t.column("text", .text).notNull().defaults(to: "What do you need to do today?")
//                t.column("displayText", .text).notNull().defaults(to: "What do you need to do today?")
//                t.column("completedAt", .datetime)
//                t.column("archivedAt", .datetime)
//                t.column("entities", .text)
//
//                t.column("createdAt", .datetime)
//                t.column("updatedAt", .datetime)
//            }
//
//            try db.create(table: "list") { t in
//                t.autoIncrementedPrimaryKey("id")
//                t.column("userId", .integer)
//                    .notNull()
//                    .indexed()
//                    .references("user", onDelete: .cascade)
//                t.column("title", .text).notNull()
//                t.column("archivedAt", .datetime)
//                t.column("public", .boolean).notNull().defaults(to: false)
//
//                t.column("createdAt", .datetime)
//                t.column("updatedAt", .datetime)
//            }
//
//            try db.create(table: "listsUsersPosition") { t in
//                t.autoIncrementedPrimaryKey("id")
//                t.column("listId", .integer)
//                    .notNull()
//                    .indexed()
//                    .references("list", onDelete: .cascade)
//                t.column("userId", .integer)
//                    .notNull()
//                    .indexed()
//                    .references("user", onDelete: .cascade)
//                t.column("position", .integer).notNull().defaults(to: 1000)
//            }
//
//            try db.create(table: "listsTasksPosition") { t in
//                t.autoIncrementedPrimaryKey("id")
//                t.column("listId", .integer)
//                    .notNull()
//                    .indexed()
//                    .references("list", onDelete: .cascade)
//                t.column("taskId", .integer)
//                    .notNull()
//                    .indexed()
//                    .references("task", onDelete: .cascade)
//                t.column("position", .integer).notNull().defaults(to: 1)
//            }
  
            // not sure where this should go but won't delete.
//            /// default date stuff
//            let now = Date()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
//            let datetime = formatter.string(from: now)
        }
        
        // Migrations for future application versions will be inserted here:
        // migrator.registerMigration(...) { db in
        //     ...
        // }
        
        return migrator
    }
}

// MARK: - Database Access: Writes
extension AppDatabase {
    
    enum ValidationError: LocalizedError {
        case missingName
        
        var errorDescription: String? {
            switch self {
            case .missingName:
                return "Please provide a name"
            }
        }
    }
    
    func seedDataIfEmpty() throws {
        try dbWriter.write { db in
            
            // Seed default stores
            if try Store.fetchCount(db) == 0 {
                print("try createLocalStore()")
                try createLocalStore(db)
            }
            
            // Seed default User
            if try User.fetchCount(db) == 0 {
                print("try createLocalUser()")
                try createLocalUser(db)
            }
        }
    }
    
    /**
     *  createLocalStore
     *
     *  Seeds the local database with the default stores, Local, and https://api.cheddarapp.com.
     *
     */
    func createLocalStore(_ db: Database) throws {
        let stores = Store.defaultStores()
        for var store in stores {
            try store.insert(db)
        }
    }
    
    /**
     *  createLocalUser
     *
     *  Seeds the local database with the local user, who is just local, and is always the user.
     *
     */
    func createLocalUser(_ db: Database) throws {
        var user = User.makeLocal()
        try user.insert(db)
    }
    
}


// MARK: - Database Access: Reads
extension AppDatabase {
    var databaseReader: DatabaseReader {
        dbWriter
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    // standard ISO 8601
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
