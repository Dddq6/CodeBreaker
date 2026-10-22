//
//  GameChooser.swift
//  CodeBreaker
//
//  Created by 董浩天 on 10/4/26.
//

import SwiftUI

struct GameChooser: View {
    
    @State private var selection: CodeBreaker? = nil
    
    //MARK: Body
    var body: some View {
//        NavigationStack {
        NavigationSplitView {
            GameList(selection: $selection)
                .navigationTitle("Code Breaker")
        } detail: {
            if let selection {
                CodeBreakerView(game: selection)
                    .navigationTitle(selection.name)
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Choose a game!")
            }
        }
//        .navigationSplitViewStyle(.balanced)
        
    }
}

#Preview {
    GameChooser()
}
