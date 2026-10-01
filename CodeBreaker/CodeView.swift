//
//  CodeView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/29.
//

import SwiftUI

struct CodeView: View {
    //MARK: Data In
    let code: Code
    
    //MARK: Data Shared with Me
//    @State private var selection: Int = 0
    @Binding var selection: Int
    
    //MARK: - Body
    var body: some View {
        ForEach(code.pegs.indices, id: \.self) { index in
            PegView(peg: code.pegs[index])
            //                    .padding(5)
                .padding(Selection.border)
                .background {
                    if selection == index, code.kind == .guess {
                        Selection.shape
                        //                                .foregroundStyle(Color.gray.opacity(0.2))
                            .foregroundStyle(Selection.color)
                    }
                }
                .overlay {
                    Selection.shape.foregroundStyle(code.isHidden ? Color.gray : .clear)
                }
                .onTapGesture {
                    if code.kind == .guess{
                        //                            game.changeGuessPeg(at: index)
                        selection = index
                    }
                }
        }
    }
    struct Selection {
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let color: Color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    }
}

//#Preview {
//    CodeView()
//}
