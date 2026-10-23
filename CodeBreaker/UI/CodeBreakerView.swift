//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/22.
//

import SwiftUI

struct CodeBreakerView: View {
    //MARK: Data In
    @Environment(\.scenePhase) var scenePhase
    
    //MARK: Data Shared with Me
    let game: CodeBreaker
    
    //MARK: Data Owned by Me
    @State private var selection: Int = 0
    @State private var restarting = false
    @State private var hideMostRencentMarkers = false
    
    //MARK: - Body
    var body: some View {
        VStack{
            CodeView(code: game.masterCode)
            ScrollView{
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection) {
                        Button("Guess", action: guess).flexibleSystemFont()
                    }
                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting ? 0 : 1)

                }
                ForEach(game.attempts, id: \.pegs) { attempt in
                    CodeView(code: attempt) {
                        let showMarkers = !hideMostRencentMarkers || attempt.pegs != game.attempts.first?.pegs
                        if showMarkers, let matches = attempt.matches {
                            MatchMaker(matches: matches)
                        }
                    }
                    .transition(AnyTransition.attempt(game.isOver))
                }
            }
            if !game.isOver {
                PegChooser(choices: game.pegChoices, onChoices: changePegAtSelection)
                    .transition(.pegChooser)
                    .frame(maxHeight: 90)
            }
        }
//        .trackElapsedTime(in: game)
        .modifier(ElapsedTimeTracker(game: game))
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Restart", systemImage: "arrow.circlepath", action: restart)
            }
            ToolbarItem {
//            (placement: .automatic) //default
                ElapsedTime(startTime: game.startTime, endTime: game.endTime, elapsedTime: game.elapsedTime)
//                    .flexibleSystemFont()
                    .monospaced()
                    .lineLimit(1)
            }
        }
        .padding()
    }
    
    func changePegAtSelection(to peg: Peg) {
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1) % game.masterCode.pegs.count
    }
        
    func restart() {
        withAnimation(.restart) {
//            restarting = true
            restarting = game.isOver
            game.restart()
            selection = 0
        } completion: {
            withAnimation(.restart) {
                restarting = false
            }
        }
    }
        
    func guess() {
        withAnimation(.guess) {
            game.attemptGuess()
            selection = 0
            hideMostRencentMarkers = true
        } completion: {
            withAnimation(.guess) {
                hideMostRencentMarkers = false
            }
        }
    }
}

extension View {
    func trackElapsedTime(in game: CodeBreaker) -> some View {
        self.modifier(ElapsedTimeTracker(game: game))
    }
}

struct ElapsedTimeTracker: ViewModifier {
    @Environment(\.scenePhase) var scenePhase
    let game: CodeBreaker
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                game.startTimer()
            }
            .onDisappear {
                game.pauseTimer()
            }
            //for ipad
            .onChange(of: game) { oldGame,newGame in
                oldGame.pauseTimer()
                newGame.startTimer()
            }
            .onChange(of: scenePhase) {
                switch scenePhase {
                case.active: game.startTimer()
                case.background: game.pauseTimer()
                default:break
                }
            }

    }
}

#Preview {
    @Previewable @State var game = CodeBreaker(name: "Preview", pegChoices: [.blue, .yellow, .red])
    NavigationStack{
        CodeBreakerView(game: game)
    }
}
