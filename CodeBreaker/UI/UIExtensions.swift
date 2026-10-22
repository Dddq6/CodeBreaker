//
//  UIExtensions.swift
//  CodeBreaker
//
//  Created by 董浩天 on 10/3/26.
//

import SwiftUI

extension View {
    func flexibleSystemFont(minimun: CGFloat = 8, maximun: CGFloat = 70) -> some View{
        self
            .font(.system(size: maximun))
            .minimumScaleFactor(minimun/maximun)

    }
}
extension AnyTransition {
    static let pegChooser = AnyTransition.offset(x: 0, y: 200)
    static func attempt(_ isOver: Bool) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: isOver ? .opacity : .move(edge: .top),
            removal: .move(edge: .trailing))
    }
}

extension Animation {
//    static let codeBreaker = Animation.easeInOut(duration: 1)
    static let codeBreaker = Animation.bouncy
    static let guess = codeBreaker
    static let restart = codeBreaker
    static let selection = codeBreaker
}
extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}
