//
//  CodeView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/29.
//

import SwiftUI

struct CodeView<AncillaryView>: View where AncillaryView: View {
    //MARK: Data In
    let code: Code
    
    //MARK: Data Shared with Me
//    @State private var selection: Int = 0
    @Binding var selection: Int
    
    //MARK: Data (sort of) In Fuction
    @ViewBuilder let ancillaryView: () -> AncillaryView
    
    //MARK: Data Own by Me
    @Namespace private var selectionNamespace
    
    init(code: Code,
         selection: Binding<Int> = .constant(-1),
         @ViewBuilder ancillaryView: @escaping () -> AncillaryView = { EmptyView() }
    ) {
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
    
    //MARK: - Body
    var body: some View {
        HStack{
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.pegs[index])
                    .padding(Selection.border)
                    .background { //selection background
                        Group{//just a container that's innocuous
                            if selection == index, code.kind == .guess {
                                Selection.shape
                                    .foregroundStyle(Selection.color)
                                    .matchedGeometryEffect(id: "selection", in: selectionNamespace)
                            }
                        }
                        .animation(.selection, value: selection)
                    }
                //just wanna animation for backgroung not include the peg
//                    .animation(.selection, value: selection)
                    .overlay { //hidden code abscuring
                        Selection.shape.foregroundStyle(code.isHidden ? Color.gray : .clear)
//                            .animation(nil, value: code.isHidden)
                            .transaction { transaction in
                                if code.isHidden {
                                    transaction.animation = nil
                                }
                            }
                    }
                    .onTapGesture {
                        if code.kind == .guess{
                            selection = index
                        }
                    }
            }
            Rectangle().foregroundStyle(Color.clear).aspectRatio(1, contentMode: .fit)
//                .overlay() {
                .overlay {
//                    if let matches = code.matches {
//                        //            MatchMaker(matches: code.matches)
//                        MatchMaker(matches: matches)
//                    } else {
//                        if code.kind == .guess{
//                            guessButton
//                        }
//                    }
                    ancillaryView()
                }
        }
        
    }
}
fileprivate struct Selection {
    static let border: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let color: Color = Color.gray(0.85)
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
}
//#Preview {
//    CodeView()
//}
