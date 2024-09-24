//
//  NewsReaderView.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import SwiftUI

struct NewsReaderView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @Binding var article: Article
    @Binding var isBookmark: Bool
    @State var dismissAfterbookmark: Bool
    @State private var navigateToSafari: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading,  spacing: 10, content: {
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: UIScreen.main.bounds.width - 30 , height: (UIScreen.main.bounds.width - 30) * (9/16))
                .accessibilityIdentifier(NewsReaderViewAccesibility.newsFeedImage.rawValue)

                Divider()
                HStack(alignment: .top, content: {
                    Text(article.title ?? "")
                        .font(.title)
                        .accessibilityIdentifier(NewsReaderViewAccesibility.newsFeedTitle.rawValue)
                })
                
                Text(article.author ?? "")
                    .font(.title3)
                    .accessibilityIdentifier(NewsReaderViewAccesibility.newsFeedAuthor.rawValue)

                
                Text("\(article.publishedAt?.conversion(date: true, time: true, doesRelativeDateFormatting: true) ?? "")")
                    .font(.caption)
                    .padding(.top, 5)
                    .accessibilityIdentifier(NewsReaderViewAccesibility.newsFeedDate.rawValue)

                Text(article.description ?? "")
                    .font(.body)
                    .padding(.top, 5)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityIdentifier(NewsReaderViewAccesibility.newsFeedDescription.rawValue)

                Spacer()
                Button {
                    navigateToSafari.toggle()
                } label: {
                    Text("Read More")
                }
                .buttonStyle(ReadMore())
                .accessibilityIdentifier(NewsReaderViewAccesibility.newsFeedReadMore.rawValue)

            })
        }
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    isBookmark.toggle()

                    if dismissAfterbookmark{
                        dismiss()
                    }
                } label: {
                    Image(systemName: isBookmark ? "bookmark.fill": "bookmark")
                }
                .accessibilityIdentifier(NewsReaderViewAccesibility.newsFeedBookmark.rawValue)
            }
        })
        .fullScreenCover(isPresented: $navigateToSafari, content: {
            SafariView(url: self.article.url)
                .ignoresSafeArea()
                .accessibilityIdentifier(NewsReaderViewAccesibility.newsFeedSafariView.rawValue)
        })
    }
}

#Preview {
       
    NewsReaderView(article: Binding(get: {
        Article(source: nil, author: "JON GAMBRELL", title: "Israel raids and shuts down Al Jazeera’s bureau in Ramallah in the West Bank - The Associated Press", description: "Israeli troops have raided the offices of the satellite news network Al Jazeera in the Israeli-occupied West Bank. The troops ordered the bureau to shut down early Sunday amid a widening campaign by Israel targeting the Qatar-funded broadcaster as it covers t…", url: URL(string: "https://apnews.com/article/israel-palestinians-al-jazeera-gaza-war-hamas-4abdb2969e39e7ad99dfbf9caa7bb32c")!, urlToImage: "https://dims.apnews.com/dims4/default/bbd5a4a/2147483647/strip/true/crop/1920x1080+0+2/resize/1440x810!/quality/90/?url=https%3A%2F%2Fassets.apnews.com%2F73%2F1e%2Fde6057bdc12d1cae8f99cb19bc19%2F6e4ed1d4fa084cfe9887260936b1ed0f", publishedAt: Date())
    }, set: {_ in }), isBookmark: Binding(get: {
        true
    }, set: { _ in }), dismissAfterbookmark: false)
}

enum NewsReaderViewAccesibility: String{
    case newsFeedImage = "NewsReaderViewFeedImage"
    case newsFeedAuthor = "NewsReaderViewFeedAuthor"
    case newsFeedTitle = "NewsReaderViewFeedTitle"
    case newsFeedDate = "NewsReaderViewFeedDate"
    case newsFeedBookmark = "NewsReaderViewFeedBookmark"
    case newsFeedDescription = "NewsReaderViewFeedDescription"
    case newsFeedReadMore = "NewsReaderViewFeedReadMore"
    case newsFeedSafariView = "newsFeedSafariView"
}
