//
//  PieChartView.swift
//  recoder
//
//  Created by 陳昱豪 on 2019/11/28.
//  Copyright © 2019 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI

struct PieChartView: View {
    var percentages:[Double]
    var angles:[Angle]
    
    init(percentages:[Double]){
        self.percentages=percentages
        angles=[Angle]()
        var startDegree:Double=0
        for percentage in percentages{
            angles.append(.degrees(startDegree))
            startDegree+=360*percentage/100
        }
    }
    let colorset:[Color]=[Color(red: 255/255, green: 50/255, blue: 5/255),Color(red: 5/255, green: 250/255, blue: 50/255),Color(red: 2/255, green: 50/255, blue: 255/255),Color(red: 255/255, green: 1/255, blue: 255/255)]
    func addOne(index: Int) -> Int {
        return index + 1
    }
    var body: some View {
        ZStack{
            ForEach(angles.indices){(index) in
                if index==self.angles.count-1{
                    PieChart(startAngle: self.angles[index], endAngle: .zero).fill(self.colorset[index])
                }else{
                    PieChart(startAngle: self.angles[index], endAngle: self.angles[self.addOne(index:index)]).fill(self.colorset[index])
                }
            }
            

        }
    }
}

