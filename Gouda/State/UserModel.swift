//
//  UserModel.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//


import Foundation
import SwiftUI

struct UserModel: Hashable, Codable, Identifiable {
  static func == (lhs: UserModel, rhs: UserModel) -> Bool {
    if lhs.id == rhs.id &&
      lhs.created_at == rhs.created_at &&
      lhs.updated_at == rhs.updated_at &&
      lhs.url == rhs.url &&
      lhs.username == rhs.username &&
      lhs.has_plus == rhs.has_plus &&
      lhs.socket == rhs.socket {
     return true
    }
    return false
  }
  
  var id: UUID?
  var created_at: String
  var updated_at: String
  
  var url: String
  
  var username: String
  var has_plus: Bool
  
  var socket: SocketModel
}

struct SocketModel: Codable, Hashable {
  var api_key: String
  var app_id: Int
  var auth_url: String
  var channel: String
}
