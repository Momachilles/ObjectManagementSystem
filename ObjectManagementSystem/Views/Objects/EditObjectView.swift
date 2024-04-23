//
//  EditObjectView.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 22/4/24.
//

import SwiftUI
import SwiftData

struct EditObjectView: View {
  @Environment(\.modelContext) private var modelContext
  
  @Bindable var object: SaalObject
  
  @Query private var objects: [SaalObject]

  @State private var isPresented = false
  
  /*
  init(object: SaalObject) {
    self.object = object
    
    let objId = self.object.persistentModelID
    let predicate = #Predicate<SaalObject> { obj in
      obj.persistentModelID != objId ||
      object.relations?.map { $0.persistentModelID }.contains(objId) ?? false
    }
    
    _objects = Query(filter: predicate)
  } */
  
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
      
      if let relations = object.relations {
        Section(content: {
          ForEach(relations) { object in
            ObjectView(object: object)
          }
          .onDelete(perform: deleteRelationship)
        }, header: {
          HStack {
            Text("Relationships")
            Spacer()
            Button {
              isPresented.toggle()
            } label: {
              Image(systemName: "plus")
            }
          }
        })
      }
    }
    .navigationTitle((object.name.isEmpty ? "Add" : "Edit") + " Object")
    .navigationBarTitleDisplayMode(.inline)
    .sheet(isPresented: $isPresented, content: {
      NavigationView {
        AddRelationshipView(objects: objects) { selectedObject in
          addRelationship(from: selectedObject)
          isPresented = false
        }
        .navigationTitle("Add Relationship")
      }
    })
  }
  
  func addRelationship(from relatedObject: SaalObject) {
    withAnimation {
      object.relations?.append(relatedObject)
    }
  }
  
  func deleteRelationship(offsets: IndexSet) {
    guard var relations = object.relations else { return }
    withAnimation {
      for index in offsets {
        let relatedObject = relations[index]
        if let relatedIndex = relatedObject.relations?.firstIndex(of: object) {
          relatedObject.relations?.remove(at: relatedIndex)
        }
        relations.remove(at: index)
      }
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
