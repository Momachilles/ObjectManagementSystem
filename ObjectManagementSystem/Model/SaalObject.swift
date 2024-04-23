//
//  SaalObject.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 22/4/24.
//

import Foundation
import SwiftData

@Model
final class SaalObject {
  var name: String = String.empty
  var objectDescription: String = String.empty
  var type: String = String.empty
  var relations: [SaalObject]?

  init(name: String = .empty, description: String = .empty, type: String = .empty) {
    self.name = name
    self.objectDescription = description
    self.type = type
  }
}

extension String {
  static var empty: Self { "" }
}
