//
//  NewsFeedCell.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import SwiftUI

struct NewsFeedCell: View {
    @Binding var article: Article
    @Binding var isBookmark: Bool
    var didSelect:()->Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            
            HStack(alignment: .top, content: {
                if URL(string: article.urlToImage ?? "") == nil{
                    Image(systemName: "newspaper")
                        .imageScale(.medium)
                        .frame( width: 80, height: 80 )
                        .accessibilityIdentifier(NewsFeedCellAccesibility.newsFeedImage.rawValue)
                }
                else{
                    
                    AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame( width: 80, height: 80 )
                    .clipped()
                    .accessibilityIdentifier(NewsFeedCellAccesibility.newsFeedImage.rawValue)
                }
                VStack(alignment: .leading, content: {
                    Text(article.author ?? "Headlines")
                        .font(.caption)
                        .accessibilityIdentifier(NewsFeedCellAccesibility.newsFeedAuthor.rawValue)
                    Text(article.title ?? "")
                        .font(.title3)
                        .lineLimit(3)
                        .accessibilityIdentifier(NewsFeedCellAccesibility.newsFeedTitle.rawValue)

                })
                
                Spacer()
                VStack{
                    Spacer()
                    Image(systemName: "chevron.right")
                        .renderingMode(.template)
                        .tint(.gray)
                    Spacer()
                }
            })
            .onTapGesture {
                didSelect()
            }
            
            HStack(alignment: .top, content: {
                Text("\(article.publishedAt?.conversion(date: true, time: true, doesRelativeDateFormatting: true) ?? "")")
                    .font(.caption)
                    .accessibilityIdentifier(NewsFeedCellAccesibility.newsFeedDate.rawValue)
                Spacer()
                Button(action: {
                    isBookmark.toggle()
                }, label: {
                    Image(systemName: isBookmark ? "bookmark.fill": "bookmark")
                })
                .tint(.accentColor)
                .frame(width: 30)
                .accessibilityIdentifier(NewsFeedCellAccesibility.newsFeedBookmark.rawValue)
            })
        })
    }
}

enum NewsFeedCellAccesibility: String{
    case newsFeedImage = "newsFeedImage"
    case newsFeedAuthor = "newsFeedAuthor"
    case newsFeedTitle = "newsFeedTitle"
    case newsFeedDate = "newsFeedDate"
    case newsFeedBookmark = "newsFeedBookmark"
}
