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
    
    //MARK: - Body
    var body: some View {
        VStack{
            //pegs(colors: game.masterCode.pegs)
            view(for: game.masterCode)
            ScrollView{
                if !game.isOver {
                    view(for: game.guess)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            //This is so horrible!!
//            pegChooser(game: $game, selection: $selection)
            pegChooser(choices: game.pegChoices) { peg in
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.masterCode.pegs.count
            }
        }
        .padding()
    }
    
    //TO be a 'helicopter' view
//    var pegChooser: some View {
//        
//    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
                selection = 0
            }
        }
//        .font(.system(size: 80))
//        .minimumScaleFactor(0.3)
        .font(.system(size: GuessButton.maximunFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)

    }
    
    func view(for code: Code) -> some View {
    //func pegs(colors: Array<Color>) -> some View {
        HStack{
            CodeView(code: code, selection: $selection)
            
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
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximunFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximunFontSize
    }
}

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}


#Preview {
    CodeBreakerView()
}
