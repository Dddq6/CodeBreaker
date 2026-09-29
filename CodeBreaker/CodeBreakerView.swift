//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/22.
//

import SwiftUI

struct CodeBreakerView: View {
    
    //so now need connection with Model
    @State var game = CodeBreaker(pegChoices: [.brown, .yellow, .orange, .black])
    //argument that's all logic model should do->set the default
    //class pointer inside the State
    var body: some View {
        VStack{
            ScrollView{
                //pegs(colors: game.masterCode.pegs)
                view(for: game.masterCode)
                view(for: game.guess)
                //view(for: game.attempts[0])
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
        }
        .padding()
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.3)
    }
    
    func view(for code: Code) -> some View {
    //func pegs(colors: Array<Color>) -> some View {
        HStack{
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay() {
                        if code.pegs[index] == Code.missing{
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(Rectangle())//Cuz transparent can pass through multi-touch
                    .aspectRatio(1, contentMode: .fit)
                //  .foregroundStyle(colors[index])
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess{
                            game.changeGuessPeg(at: index)
                        }
                    }
            }
            
            Rectangle().foregroundStyle(Color.clear).aspectRatio(1, contentMode: .fit)
                .overlay() {
                    if let matches = code.matches {
                        //            MatchMaker(matches: code.matches)
                        MatchMaker(matches: matches)
                    } else {
                        if code.kind == .guess{
                            guessButton
                        }
                    }
                }
        }
    }
}




#Preview {
    CodeBreakerView()
}
