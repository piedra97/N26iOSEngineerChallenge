//
//  UtilsDate.swift
//  N26iOSEngineerChallenge
//
//  Created by Projectes on 1/4/21.
//

import Foundation

struct UtilsDate {
    
    // Returns the today date in a given date format
    static func getActualDate(dateFormat: String) -> String? {
        return getDateFormatter(dateFormat: dateFormat).string(from: Date())
    }
    
    // Returns the date in two weeks from now
    static func getDateFromTwoWeeksBehind(dateFormat: String) -> String? {
        guard let twoWeeksDate = Calendar.current.date(byAdding: .day, value: -14, to: Date()) else {
            return nil
        }
        return getDateFormatter(dateFormat: dateFormat).string(from: twoWeeksDate)
    }
    
    // Returns a DateFormatter object with the desire date format
    private static func getDateFormatter(dateFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
    
    static func stringToDate(date: String, dateFormat: String) -> Date? {
        return getDateFormatter(dateFormat: dateFormat).date(from: date)
    }
    
    static func dateToString(date: Date, dateFormat: String) -> String {
        return getDateFormatter(dateFormat: dateFormat).string(from: date)
    }
}
