//
//  ManagedObjectContext.swift
//  Gouda
//
//  Created by Karl Oscar Weber.
//

// This extension is borrowed from the esteemable Donny Wals (https://www.donnywals.com)


import CoreData

extension NSManagedObjectContext {
  func saveOrRollback() {
    guard hasChanges else {
      return
    }
    
    do {
      try save()
    } catch {
      rollback()
      print(error)
    }
  }
}
