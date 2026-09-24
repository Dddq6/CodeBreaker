//
//  MatchMaker.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/23.
//

import SwiftUI

enum Match {
    case nomatch
    case exact
    case inexact
}

//"helicopter" View("bag of lego")
struct MatchMaker: View {
    var matches: [Match]//this is the same as Array<Match>
    var body: some View {
        HStack{
            VStack{
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            VStack{
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }
    
    func matchMarker(peg: Int) -> some View {
        let exactCount = matches.count(where: {match in match == .exact})
        let foundCount: Int = matches.count(where: {match in match != .nomatch})
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
    
    func isExact(match: Match) -> Bool {
        //return match == Match.exact
        match == .exact
        //the single line of func and remove "Match": can clearly infer
    }
}

#Preview {
    MatchMaker(matches: [.exact, .inexact, .nomatch])
}
