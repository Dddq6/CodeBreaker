//
//  GameSummary.swift
//  CodeBreaker
//
//  Created by 董浩天 on 10/5/26.
//

import SwiftUI

struct GameSummary: View {
    let game: CodeBreaker
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(game.name).font(.title)
            PegChooser(choices: game.pegChoices).frame(maxHeight: 50)
            Text("^[\(game.attempts.count) atempt](inflect: true)")
        }
    }
}

#Preview {
    List{
        GameSummary(game: CodeBreaker(name: "Preview", pegChoices: [.red, .yellow, .gray]))
    }
    List{
        GameSummary(game: CodeBreaker(name: "Preview", pegChoices: [.red, .yellow, .gray]))
    }
    .listStyle(.plain)
}
