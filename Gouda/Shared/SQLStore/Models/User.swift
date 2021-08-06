//
//  User.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

//User:
//```
//{
//    id: Int,
//    firstName: String,
//    lastName: String,
//    username: String,
//    email: String,
//    hasPlus: Bool,
//    settings: String,
//    features: String,
//
//    // standardized, every record has them.
//    createdAt: DateTime,
//    updatedAt: DateTime
//
//
//}
//```


import Foundation
import GRDB

struct User: Identifiable, Equatable {
    var id: Int64?
    var firstName: String?
    var lastName: String?
    var username: String?
    var email: String?
    var hasPlus: Bool?
    var settings: String?
    var features: String?
    
    var createdAt: Date
    var updatedAt: Date
    
    // This data is not in the API it's only local.
    var parentId: Int64? // this is the userID of the parent of this user. This is used when a user logs in to an outside account and we claim that user identity as our own. For example, if you have a cheddar account, it makes sense that when you log in to that account you treat it as your self. If you're a member of a team then the team's data would belong to the team user, and be saved there too. In that case parentId would be nil or empty, meaning that it doesn't belong to some other User for realsys.
    var storeId: Int64? // The ID of the store that this User belongs to. The default 'local' user belongs to the 'local' store. If you log in to an account from another store, then this id points to that store. This Helps to track where a User came from. Locally, there is only one user. With the store data we can then find a syncing policy attached to the user, and sync, or not sync in accordance with that.
    var isLocal: Bool = false // a simple boolean to see if this user is the local user. There can be only one, Like Highlander.
    
    // We should probably add what sort of permissions you have with a particular user attached to a store. Locally it doesnt' matter with your own data, but when dealing with shared data, it's best to adopt the permissions policies of the source store.
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case email
        case hasPlus = "has_plus"
        case settings
        case features
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case parentId = "parent_id"
        case storeId = "store_id"
        case isLocal = "is_local"
    }
    
}

extension User {
    static func new() -> User {
        User(id: nil, firstName: nil, lastName: nil, username: nil, email: "", hasPlus: false, settings: nil, features: nil, createdAt: Date(), updatedAt: Date())
    }
    
    // supply default data
    static func makeLocal() -> User {
        var me = new(); me.username = "local"; me.isLocal = true
        return me
    }
}

// MARK: - Persistence

/// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension User: Codable, FetchableRecord, MutablePersistableRecord {
    
    // Define database columsn from CodingKeys
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let firstName = Column(CodingKeys.firstName)
        static let last_name = Column(CodingKeys.lastName)
        static let username = Column(CodingKeys.username)
        static let email = Column(CodingKeys.email)
        static let has_plus = Column(CodingKeys.hasPlus)
        static let settings = Column(CodingKeys.settings)
        static let features = Column(CodingKeys.features)
        static let parent_id = Column(CodingKeys.parentId)
        static let store_id = Column(CodingKeys.storeId)
        static let is_local = Column(CodingKeys.isLocal)
        
        static let created_at = Column(CodingKeys.createdAt)
        static let updated_at = Column(CodingKeys.updatedAt)
    }
    
    // updates user id after it has been inserted in the database
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

// MARK: - User Database Requests

/// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
/// See https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md
extension DerivableRequest where RowDecoder == User {

    func orderedByUsername() -> Self {
        order(User.Columns.username.collating(.localizedCaseInsensitiveCompare))
    }
    
    func orderByID() -> Self {
        order(
            User.Columns.id.desc,
            User.Columns.username.collating(.localizedCaseInsensitiveCompare)
            )
    }
    
}
