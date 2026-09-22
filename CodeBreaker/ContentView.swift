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
            HStack{
                Circle().foregroundStyle(.red)
                Circle().foregroundStyle(.green)
                Circle().foregroundStyle(.green)
                Circle().foregroundStyle(.yellow)
            }
            HStack{
                Circle().foregroundStyle(.red)
                Circle().foregroundStyle(.yellow)
                Circle().foregroundStyle(.green)
                Circle().foregroundStyle(.yellow)
            }
            HStack{
                Circle().foregroundStyle(.red)
                Circle().foregroundStyle(.green)
                Circle().foregroundStyle(.red)
                Circle().foregroundStyle(.yellow)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
