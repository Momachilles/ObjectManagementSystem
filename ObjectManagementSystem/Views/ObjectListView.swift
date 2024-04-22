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
  
  @Query private var objects: [SaalObject]
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(objects) { object in
          VStack(alignment: .leading) {
            HStack {
              Text(object.type + ": " + object.name)
              .font(.title2)
            }
            Text(object.objectDescription)
              .font(.title3)
          }
        }
        .onDelete(perform: deleteObject)
      }
      .navigationTitle("Objects")
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
  func addObject() {
    withAnimation {
      let obj1 = SaalObject(name: "Objc1", description: "This is a first object", type: "Type1")
      let obj2 = SaalObject(name: "Objc2", description: "This is a second object", type: "Type2")
      let obj3 = SaalObject(name: "Objc3", description: "This is a third object", type: "Type3")
      
      modelContext.insert(obj1)
      modelContext.insert(obj2)
      modelContext.insert(obj3)
    }
  }
  
  func deleteObject(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(objects[index])
      }
    }
  }
}

#Preview {
  ObjectListView()
    .modelContainer(for: SaalObject.self, inMemory: true)
}
