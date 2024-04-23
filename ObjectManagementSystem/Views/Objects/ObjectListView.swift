//
//  ObjectListView.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 22/4/24.
//

import SwiftUI
import SwiftData

struct ObjectListView: View {
  @Environment(\.modelContext) private var modelContext
  
  @Query private var objects: [SaalObject]
  
  init(searchString: String) {
    _objects = Query(filter: #Predicate<SaalObject> {
      if searchString.isEmpty {
        return true
      } else {
        return $0.name.localizedStandardContains(searchString) ||
        $0.objectDescription.localizedStandardContains(searchString) ||
        $0.type.localizedStandardContains(searchString)
      }
    })
  }
  
  var body: some View {
    List {
      ForEach(objects) { object in
        NavigationLink(value: object) {
          ObjectView(object: object)
        }
      }
      .onDelete(perform: deleteObject)
    }
  }
}

// MARK: - Model context management
extension ObjectListView {
  func deleteObject(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(objects[index])
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
      ObjectListView(searchString: .empty)
        .modelContainer(container)
    }
  } catch {
    fatalError("Failed to create model container.")
  }
}
