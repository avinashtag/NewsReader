//
//  NewsFeedView.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import SwiftUI
import SwiftData
import AlertToast


enum SideTab: String, CaseIterable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}


struct NewsFeedView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var bookmarkArticles: [BookmarkArticle]

    @Binding var navigationPath: NavigationPath 

    @State private var selectedTab: Int = 0
    @State private var sidetabs: [SideTab] = [.general, .business, .entertainment, .health, .science, .technology, .sports]
    @State private var newsFeedRequest: NewsFeedRequest = NewsFeedRequest(category: nil, page: 1)
    @State private var articles: [Article] = []
    @State private var error: NewsViewError = NewsViewError(showError: false, message: "")

    var body: some View {
        VStack{
            SegmentedControlView(selectedIndex: Binding(get: {selectedTab}, set: { value in
                selectedTab = value
                newsFeedRequest.category = sidetabs[selectedTab].rawValue
                Task { await fetchNewsFeed()}
            }), titles:  sidetabs.compactMap({$0.rawValue.capitalized}))
            .padding(.horizontal, 15)
            .frame(width: UIScreen.main.bounds.width)
            .accessibilityIdentifier(NewsFeedViewAccesbilities.topCategory.rawValue)

            List{
                Section {
                    ForEach($articles, id: \.self) { article in
                        
                        NewsFeedCell(article: article,  isBookmark: Binding(get: {
                            bookmarkArticles.contains(where: {$0.url == article.wrappedValue.url})
                        }, set: { newvalue in
                            article.wrappedValue.bookmark(newvalue, modelContext: modelContext)
                        }), didSelect: {
                            navigationPath.append(article.wrappedValue)
                        })
                    }
                } header: {
                    HStack{
                        Text("Top Stories")
                            .font(.title3)
                        Spacer()
                    }
                }
            }
            .accessibilityIdentifier(NewsFeedViewAccesbilities.topHeadlineList.rawValue)
            Spacer()
        }
        .navigationDestination(for: Article.self) { article in
            NewsReaderView(article: Binding(get: {article}, set: { _ in }), isBookmark: Binding(get: { bookmarkArticles.contains(where: {$0.url == article.url}) }, set: { newvalue in
                article.bookmark(newvalue, modelContext: modelContext)
            }), dismissAfterbookmark: false)
        }
        .navigationTitle(Text("News Articles"))
        .refreshable {
            Task { await fetchNewsFeed()}
        }
        .task {
            await fetchNewsFeed()
        }
        .error(isPresenting: $error.showError, message: error.message)
    }
}

extension NewsFeedView{
    private func fetchNewsFeed() async{
        do {
            let response = try await self.newsFeedRequest.load()
            newsFeedRequest.availablePages = Int64(response.totalResults/newsFeedRequest.pagesize)
            articles = response.articles
        }
        catch{
            self.error.message = error.localizedDescription
            self.error.showError = true
        }
    }
}

#Preview {
    NewsFeedView( navigationPath: Binding(get: {NavigationPath()}, set: {_ in }))
}

enum NewsFeedViewAccesbilities: String{
    case topCategory = "topCategory"
    case topHeadlineList = "topheadlineList"
    case topHeadlineSection = "topHeadlineSection"
}
