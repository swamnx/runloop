//
//  CommonUtils.swift
//  runloop
//
//  Created by swamnx on 20.05.21.
//

import Foundation

struct CommonUtils {

    private let dateFormatter = DateFormatter()
    private let dateComponentsFormatter = DateComponentsFormatter()
    
    static var shared = CommonUtils()
    
    init () {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateComponentsFormatter.allowedUnits = [.day, .hour, .minute, .second]
        dateComponentsFormatter.unitsStyle = .full
    }
    
    func formatedInterval(_ interval: TimeInterval) -> String {
        return dateComponentsFormatter.string(from: interval)!
    }

    func formatedDate(_ date: Date?) -> String {
        return dateFormatter.string(from: date!)
    }
    
    func processFootballMatch(_ match: inout FootballMatch) -> Bool {
        guard !match.ended else { return false }
        let date = Date.init()
        guard date < match.date else {
            match.ended = true
            match.remainingTime = "Started"
            return true
        }
        let remainingTime = DateInterval(start: date, end: match.date).duration
        match.remainingTime = CommonUtils.shared.formatedInterval(remainingTime)
        return true
    }
    
    enum FootballMatchIds: String {
        case cell = "FootballMatchCellID"
    }
    
    enum ErrorTexts: String {
        case basicErrorTitle = "Something went wrong"
    }
    
}
