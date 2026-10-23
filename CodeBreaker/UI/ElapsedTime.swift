//
//  ElapsedTime.swift
//  CodeBreaker
//
//  Created by 董浩天 on 10/3/26.
//

import SwiftUI

struct ElapsedTime: View {
    let startTime: Date?
    let endTime: Date?
    let elapsedTime: TimeInterval
    
    var format: SystemFormatStyle.DateOffset {
        .offset(to: startTime! - elapsedTime, allowedFields: [.minute, .second])
    }
    
    var body: some View {
//        if let endTime = endTime
        if startTime != nil {
            if let endTime {
                Text(endTime, format: format)
            } else {
                Text(TimeDataSource<Data>.currentDate ,format: format)
            }
        } else {
            Image(systemName: "pause")
        }
    }
}

//#Preview {
//    ElapsedTime()
//}
