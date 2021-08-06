import GRDB

struct UserRequest {
    enum Ordering {
        case byUsername
        case byId
    }
    
    var ordering: Ordering
}

extension UserRequest: Queryable {
    
    typealias Value = [User]
    
    static var defaultValue: [User] { [ ] }
    
    func fetchValue(_ db: Database) throws -> [User] {
        switch ordering {
            case .byId: return try User.all().orderByID().fetchAll(db)
            case .byUsername: return try User.all().orderedByUsername().fetchAll(db)
        }
    }
}
