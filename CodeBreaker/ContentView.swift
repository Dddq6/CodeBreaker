//
//  ContentView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            pegs(colors: [.red, .green, .green, .yellow])
            pegs(colors: [.red, .yellow, .green, .yellow])
            pegs(colors: [.red, .green, .blue, .blue])
        }
        .padding()
    }
    
    
    func pegs(colors: Array<Color>) -> some View {
        HStack{
            ForEach(colors.indices, id: \.self) { index in
//                Circle().foregroundStyle(colors[index])
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                //even though idk what is the meaning of this shape,,
                    .foregroundStyle(colors[index])
            }
            
            MatchMaker(matches: [.exact, .nomatch, .inexact, .exact])
        }
    }
}




#Preview {
    ContentView()
}
