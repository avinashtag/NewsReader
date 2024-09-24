//
//  View+Extension.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation
import SwiftUI
import AlertToast

extension View{
    
    func success( isPresenting: Binding<Bool>, message: String)-> some View{
        self.toast(isPresenting: isPresenting,duration: 2, alert: {
            AlertToast(displayMode: .alert, type: .complete(.accentColor), title: "Success".localized(), subTitle: message)
        })
    }

    func error( isPresenting: Binding<Bool>, message: String)-> some View{
        self.toast(isPresenting: isPresenting,duration: 2, alert: {
            AlertToast(displayMode: .alert, type: .error(.red), title: "Error".localized(), subTitle: message)
        })
    }
}
