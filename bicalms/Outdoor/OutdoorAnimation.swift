//
//  RunningVideo.swift
//  bicalms
//
//  Created by Eko Cahyo on 26/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI
import AVFoundation

struct OutdoorAnimation: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        return QueuePlayerUIViewOutdoor(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

class QueuePlayerUIViewOutdoor: UIView {
    public var playerLayer = AVPlayerLayer()
    public var playerLooper: AVPlayerLooper?
    public var player: AVQueuePlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Load video
        let fileUrl = Bundle.main.url(forResource: "Run Animation", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        // Setup Video
        let player = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Looping Video
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        // Play
        player.play()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct OutdoorAnimation_Previews: PreviewProvider {
    static var previews: some View {
        OutdoorAnimation()
    }
}
