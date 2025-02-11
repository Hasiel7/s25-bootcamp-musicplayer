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
    
    let Smokey = Color(red: 9/255, green: 6/255, blue: 9/255)
    let TranceColor = Color(red: 14/255, green: 8/255, blue: 11/255)
    
    @State private var currentTime: Double  = 0
    @State private var totalTime: Double  = 195


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
                    VStack{
                        Text("Trance")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(maxWidth: 275, alignment: .leading)

                        Text("MetroBoomin, Travis Scott & Young Thug")
                            .animation(.bouncy)
                            .foregroundColor(.gray)
                            .frame(maxWidth: 275, alignment: .leading)
                    }
                    .padding(.horizontal, 5)
                    Image(systemName: "star.circle")
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .fontWeight(.semibold)
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        
                }
            
                HStack{
                    VStack{
                        Slider(value: $currentTime, in: 0...totalTime)
                            .accentColor(.gray)
                            
                        HStack{
                            Text(timeString(from: currentTime))
                                .foregroundColor(.gray)
                                .font(.footnote)
                            Spacer()
                            Text(timeString(from: totalTime))
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        
                    }
                }
                .padding(.bottom, 300)
                .padding(.horizontal)
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
    private func timeString(from seconds: Double) -> String{
        let minutes = Int(seconds) / 60
        let remainingSeconds = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
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

