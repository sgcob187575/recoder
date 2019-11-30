//
//  RecordingDataModel.swift
//  recoder
//
//  Created by 陳昱豪 on 2019/11/21.
//  Copyright © 2019 Chen_Yu_Hao. All rights reserved.
//

import Foundation
struct Recording {
    let fileURL: URL
    let createdAt: Date
}
struct Songinfo:Identifiable,Codable{
    var id = UUID()
    var filename:String
    var singer:String
}

