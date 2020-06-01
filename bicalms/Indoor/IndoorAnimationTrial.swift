//
//  IndoorAnimationTrial.swift
//  bicalms
//
//  Created by Eko Cahyo on 01/06/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI
import AVFoundation

struct IndoorAnimationTrial: UIViewRepresentable {
    var videoUrl: String?
    
    func makeUIView(context: Context) -> UIView {
        let queueView = QueuePlayerUIViewIndoorTrial(frame: .zero)
        queueView.videoUrl = videoUrl
        return queueView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

class QueuePlayerUIViewIndoorTrial: UIView {
    public var playerLayer = AVPlayerLayer()
    public var playerLooper: AVPlayerLooper?
    var videoUrl: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load video
        let fileUrl = Bundle.main.url(forResource: "D1 - Toy Soldiers", withExtension: "mp4")!
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

struct IndoorAnimationTrial_Previews: PreviewProvider {
    static var previews: some View {
        IndoorAnimationTrial()
    }
}

