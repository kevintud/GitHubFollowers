//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 2/1/24.
//

import Foundation

extension String {
    
    func converToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.converToDate() else {return "N/A"}
        return date.convertToMonthYeartFormat() 
    }
}
