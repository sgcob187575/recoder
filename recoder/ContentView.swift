//
//  ContentView.swift
//  recoder
//
//  Created by 陳昱豪 on 2019/11/21.
//  Copyright © 2019 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @State private var showEditorRecord=false
    @State private var showanalysis=false
    @ObservedObject var songdata=songData()
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Text("錄音列表").font(Font.system(size: 40)).padding().offset(y:-20)
                    Spacer()
                Text("統計").foregroundColor(Color.white).padding(5).background(Color(red: 20/255, green: 190/255, blue: 230/255)).cornerRadius(20).padding(10).onTapGesture {
                        self.showanalysis = true
                    }
                    
                }
                Spacer()
                if audioRecorder.recordings.count==0{
                    Text("No File...").font(.system(size: 50)).offset(y:-20)
                    Spacer()
                    
                }
                else{
                    RecordingsList(audioRecorder: audioRecorder, songdata: songdata)
                    Spacer()
                    
                }
            }.navigationBarItems(leading:EditButton(),trailing: Button(action: {self.showEditorRecord = true}, label:{Image(systemName :  "plus.circle.fill")})).sheet(isPresented: $showEditorRecord){NavigationView{ recordAdd(audioRecorder: self.audioRecorder,songdata:self.songdata)}
                
                
            }
        }.sheet(isPresented: self.$showanalysis){
            NavigationView{
                analysis(songdata: self.songdata)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder())
    }
}
