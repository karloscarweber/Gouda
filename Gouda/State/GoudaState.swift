//
//  GoudaState.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

/*
 Gouda State is the state machine for this app. The Global, VIEW MODEL, if you will.
 Views and data are added and removed from Gouda State to change the presentation of
 the app. Persistence is achieved between the Cheddar Store, and the Gouda Store.
 Gouda Store persists app specific data, Cheddar Store persists Cheddar data locally.
 */

import UIKit
import SwiftUI


class GoudaState: ObservableObject {
  @Published var lists: [ListModel]
  @Published var tasks: [TaskModel]
  @Published var tasksInList: [TasksForList]
}
