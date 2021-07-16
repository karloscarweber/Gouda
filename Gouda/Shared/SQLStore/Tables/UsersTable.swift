//
//  UsersTable.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import Combine
import GRDB
import Foundation

extension AppDatabase {
    
    enum UserValidationError: LocalizedError {
        case missingName
        case missingEmail
        
        var errorDescription: String? {
            switch self {
            case .missingName:
                return "Please provide a name"
            case .missingEmail:
                return "Please provide an email"
            }
        }
    }
    
    /**
     *  user()
     *  Gets the first database user
     */
    func user() throws -> User {
        var users: [User] = []
        try getdbWriter().read { db in
            users = try User.all().orderByPrimaryKey().fetchAll(db)
        }
        if users.count > 0  {
            return users[0]
        } else {
            throw DatabaseUserError.noUserFound
        }
    }
    
    func saveUser(_ user: inout User) throws {
        if user.email == nil {
            throw UserValidationError.missingEmail
        }
        try getdbWriter().write { db in
            try user.save(db)
        }
    }
    
    func deleteUsers(ids: [Int64]) throws {
        try getdbWriter().write { db in
            _ = try User.deleteAll(db, ids: ids)
        }
    }
    
    static let uiTestusers = [User(id: nil, firstName: "Karl", lastName: "Weber", username: "kow", email: "me@kow.fm", hasPlus: false, settings: nil, features: nil, createdAt: Date(), updatedAt: Date())]
    
    func createUsersForUITests() throws {
        try getdbWriter().write { db in
            try AppDatabase.uiTestusers.forEach { user in
                var mutableUser = user
                try mutableUser.save(db)
            }
        }
    }
    
}



enum DatabaseUserError: Error {
    case noUserFound
}
