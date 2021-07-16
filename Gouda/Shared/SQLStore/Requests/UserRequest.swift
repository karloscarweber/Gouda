import GRDB

struct UserReqeust {
    enum Ordering {
        case byUsername
        case byId
    }
    
    var ordering: Ordering
}

extension UserReqeust: Queryable {
    static var defaultValue: [User] { [ ] }
    
    func fetchValue(_ db: Database) throws -> [User] {
        switch ordering {
        case .byId: return try User.all().orderByID().fetchAll(db)
        case .byUsername: return try User.all().orderedByUsername().fetchAll(db)
        }
    }
}
