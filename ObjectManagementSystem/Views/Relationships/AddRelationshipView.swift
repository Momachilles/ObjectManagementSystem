//
//  AddRelationshipView.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 23/4/24.
//

import SwiftUI

struct AddRelationshipView: View {
  let objects: [SaalObject] // Replace String with your object type
  let didSelectObject: ((SaalObject) -> Void)?
  
  var body: some View {
    List {
      ForEach(objects) { object in
        Button(action: {
          didSelectObject?(object)
        }) {
          ObjectView(object: object)
        }
        .buttonStyle(PlainButtonStyle())
      }
    }
  }
}

#Preview {
  AddRelationshipView(objects: [], didSelectObject: .none)
}
