//
//  RecordingRow.swift
//  recoder
//
//  Created by 陳昱豪 on 2019/11/21.
//  Copyright © 2019 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI
struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}
struct RecordingRow: View {
    @State private var showingSheet = false
    var singer:String
    var audioURL: URL
    @ObservedObject var audioPlayer = AudioPlayer()
    var body: some View {
        HStack {
            Text("\(singer)-\(audioURL.lastPathComponent)")
            Spacer()
                Image(systemName: "square.and.arrow.up")
                    .imageScale(.large).onTapGesture {
                        self.showingSheet = true
            }
            .sheet(isPresented: $showingSheet,
                   content: {
                    ActivityView(activityItems: [self.audioURL] as [Any], applicationActivities: nil) })
            if audioPlayer.isPlaying == false {
                    Image(systemName: "play.circle")
                        .imageScale(.large).onTapGesture {
                            self.audioPlayer.startPlayback(audio: self.audioURL)
                    }
            }
            else {
            Button(action: {
                print("Stop playing audio")
                self.audioPlayer.stopPlayback()
            }) {
                Image(systemName: "stop.fill")
                    .imageScale(.large)
            }
        }
        }.frame(minWidth: 0, maxWidth: .infinity)
        .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.init( red: 228/255, green: 114/255, blue: 246/255), Color.init( red: 71/255, green: 191/255, blue: 250/255)]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(40)
        .padding(.horizontal, 20)
    }
}

/*struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordingRow(audioURL: )
    }
}*/
