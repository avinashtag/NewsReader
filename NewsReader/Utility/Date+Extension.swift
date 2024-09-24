//
//  Date+Extension.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import Foundation

extension Date{
    
    func conversion(date: Bool, time: Bool, doesRelativeDateFormatting: Bool) -> String? {

        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
        formatter.timeStyle =  time ? .short : .none
        formatter.dateStyle =   date ? .medium : .none
        formatter.locale =   Locale.current
        return formatter.string(from: self)
    }
    func conversion(format:String) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale =  Locale.current
        return formatter.string(from: self)
    }
    
   
}
