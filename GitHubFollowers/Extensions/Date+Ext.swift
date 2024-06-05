//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 2/1/24.
//

import Foundation

extension Date {
    func convertToMonthYeartFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
    
}
