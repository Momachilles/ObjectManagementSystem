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
  var name: String
  var objectDescription: String
  var type: String
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
