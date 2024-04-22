//
//  EditObjectView.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 22/4/24.
//

import SwiftUI
import SwiftData

struct EditObjectView: View {
  @Bindable var object: SaalObject
  
  var body: some View {
    Form {
      LabeledContent("Name") {
        TextField("Name", text: $object.name)
          .multilineTextAlignment(.trailing)
      }
      
      LabeledContent("Description") {
        TextField("Description", text: $object.objectDescription, axis: .vertical)
          .multilineTextAlignment(.trailing)
      }
      
      LabeledContent("Type") {
        TextField("Type", text: $object.type)
          .multilineTextAlignment(.trailing)
      }
      
      Section("Relationships") {
        ForEach(object.relations) { object in
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
    }
    .navigationTitle((object.name.isEmpty ? "Add" : "Edit") + " Object")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: addRelationship) {
          Label("Add Object", systemImage: "plus")
        }
      }
    }
  }
  
  func addRelationship() {
    withAnimation {
      let relationship = SaalObject(name: "Relation1", description: "Des1", type: "Typw1")
      object.relations.append(relationship)
    }
  }
}

#Preview {
  do {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: SaalObject.self, configurations: config)
    let obj1 = SaalObject(name: "Obj1", description: "This is a first object", type: "Type1")
    
    return EditObjectView(object: obj1)
      .modelContainer(container)
  } catch {
    fatalError("Failed to create model container.")
  }
}
