//
//  analysis.swift
//  recoder
//
//  Created by 陳昱豪 on 2019/11/23.
//  Copyright © 2019 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI
struct analysis: View {
    var songdata:songData
    let members=["八三夭","林俊傑","周湯豪","周杰倫"]
    @State private var analist:[Double]=[0,0,0,0]
    @State private var total:Double=0
    @State private var pro:[CGFloat]=[0,0,0,0]
    @State private var showsuprise=false
    @State private var suprise=false
    let frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    let colorset:[Color]=[Color(red: 255/255, green: 50/255, blue: 5/255),Color(red: 5/255, green: 250/255, blue: 50/255),Color(red: 2/255, green: 50/255, blue: 255/255),Color(red: 255/255, green: 1/255, blue: 255/255)]

    var body: some View {
        ZStack {
            VStack(alignment:.leading) {
                Text("所有歌曲").padding().background(Color.init(red: 250/255, green: 250/255, blue: 130/255)).cornerRadius(20).font(Font.system(size: 40))
                HStack{
                    Spacer()
                    PieChartView(percentages: analist).frame(width:100,height: 100).offset(y:-50)
                    Spacer()
                    VStack{
                        ForEach(0..<4){ index in
                            HStack{                        Path(self.frame).fill(self.colorset[index]).frame(width: 20, height: 20)
                                Text(self.members[index])
                                Spacer()
                            }
                        }
                    }.frame(width:100,height: 100)
                    Spacer()
                }
                ForEach(0..<4){index in
                    schedule(pro:self.pro[index],index: index,showsuprise: self.showsuprise,suprise: self.$suprise)
                    
                }
            }.onAppear(){
                self.songdata.songs.forEach{(song) in
                    let index=self.members.firstIndex{
                        return $0==song.singer
                    }
                    self.analist[index!]+=1
                    self.total+=1
                }
                for i in (0..<4){
                    self.analist[i]=self.analist[i]/self.total*100
                    self.pro[i]+=CGFloat(300*self.analist[i]/100)

                }
                if(self.pro[0]==CGFloat(300))
                {
                    self.showsuprise=true
                }
            }.animation(Animation.easeOut(duration: 3).delay(0.5))
            ZStack {
                Image("特效").scaledToFill().frame(width:100,height: 200).scaleEffect(suprise ? 1:0).opacity(suprise ? 1:0).animation(Animation.easeOut(duration: suprise ? 0.6:0).delay(2)).offset(x:-30)

                VStack{
                    Image("logo").resizable().scaledToFit().frame(width:90,height: 90).opacity(suprise ? 1:0).animation(Animation.easeOut(duration: suprise ? 0.6:0).delay(2))
                    Text("頭").font(.largeTitle).fontWeight(.heavy).foregroundColor(.black).padding().background(Color.init(red: 249/255, green: 22/255, blue: 0/255)).cornerRadius(20).frame(height:90).opacity(suprise ? 1:0).animation(Animation.easeOut(duration: suprise ? 0.6:0))
                    Text("號").font(.largeTitle).foregroundColor(.black).fontWeight(.heavy).padding().background(Color.init(red: 249/255, green: 22/255, blue: 0/255)).cornerRadius(20).frame(height:90).opacity(suprise ? 1:0).animation(Animation.easeOut(duration: suprise ? 0.6:0).delay(0.5))
                    Text("粉").font(.largeTitle).foregroundColor(.black).fontWeight(.heavy).padding().background(Color.init(red: 249/255, green: 22/255, blue: 0/255)).cornerRadius(20).frame(height:90).opacity(suprise ? 1:0).animation(Animation.easeOut(duration: suprise ? 0.6:0).delay(1))
                    Text("絲").font(.largeTitle).foregroundColor(.black).fontWeight(.heavy).padding().background(Color.init(red: 249/255, green: 22/255, blue: 0/255)).cornerRadius(20).frame(height:90).opacity(suprise ? 1:0).animation(Animation.easeOut(duration: suprise ? 0.6:0).delay(1.5))
                    Image("logo").resizable().scaledToFit().frame(width:90,height: 90).opacity(suprise ? 1:0).animation(Animation.easeOut(duration: suprise ? 0.6:0).delay(2))
                }
            }.onTapGesture {
                self.suprise=false
            }
        }
    }
}
struct analysis_Previews: PreviewProvider {
    static var previews: some View {
        analysis(songdata: songData())
    }
}

struct schedule: View {
    var pro:CGFloat
    var index:Int
    let members=["八三夭","林俊傑","周湯豪","周杰倫"]
    var showsuprise:Bool
    @Binding var suprise:Bool
    let colorset:[Color]=[Color(red: 255/255, green: 50/255, blue: 5/255),Color(red: 5/255, green: 250/255, blue: 50/255),Color(red: 2/255, green: 50/255, blue: 255/255),Color(red: 255/255, green: 1/255, blue: 255/255)]

    var body: some View {
        Group{
            HStack{
                Text("成為\(members[index])頭號粉絲").padding()
                if(showsuprise){
                        Spacer()
                    Text("驚喜點我").foregroundColor(Color.red).padding(5).background(Color(red: 254/255, green: 254/255, blue: 126/255)).cornerRadius(20).padding(10).onTapGesture {
                        self.suprise = true
                    }
                    Spacer()

                }

            }
            ZStack(alignment: .leading){
                Rectangle().fill(Color.init(red: 150/255, green: 150/255, blue: 150/255)).frame(width:300,height: 20)
                Rectangle().fill(colorset[index]).frame(width:pro,height: 20)
            }.cornerRadius(20).padding(.init(top: 0, leading: 32, bottom: 0, trailing: 0))
            Spacer()
        }
    }
}
