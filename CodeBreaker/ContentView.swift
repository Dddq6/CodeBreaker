//
//  ContentView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            pegs(colors: [.red, .green, .green, .yellow])
            pegs(colors: [.red, .yellow, .green, .yellow])
            pegs(colors: [.red, .green, .blue, .blue])
        }
        .padding()
    }
    
    //    var pegs: some View {
    //        HStack{
    //            Circle().foregroundStyle(.red)
    //            Circle().foregroundStyle(.green)
    //            Circle().foregroundStyle(.green)
    //            Circle().foregroundStyle(.yellow)
    //        }
    //    }
    
    func pegs(colors: Array<Color>) -> some View {
        //        HStack{
        //            Circle().foregroundStyle(colors[0])
        //            Circle().foregroundStyle(colors[1])
        //            if colors.count > 2 {
        //                Circle().foregroundStyle(colors[2])
        //                if colors.count > 3 {
        //                    Circle().foregroundStyle(colors[3])
        //                }
        //            }
        //        }
        HStack{
            ForEach(colors.indices, id: \.self) { index in
                Circle().foregroundStyle(colors[index])
            }
        }
    }
}

#Preview {
    ContentView()
}
