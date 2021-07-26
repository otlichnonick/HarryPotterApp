//
//  HarryPotterAppApp.swift
//  HarryPotterApp
//
//  Created by Anton on 21.07.2021.
//

import SwiftUI

@main
struct HarryPotterAppApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
