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
//        let exactCount = matches.count(where: isExact)
        
//        let exactCount = matches.count(where: { (match: Match) -> Bool in
//            match == .exact
//        })
        
//        let exactCount = matches.count(where: { match in
//            match == .exact
//        })
        
//        let exactCount = matches.count { match in
//            match == .exact
//        }//Trailing Closure Syntax
            
        //how many are exact? exactCount= 完全匹配数
        let exactCount = matches.count { $0 == .exact }
        //how many are not no-match? foundCount = 找到的数 = exact + inexact
        let foundCount = matches.count { $0 != .nomatch }
        return Circle()
        //primary is the color that regular and clear is transparent
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
    //func isExact
}

#Preview {
    MatchMaker(matches: [.exact, .inexact, .nomatch])
}
