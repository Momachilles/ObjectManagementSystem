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
  /*
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      SaalObject.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }() */
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    // .modelContainer(sharedModelContainer)
    .modelContainer(for: SaalObject.self)
  }
}
