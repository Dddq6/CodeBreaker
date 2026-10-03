//
//  ElapsedTime.swift
//  CodeBreaker
//
//  Created by 董浩天 on 10/3/26.
//

import SwiftUI

struct ElapsedTime: View {
    let startTime: Date
    let endTime: Date?
    
    var body: some View {
//        if let endTime = endTime
        if let endTime {
            Text(endTime, format: .offset(to: startTime, allowedFields: [.minute, .second]))
        } else {
            Text(TimeDataSource<Data>.currentDate ,format: .offset(to: startTime, allowedFields: [.minute, .second]))
        }
    }
}

//#Preview {
//    ElapsedTime()
//}
