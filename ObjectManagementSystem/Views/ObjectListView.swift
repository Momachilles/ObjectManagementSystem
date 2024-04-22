//
//  ObjectListView.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 22/4/24.
//

import SwiftUI
import SwiftData

struct ObjectListView: View {
  @Environment(\.modelContext) var modelContext
  @State private var path = [SaalObject]()
  
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
    NavigationStack(path: $path) {
      List {
        ForEach(objects) { object in
          NavigationLink(value: object) {
            VStack(alignment: .leading) {
              HStack {
                Text(object.type + ": " + object.name)
                .font(.title2)
              }
              Text(object.objectDescription)
                .font(.title3)
            }
          }
        }
        .onDelete(perform: deleteObject)
      }
      .navigationTitle("Objects")
      .navigationDestination(for: SaalObject.self, destination: EditObjectView.init)
      .toolbar {
        ToolbarItem {
          Button(action: addObject) {
            Label("Add Object", systemImage: "plus")
          }
        }
      }
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
  
  func addObject() {
    let object = SaalObject()
    modelContext.insert(object)
    path = [object]
  }
}

#Preview {
  ObjectListView(searchString: .empty)
    .modelContainer(for: SaalObject.self, inMemory: true)
}
