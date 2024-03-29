//
//  Store.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

import Foundation
import GRDB

struct Store: Identifiable, Equatable {
    var id: Int64?
    var url: String
    var name: String
    var passportUser: Int64? // This the ID of the User that connects to this store. To simplify, you can only log in to a Store as a single user. This stays in line with the goal of 1 identity for each user, but distributed data stores for your data. It also simplifies data access across stores.
    var remote: Bool = true // Defaults to true, only the local store is false
    var personal: Bool = false// (if you sync your personal stuff or not) If set to true you'll aoutomatically sync your all personal user stuff here too. Like a backup.
    
    var createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case passportUser = "passport_user"
        case remote
        case personal
        
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

extension Store {
    static func new() -> Store {
        Store(id: nil, url: "local", name: "local", passportUser: nil, createdAt: Date(), updatedAt: Date())
    }
    
    // supply default data
    static func defaultStores() -> [Store] {
        return [
            Store(id: nil, url: "local", name: "local", passportUser: nil, personal: true, createdAt: Date(), updatedAt: Date()),
            Store(id: nil, url: "https://api.cheddarapp.com", name: "Cheddar", passportUser: nil, personal: true, createdAt: Date(), updatedAt: Date()),
        ]
    }
}

// MARK: - Persistence

/// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Store: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let url = Column(CodingKeys.url)
        static let name = Column(CodingKeys.name)
        static let passport_user = Column(CodingKeys.passportUser)
        static let remote = Column(CodingKeys.remote)
        static let personal = Column(CodingKeys.personal)
        
        static let createdAt = Column(CodingKeys.createdAt)
        static let updatedAt = Column(CodingKeys.updatedAt)
    }
    
    // updates store id after it has been inserted in the database
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

// MARK: - Store Database Requests

/// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
/// See https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md
extension DerivableRequest where RowDecoder == Store {
    
}
