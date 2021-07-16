//
//  AccessToken.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

import Foundation
import GRDB

struct AccessToken: Identifiable, Equatable {
    var id: Int64?
    var token: String
    var storeId: Int64
    var userId: Int64
    
    var createdAt: Date
    var updatedAt: Date
}

extension AccessToken {
    static func new() -> AccessToken {
        AccessToken(id: nil, token: "gobbledygook", storeId: 0, userId: 0, createdAt: Date(), updatedAt: Date())
    }
}

// MARK: - Persistence

/// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension AccessToken: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columsn from CodingKeys
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let token = Column(CodingKeys.token)
        static let storeId = Column(CodingKeys.storeId)
        static let userId = Column(CodingKeys.userId)
        
        static let createdAt = Column(CodingKeys.createdAt)
        static let updatedAt = Column(CodingKeys.updatedAt)
    }
    
    // updates store id after it has been inserted in the database
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

// MARK: - AccessToken Database Requests

/// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
/// See https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md
extension DerivableRequest where RowDecoder == AccessToken {
    
}
