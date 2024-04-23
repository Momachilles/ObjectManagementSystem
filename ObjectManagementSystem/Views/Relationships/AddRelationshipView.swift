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
  @Query private var objects: [SaalObject]
  
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
          HStack {
            ObjectView(object: object)
            Spacer()
          }
          .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle()) // Remove button default style
      }
    }
  }
}

#Preview {
  do {
    let schema = Schema([SaalObject.self])
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: schema, configurations: config)
    let obj1 = SaalObject(name: "Obj1", description: "This is a first object", type: "Type1")
    let obj2 = SaalObject(name: "Obj2", description: "This is a second object", type: "Type2")
    container.mainContext.insert(obj1)
    container.mainContext.insert(obj2)
    
    return NavigationStack {
      AddRelationshipView(to: obj2)
        .modelContainer(container)
    }
  } catch {
    fatalError("Failed to create model container.")
  }
}
