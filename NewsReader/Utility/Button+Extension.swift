//
//  Button+Extension.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation
import SwiftUI

struct ReadMore: ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: UIScreen.main.bounds.width - 50)
            .padding()
//            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            .clipShape(.rect(cornerRadius: 5))
    }
}
