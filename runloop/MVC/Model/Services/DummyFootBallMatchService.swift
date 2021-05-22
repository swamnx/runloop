//
//  FootBallMatchService.swift
//  runloop
//
//  Created by swamnx on 20.05.21.
//

import Foundation

struct DummyFootballMatchService: FootballMatchService {
    
    func loadFootballMatches() -> [FootballMatch]? {
        let testOne = FootballMatch(name: "BEL-NL", description: "Match between Belarus and Nnetherlands", date: Date.init() + 10, remainingTime: "")
        let testSecond = FootballMatch(name: "BEL-GB", description: "Match between Belarus and Great Britain", date: Date.init() + 3300, remainingTime: "")
        let testThird = FootballMatch(name: "BEL-USA", description: "Match between Belarus and United States of America", date: Date.init() + 3400, remainingTime: "")
        var matches = [testOne, testSecond, testThird]
        return matches
    }
}
