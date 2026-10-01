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
    //MARK: Data in
    var matches: [Match]//this is the same as Array<Match>
    
    //MARK: - Body
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
        let exactCount = matches.count { $0 == .exact }
        let foundCount = matches.count { $0 != .nomatch }
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    MatchMaker(matches: [.exact, .inexact, .nomatch])
}
