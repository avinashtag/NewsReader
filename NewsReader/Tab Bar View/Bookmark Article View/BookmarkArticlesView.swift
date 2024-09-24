//
//  BookmarkArticlesView.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import SwiftUI
import SwiftData

struct BookmarkArticlesView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var bookmarkArticles: [BookmarkArticle]
    @Binding var navigationPath: NavigationPath

    var body: some View {
        List{
            Section {
                ForEach(bookmarkArticles, id: \.self) { article in
                    
                    NewsFeedCell(article: Binding(get: {article.parse()}, set: { _ in }), isBookmark: Binding(get: { true }, set: { _ in
                        modelContext.delete(article)
                    }), didSelect: {
                        navigationPath.append(article)
                    })

                }
            } header: {
                HStack{
                    Text("Bookmark Articals")
                        .font(.title3)
                    Spacer()
                }
            }
        }
        .navigationTitle(Text("Bookmark"))
        .navigationDestination(for: BookmarkArticle.self) { article in
            NewsReaderView(article: Binding(get: {article.parse()}, set: { _ in }), isBookmark: Binding(get: { true }, set: { _ in
                modelContext.delete(article)
            }), dismissAfterbookmark: true)
        }

    }
}

#Preview {
    BookmarkArticlesView( navigationPath: Binding(get: {NavigationPath()}, set: {_ in }))
}
