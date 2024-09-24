//
//  NewsReaderApp.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import SwiftUI
import SwiftData

@main
struct NewsReaderApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([ BookmarkArticle.self, ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .modelContainer(sharedModelContainer)
    }
}
