//
//  songdata.swift
//  recoder
//
//  Created by 陳昱豪 on 2019/11/26.
//  Copyright © 2019 Chen_Yu_Hao. All rights reserved.
//

import Foundation
class songData: ObservableObject {
    @Published var songs = [Songinfo](){
        didSet{
            let encoder = JSONEncoder()
            if let data=try? encoder.encode(songs){
                UserDefaults.standard.set(data,forKey: "songs")
            }
        }
    }
    init() {
        if let data=UserDefaults.standard.data(forKey: "songs"){
            let decoder=JSONDecoder()
            if let decodedata = try? decoder.decode([Songinfo].self ,from: data){
                songs=decodedata
            }
            
        }
    }
    var number=0
}
