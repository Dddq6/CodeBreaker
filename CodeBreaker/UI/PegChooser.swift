//
//  pegChooser.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/30.
//

import SwiftUI

struct PegChooser: View {
    //MARK: Data In
    let choices: [Peg]
    //MARK: Data Out Function
    var onChoices: ((Peg) -> Void)?
    
//    @Binding var game: CodeBreaker
//    @Binding var selection: Int

    //MARK: - Body
    
    var body: some View {
        HStack {
            ForEach(choices, id: \.self) { peg in
                Button {
                    onChoices?(peg)
                } label: {
                    PegView(peg: peg)
                }
            }
        }
    }
}

//#Preview {
//    pegChooser()
//}
