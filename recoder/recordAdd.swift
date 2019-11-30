//
//  recordAdd.swift
//  recoder
//
//  Created by 陳昱豪 on 2019/11/21.
//  Copyright © 2019 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI

struct recordAdd: View {
   @Environment(\.presentationMode)var presentationMode
    @ObservedObject var audioRecorder: AudioRecorder
    var songdata:songData
    @State private var showAlert = false
    @State private var filename = ""
    @State private var singer = "八三夭"
    var editsong:Songinfo?
    var editindex:Int?
    @State private var disabletext=false
    var body: some View {
        VStack{
            if disabletext{
                Image(self.singer).resizable().scaledToFit().frame(width:300)
            }
            filenameText(filename: self.$filename,disabletext: self.$disabletext,showAlert: self.$showAlert)

            singerPicker(singer: self.$singer)
            if !disabletext{
            if audioRecorder.recording == false  {
                    Button(action: {
                        if self.filename==""{
                            self.showAlert = true
                        }
                        else{
                        self.audioRecorder.filename=self.filename
                            self.audioRecorder.startRecording()
                            
                        }
                    }){
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                }.alert(isPresented: $showAlert) { () -> Alert in
                    var answer=""
                    if disabletext{
                        answer = "不能更改檔名"
                    }
                    else{
                        answer = "請輸入想儲存的檔名"

                    }
                    return Alert(title: Text(answer))}
                } else {
                    Button(action: {
                        let song=Songinfo(filename: self.filename, singer: self.singer)
                        self.songdata.songs.insert(song, at: self.songdata.songs.count)

                        self.audioRecorder.stopRecording()
                    }) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
                }
            else{
                Spacer()
            }
        }.onAppear(){
            print(self.songdata.songs.count)
            print(self.audioRecorder.recordings.count)
        }.navigationBarTitle(editsong==nil ? "Add new song":"Edit song").navigationBarItems(trailing: Button("Save"){
            let song=Songinfo(filename: self.filename, singer: self.singer)
            if self.editsong != nil{
                let index=self.editindex
                print("editindex:\(index!)")
                self.songdata.songs[index!]=song
                print(self.songdata.songs[index!].filename)
            }
            /*else{
                self.songdata.songs.insert(song, at: 0)
            }*/
        self.presentationMode.wrappedValue.dismiss()}).onAppear{
            if let editsong=self.editsong{
            self.filename=editsong.filename
                self.singer=editsong.singer
                self.disabletext=true
            }
        }
        }
    }

struct recordAdd_Previews: PreviewProvider {
    static var previews: some View {
        recordAdd(audioRecorder: AudioRecorder(),songdata:songData())
    }
}



struct singerText: View {
    @Binding var singer:String
    var body: some View {
        TextField("歌手", text: self.$singer).padding().overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 3))
    }
}

struct filenameText: View {
    @Binding var filename:String
    @Binding var disabletext:Bool
    @Binding var showAlert:Bool
    var body: some View {
        TextField("檔名", text: self.$filename).padding().overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 3)).disabled(disabletext).onTapGesture {

            if self.disabletext{
                self.showAlert=true
                print("aaa")
            }
        }.alert(isPresented: $showAlert) { () -> Alert in
        var answer=""
        if disabletext{
            answer = "不能更改檔名"
        }
        else{
            answer = "請輸入想儲存的檔名"

        }
        return Alert(title: Text(answer))}
    }
}

struct singerPicker: View {
    @Binding var singer:String
    let members=["八三夭","林俊傑","周湯豪","周杰倫"]
    var body: some View {
        Picker("最愛的成員",selection: self.$singer){
            ForEach(members, id:\.self) { role in
                Text(role)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
}
