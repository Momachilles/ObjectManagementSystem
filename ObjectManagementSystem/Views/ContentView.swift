//
//  ContentView.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 22/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  
  @State private var path = [SaalObject]()
  @State private var searchText = String.empty
  
  var body: some View {
    NavigationStack(path: $path) {
      ObjectListView(searchString: searchText)
        .navigationTitle("Objects")
        .navigationDestination(for: SaalObject.self, destination: EditObjectView.init)
        .searchable(text: $searchText)
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
extension ContentView {
  func addObject() {
    let object = SaalObject()
    modelContext.insert(object)
    path = [object]
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
