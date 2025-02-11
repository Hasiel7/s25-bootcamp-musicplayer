//
//  ContentView.swift
//  Apple Music Recreation
//
//  Created by Jahaziel Herberth Martinez on 2/9/25.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var player: AVPlayer? = nil
    let Smokey = Color(red: 10/255, green: 6/255, blue: 9/255)
    let TranceColor = Color(red: 0.051, green: 0.024, blue: 0.043)

    var body: some View {
        ZStack {
            VStack{
                Image(systemName: "chevron.compact.up")
                    .foregroundStyle(.white)
                    .padding(.top, 60)

                VideoPlayer(player: player)
                    .frame(height: 400)
                    .opacity(0.97)
                    .cornerRadius(16)
                    .padding(.top , 50)
                    .ignoresSafeArea()
                    
                HStack{
                    Text("Trance")
                        .foregroundColor(.white)
                        .padding(.bottom, 300)
                        .fontWeight(.bold)
                }
            }
            .ignoresSafeArea()
    
        }
        .background(
                    LinearGradient(
                        gradient: Gradient(colors:[TranceColor, Smokey]),
                                startPoint:.top,
                                endPoint:.bottom
                    )
            )
        .ignoresSafeArea()
        
        .onAppear {
            playVideo()
        }
    }

    private func playVideo() {
        if let url = Bundle.main.url(forResource: "trance", withExtension: "mov") {
            let avPlayer = AVPlayer(url: url)
            avPlayer.actionAtItemEnd = .none

        
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: avPlayer.currentItem,
                queue: .main
            ) { _ in
                avPlayer.seek(to: .zero)
                avPlayer.play()
            }

            avPlayer.play()
            player = avPlayer
        }
    }
}

#Preview {
    ContentView()
}

