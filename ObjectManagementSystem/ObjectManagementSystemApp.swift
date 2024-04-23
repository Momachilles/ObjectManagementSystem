//
//  ObjectManagementSystemApp.swift
//  ObjectManagementSystem
//
//  Created by David Alarcon on 22/4/24.
//

import SwiftUI
import SwiftData

@main
struct ObjectManagementSystemApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: SaalObject.self)
  }
}
