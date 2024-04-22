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
  
  @State private var path = [SaalObject]()
  
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
  ObjectListView()
    .modelContainer(for: SaalObject.self, inMemory: true)
}
