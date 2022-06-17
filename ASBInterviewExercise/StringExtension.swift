//
//  StringExtension.swift
//  ASBInterviewExercise
//
//  Created by Ronald Fornis Paglinawan on 17/06/22.
//

import Foundation

extension String {
    
    static func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
    static func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a"
        return dateFormatter.string(from: date)
    }
}
