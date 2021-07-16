//
//  UserModel.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import Foundation
import SwiftUI

struct UserModel: Hashable, Codable, Identifiable {
    
    var id: Int64?
    var firstName: String?
    var lastName: String?
    var username: String?
    var email: String?
    var settings: String?
    var features: String?
    var remote_id: Int64
    var created_at: String
    var updated_at: String
    var url: String
    var has_plus: Bool
  //  var socket: SocketModel
    
  static func == (lhs: UserModel, rhs: UserModel) -> Bool {
    if lhs.id == rhs.id &&
      lhs.remote_id == rhs.remote_id &&
      lhs.created_at == rhs.created_at &&
      lhs.updated_at == rhs.updated_at &&
      lhs.url == rhs.url &&
      lhs.username == rhs.username &&
      lhs.has_plus == rhs.has_plus // &&
//      lhs.socket == rhs.socket
    {
     return true
    }
    return false
  }
    
    mutating func updateFrom(user: User) {
        id = user.id
        username = user.username ?? ""
        created_at = dateFormatter.string(from: user.createdAt)
        updated_at = dateFormatter.string(from: user.updatedAt)
        
    }

}

//struct SocketModel: Codable, Hashable {
//  var api_key: String
//  var app_id: Int
//  var auth_url: String
//  var channel: String
//}

