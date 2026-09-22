//
//  ContentView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/22.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .font(.largeTitle)
//            Text("Welcome to CS193p!")
//                .font(.largeTitle)
//                .foregroundStyle(.blue)
//            Text("parz")
//            Circle()
//                .font(.largeTitle)
//        }
//    }
//}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
            Text("Welcome to CS193p!")
                .padding()
                .background(.yellow)
                .foregroundStyle(.blue)
//                .padding()
            Text("parz")
            Circle()
        }
        .font(.largeTitle)
        .padding()
        .foregroundStyle(.green)
    }
}

#Preview {
    ContentView()
}
