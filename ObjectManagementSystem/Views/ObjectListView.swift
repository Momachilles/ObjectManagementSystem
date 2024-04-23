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
  ObjectListView(searchString: .empty)
    .modelContainer(for: SaalObject.self, inMemory: true)
}
