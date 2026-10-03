//
//  PegView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/29.
//

import SwiftUI

struct PegView: View {
    //MARK: Data in
    let peg: Peg
    
    //MARK: - Body
    
//    let pegShape = RoundedRectangle(cornerRadius: 10)
    let pegShape = Circle()
    var body: some View {
        pegShape
//            .overlay() {
//                if peg == Code.missingPeg{
//                    pegShape
//                        .strokeBorder(Color.gray)
//                    }
//                }
                .contentShape(pegShape)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(peg)

    }
}

#Preview {
    PegView(peg: .blue)
        .padding()
}
