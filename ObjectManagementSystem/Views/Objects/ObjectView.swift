//
//  ObjectView.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 23/4/24.
//

import SwiftUI
import SwiftData

struct ObjectView: View {
  
  var object: SaalObject
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(object.type + ": " + object.name)
          .font(.headline)
      }
      Text(object.objectDescription)
        .font(.caption2)
    }
  }
}

#Preview {
  do {
    let schema = Schema([SaalObject.self])
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: schema, configurations: config)
    let obj1 = SaalObject(name: "Obj1", description: "This is a first object", type: "Type1")
    
    return ObjectView(object: obj1)
      .modelContainer(container)
  } catch {
    fatalError("Failed to create model container.")
  }
}
