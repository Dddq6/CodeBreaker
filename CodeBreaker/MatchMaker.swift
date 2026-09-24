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
                Circle().fill(Color.green)
//                Circle().stroke(style: .init())
//                Circle().stroke(Color.primary, lineWidth: 3)
                //it'll be kind of spilling out
                Circle().strokeBorder(Color.primary, lineWidth: 3).aspectRatio(1,contentMode: .fit)
            }
            VStack{
                Circle()
                Circle().opacity(0)
            }
        }
    }
}

#Preview {
    MatchMaker(matches: [.exact, .inexact, .nomatch])
}
