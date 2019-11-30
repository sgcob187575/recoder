//
//  RecordingsList.swift
//  recoder
//
//  Created by 陳昱豪 on 2019/11/21.
//  Copyright © 2019 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI

struct RecordingsList: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var songdata:songData
    var body: some View {
        List{
            Section{
                ForEach (audioRecorder.recordings.indices, id: \.self) { (index) in
                    NavigationLink(destination: recordAdd(audioRecorder: self.audioRecorder, songdata: self.songdata,editsong:self.songdata.songs[index],editindex:index)
                ){
                    RecordingRow(singer:self.songdata.songs[index].singer,audioURL:self.audioRecorder.recordings[index].fileURL)

                            }
                            
                        }.onDelete(perform: delete)
            }
            
        }
    }
    func delete(at offsets: IndexSet) {
        for index in offsets {
            self.songdata.songs.remove(at:index)
        }
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)

    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList(audioRecorder: AudioRecorder(),songdata:songData())
    }
}
