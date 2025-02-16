//
//  ProjectApp.swift
//  Project
//
//  Created by Shashwath Dinesh on 2/15/25.
//

import SwiftUI

@main
struct ProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
