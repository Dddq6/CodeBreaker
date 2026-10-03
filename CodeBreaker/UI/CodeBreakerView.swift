//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/22.
//

import SwiftUI

struct CodeBreakerView: View {
    //MARK: Data Owned by Me
    //so now need connection with Model
    @State private var game = CodeBreaker(pegChoices: [.brown, .yellow, .orange, .black, .green])
    //argument that's all logic model should do->set the default
    //class pointer inside the State
    @State private var selection: Int = 0
    @State private var restarting = false
    @State private var hideMostRencentMarkers = false
    
    //MARK: - Body
    var body: some View {
        VStack{
//            Button("restart") {
//                withAnimation(.restart) {
//                    restarting = true
//                } completion: {
//                    withAnimation(.restart) {
//                        game.restart()
//                        selection = 0
//                        restarting = false
//                    }
//                }
//            }
            Button("Restart", systemImage: "arrow.circlepath", action: restart)
//                .labelStyle(.iconOnly)
//                .labelStyle(.titleOnly)
            
            CodeView(code: game.masterCode) {
                ElapsedTime(startTime: game.startTime, endTime: game.endTime)
            }
            ScrollView{
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection) {
//                        guessButton
                        Button("Guess", action: guess).flexibleSystemFont()
//                        .font(.system(size: GuessButton.maximunFontSize))
//                        .minimumScaleFactor(GuessButton.scaleFactor)
                    }
                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting ? 0 : 1)

                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(code: game.attempts[index]) {
                        let showMarkers = !hideMostRencentMarkers || index != game.attempts.count - 1
                        if showMarkers, let matches = game.attempts[index].matches {
                            MatchMaker(matches: matches)
                        }
                    }
                    .transition(AnyTransition.attempt(game.isOver))
                }
            }
            if !game.isOver {
                pegChooser(choices: game.pegChoices, onChoices: changePegAtSelection)
                    //.transition(.move(edge: .bottom))
//                    .transition(AnyTransition.offset(x: 0, y: 200))
                    .transition(.pegChooser)
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
    
//    var guessButton: some View {
////        Button("Guess") {
////            guess()
//////            withAnimation(.guess) {
//////                game.attemptGuess()
//////                selection = 0
//////                hideMostRencentMarkers = true
//////            } completion: {
//////                withAnimation(.guess) {
//////                    hideMostRencentMarkers = false
//////                }
//////            }
////        }
//        Button("Guess", action: guess)
//        .font(.system(size: GuessButton.maximunFontSize))
//        .minimumScaleFactor(GuessButton.scaleFactor)
//
//    }
    
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
    
//    struct GuessButton {
//        static let minimumFontSize: CGFloat = 8
//        static let maximunFontSize: CGFloat = 80
//        static let scaleFactor = minimumFontSize / maximunFontSize
//    }
}




#Preview {
    CodeBreakerView()
}
