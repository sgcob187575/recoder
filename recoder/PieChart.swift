//
//  PieChart.swift
//  recoder
//
//  Created by 陳昱豪 on 2019/11/28.
//  Copyright © 2019 Chen_Yu_Hao. All rights reserved.
//

import Foundation
import SwiftUI
struct PieChart : Shape {
    var startAngle : Angle
    var endAngle : Angle
    func path(in rect:CGRect)-> Path{
        Path{(path) in
            let center = CGPoint(x:rect.midX,y:rect.maxY)
            path.move(to:center)
            path.addArc(center: center, radius: rect.midX, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
        }
    }
}
