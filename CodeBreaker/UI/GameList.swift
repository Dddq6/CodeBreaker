//
//  GameList.swift
//  CodeBreaker
//
//  Created by 董浩天 on 10/22/26.
//

import SwiftUI

struct GameList: View {
    //MARK: Data Shared with Me
    @Binding var selection: CodeBreaker?

    //MARK: Data Owned by Me
    @State private var games: [CodeBreaker] = []
    
//    @State private var showGameEditor = false
    @State private var gameToEdit: CodeBreaker?

    var body: some View {
        List(selection: $selection){
            ForEach(games) { game in
                NavigationLink(value: game) {
                    GameSummary(game: game)
                }
                .contextMenu {
                    editButton(for: game) //editing a game
                    deleteButton(for: game)
                }
                .swipeActions(edge: .leading) {
                    editButton(for: game).tint(.accentColor)
                }
            }
    
            .onDelete { offsets in
                games.remove(atOffsets: offsets)
            }
            .onMove { offsets, destination in
                games.move(fromOffsets: offsets, toOffset: destination)
                
            }
        }
        .onChange(of: games) {
            if let selection, !games.contains(selection) {
                self.selection = nil
            }
        }

        .listStyle(.plain)
        .toolbar {
            addButton
            EditButton()//editing the list of game
        }
        .onAppear{ addSampleGames() }
    }
    
    func editButton(for game: CodeBreaker) -> some View {
        Button("Edit", systemImage: "pencil") {
//            game = gameToEdit
            gameToEdit = game
        }
    }
    
    
    
    var addButton: some View {
        Button("Add Game", systemImage: "plus") {
            gameToEdit = CodeBreaker(name: "Untitled", pegChoices: [.red, .blue])
//                games.append(newGame)
//                showGameEditor = true
        }
//        .onChange(of: gameToEdit) {
//            showGameEditor = gameToEdit != nil
//        }
//        .sheet(isPresented: $showGameEditor, onDismiss: { gameToEdit = nil }) {
        .sheet(isPresented: showGameEditor) {

//                Text("Game Editor goes here")
            gameEditor
        }
       

    }
    
//    @ViewBuilder
//    var gameEditor: some View {
//        if let gameToEdit {
//            GameEditor(game: gameToEdit) {
//                games.insert(gameToEdit, at: 0)
//            }
//        }
//    }
    
//    @ViewBuilder
//    var gameEditor: some View {
//        if let gameToEdit {
//            GameEditor(game: gameToEdit) {
//                if !games.contains(where: { $0.id == gameToEdit.id }) {
//                    games.insert(gameToEdit, at: 0)
//                }
//            }
//        }
//    }
    
    @ViewBuilder
    var gameEditor: some View {
        if let gameToEdit {
//            let copyOfGameToEdit = gameToEdit
            let copyOfGameToEdit = CodeBreaker(name: gameToEdit.name, pegChoices: gameToEdit.pegChoices)
            GameEditor(game: copyOfGameToEdit) {
                if let index = games.firstIndex(of: gameToEdit){
                    games[index] = copyOfGameToEdit
                } else {
//                    games.insert(gameToEdit, at: 0)
                    games.insert(copyOfGameToEdit, at: 0)
                }
            }
        }
    }
    
    var showGameEditor: Binding<Bool> {
        Binding<Bool>(get: {
            gameToEdit != nil
        }, set: { newValue in
            if !newValue {
                gameToEdit = nil
            }
        })
    }
    
    func deleteButton(for game: CodeBreaker) -> some View {
        Button("Delete", systemImage: "minus.circle", role: .destructive) {
            withAnimation {
                games.removeAll(where: { $0 == game })
            }
        }
    }
    func addSampleGames() {
        if games.isEmpty {
            games.append(CodeBreaker(name: "Mastermind", pegChoices: [.red, .blue, .green, .yellow]))
            games.append(CodeBreaker(name: "Earth Tones", pegChoices: [.brown, .gray, .green, .cyan, .yellow]))
            games.append(CodeBreaker(name: "Undersea", pegChoices: [.indigo, .blue, .cyan]))
            selection = games.last
            //            selection = games[Int.random(in: 0..<games.count)]
        }
    }
}

#Preview {
    @Previewable @State var selection: CodeBreaker?
    NavigationStack{
        GameList(selection: $selection)
    }
}
