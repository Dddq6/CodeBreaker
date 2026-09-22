//
//  ContentView.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/22.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack(alignment:.leading, spacing: 1, content: greeting)
//    }
//    
//    @ViewBuilder
////    func greeting() -> TupleView<(Image,Text,Circle)> {
//    func greeting() -> some View{
//        Image(systemName: "globe")
//        if true {
//            Text("greetings!")
//
//        }
//        Text("parz")
//        Circle()
//    }
//}


struct ContentView: View {
    var body: some View {
//        VStack(alignment:.leading, spacing: 1, content: {
        //and also can delete the content:,and rest of that
        VStack {
            Image(systemName: "globe")
            if true {
                Text("greetings!")
                
            }
            Text("parz")
            Circle()
        }
    }
    
}

#Preview {
    ContentView()
}
