//
//  GameEditor.swift
//  CodeBreaker
//
//  Created by 董浩天 on 10/22/26.
//

import SwiftUI

struct GameEditor: View {
    //MARK: Data (Function) In
    @Environment(\.dismiss) var dismiss
    
    //MARK: Data Shared with Me
//    let game: CodeBreaker->Text()
    @Bindable var game: CodeBreaker
    
    //MARK: Action Function
    let onChoose: ()-> Void
    
    //MARK: Data Owned by Me
    @State private var showInvalidGameAlert = false
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Name") {
                    TextField("Name", text: $game.name)
                        .autocapitalization(.words)
                        .autocorrectionDisabled()
                    //when you hit the return button
                        .onSubmit {
                            done()
                        }
                }
                Section("Pegs") {
                    PegChoicesChooser(pegChoices: $game.pegChoices)
                }
            }
            .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            done()
                        }
//                        .disabled(!game.isVaild)
                        .alert("Invail Game", isPresented: $showInvalidGameAlert) {
                            Button("OK") {
                                showInvalidGameAlert = false
                            }
                        } message: {
                            Text("A game must have a name and more than one unique peg")
                        }
                    }
                }
        }
        
        
        
        
        
        
    }
    
    func done() {
        if game.isVaild {
            onChoose()
            dismiss()
        } else {
            showInvalidGameAlert = true
        }
    }
}

extension CodeBreaker {
    var isVaild: Bool {
        !name.isEmpty && Set(pegChoices).count >= 2
    }
}

#Preview {
    @Previewable var game = CodeBreaker(name: "Preview", pegChoices: [.orange, .red])
    GameEditor(game: game){
            print("game name changed to \(game.name)")
            print("game pegs changed to \(game.pegChoices)")
        }
}
