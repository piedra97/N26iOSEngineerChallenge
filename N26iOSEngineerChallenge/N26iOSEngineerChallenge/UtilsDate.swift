//
//  UtilsDate.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 1/4/21.
//

import Foundation

class UtilsDate {
    
    // Returns the today date in a given date format
    class func getActualDate(dateFormat: String) -> String? {
        return getDateFormatter(dateFormat: dateFormat).string(from: Date())
    }
    
    // Returns the date in two weeks from now
    class func getDateFromTwoWeeks(dateFormat: String) -> String? {
        guard let twoWeeksDate = Calendar.current.date(byAdding: .day, value: 15, to: Date()) else {
            return nil
        }
        return getDateFormatter(dateFormat: dateFormat).string(from: twoWeeksDate)
    }
    
    // Returns a DateFormatter object with the desire date format
    private class func getDateFormatter(dateFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
}
