//
//  GameChooser.swift
//  CodeBreaker
//
//  Created by 董浩天 on 10/4/26.
//

import SwiftUI

struct GameChooser: View {
    //MARK: Data Owned by Me
    @State private var games: [CodeBreaker] = []
    
    //MARK: Body
    var body: some View {
        NavigationStack {
            List{
                ForEach(games) { game in
//                    NavigationLink {
//                        CodeBreakerView(game: game)
//                    } label: {
//                        GameSummary(game: game)
//                    }
                    NavigationLink(value: game) {
                        GameSummary(game: game)
                    }
                    NavigationLink(value: game.masterCode.pegs) {
                        Text("cheat")
                    }
                }
                .onDelete { offsets in
                    games.remove(atOffsets: offsets)
                }
                .onMove { offsets, destination in
                    games.move(fromOffsets: offsets, toOffset: destination)
                    
                }
            }
            .navigationDestination(for: CodeBreaker.self) { game in
                CodeBreakerView(game: game)
            }
            .navigationDestination(for: [Peg].self) { pegs in
                PegChooser(choices: pegs)
            }
            .listStyle(.plain)
            .toolbar {
                EditButton()
            }
//        List{
//            Section("Games"){
//                ForEach(game, id: \.pegChoices) { game in
//                    GameSummary(game: game)
//                }
//            }
//            Section(header: Image(systemName: "face.smiling")) {
//                Text("Hello")
//                Text("There")
//            }
            
//            .listRowSeparator(.hidden)
//            .listRowBackground(RoundedRectangle(cornerRadius: 10).foregroundStyle(.yellow).padding(5))
        }
        
        .onAppear{
            games.append(CodeBreaker(name: "Mastermind", pegChoices: [.red, .blue, .green, .yellow]))
            games.append(CodeBreaker(name: "Earth Tones", pegChoices: [.brown, .gray, .green, .cyan, .yellow]))
            games.append(CodeBreaker(name: "Undersea", pegChoices: [.indigo, .blue, .cyan]))

        }
    }
}

#Preview {
    GameChooser()
}
