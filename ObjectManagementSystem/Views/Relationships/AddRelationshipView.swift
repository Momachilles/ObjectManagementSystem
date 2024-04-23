//
//  AddRelationshipView.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 23/4/24.
//

import SwiftUI
import SwiftData

struct AddRelationshipView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var objects: [SaalObject] // Replace String with your object type
  
  let object: SaalObject
  let didSelectObject: ((SaalObject) -> Void)?
  
  init(to object: SaalObject, didSelectObject: ((SaalObject) -> Void)? = .none) {
    self.object = object
    self.didSelectObject = didSelectObject
    
    let objId = object.persistentModelID
    if let relations = object.relations {
      let relationIds = relations.map { $0.persistentModelID }
      let predicate = #Predicate<SaalObject> { obj in
        !relationIds.contains(obj.persistentModelID) && obj.persistentModelID != objId
      }
      
      _objects = Query(filter: predicate)
    } else {
      let predicate = #Predicate<SaalObject> { obj in
        obj.persistentModelID != objId
      }
      
      _objects = Query(filter: predicate)
    }
  }
  
  var body: some View {
    List {
      ForEach(objects) { object in
        Button(action: {
          didSelectObject?(object)
        }) {
          ObjectView(object: object)
        }
        .buttonStyle(PlainButtonStyle())
      }
    }
  }
}

#Preview {
  AddRelationshipView(to: SaalObject())
}
