//
//  ObjectView.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 23/4/24.
//

import SwiftUI

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
  ObjectView(object: SaalObject(name: "Obj1", description: "Description of obj1", type: "Type1"))
}
