//
//  UserView.swift
//  Gouda
//
//  Created by Karl Weber on 7/31/21.
//

import SwiftUI

struct UserView: View {
    
    @Environment(\.goudaState) private var goudaState
    
    @Query(UserRequest(ordering: .byId)) private var user: [User]
    
    var body: some View {
        Text("Hello, World!, \(user[0].username!)")
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
