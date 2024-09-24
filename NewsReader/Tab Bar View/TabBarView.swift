//
//  TabBarView.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var navigationNewsFeedPath: NavigationPath = NavigationPath()
    @State private var navigationBookmarkPath: NavigationPath = NavigationPath()

    var body: some View {
        TabView {
            NavigationStack(path: $navigationNewsFeedPath) {
                NewsFeedView( navigationPath: $navigationNewsFeedPath)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                VStack {
                    Image(systemName: "newspaper")
                        .font(.system(size: 22))
                        .accessibilityIdentifier(TabBarViewAccesbilities.newspaperTabImage.rawValue)
                    Text("News Feed")
                        .accessibilityIdentifier(TabBarViewAccesbilities.newspaperTabText.rawValue)
                }
                .accessibilityIdentifier(TabBarViewAccesbilities.newspaperTab.rawValue)
            }
            .accessibilityIdentifier(TabBarViewAccesbilities.newspaperTabNav.rawValue)

            NavigationStack(path: $navigationBookmarkPath) {
                BookmarkArticlesView( navigationPath: $navigationBookmarkPath)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                VStack{
                    Image(systemName: "bookmark.fill")
                        .font(.system(size: 22))
                        .accessibilityIdentifier(TabBarViewAccesbilities.bookmarkTabImage.rawValue)
                    Text("Bookmark")
                        .accessibilityIdentifier(TabBarViewAccesbilities.bookmarkTabText.rawValue)
                }
                .accessibilityIdentifier(TabBarViewAccesbilities.bookmarkTab.rawValue)
            }
            .accessibilityIdentifier(TabBarViewAccesbilities.bookmarkTabNav.rawValue)

        }
        .accessibilityIdentifier(TabBarViewAccesbilities.tabBar.rawValue)
    }
}

#Preview {
    TabBarView()
}

enum TabBarViewAccesbilities: String{
    case tabBar = "TabBar"
    case newspaperTabNav = "newspaperTabNav"
    case newspaperTab = "newspaperTab"
    case newspaperTabImage = "newspaperTabImage"
    case newspaperTabText = "newspaperTabText"
    case bookmarkTab = "bookmarKTab"
    case bookmarkTabImage = "bookmarKTabImage"
    case bookmarkTabText = "bookmarKTabText"
    case bookmarkTabNav = "bookmarKTabNav"
}
