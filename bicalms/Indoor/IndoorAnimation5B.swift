//
//  IndoorAnimation5B.swift
//  bicalms
//
//  Created by Eko Cahyo on 01/06/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI
import AVFoundation

struct IndoorAnimation5B: UIViewRepresentable {
    var videoUrl: String?
    
    func makeUIView(context: Context) -> UIView {
    return QueuePlayerUIViewIndoor5B(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

class QueuePlayerUIViewIndoor5B: UIView {
    
    public var playerLayer = AVPlayerLayer()
    public var playerLooper: AVPlayerLooper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load video
        let fileUrl = Bundle.main.url(forResource: "D5 - Curtsy Lunge (right)", withExtension: "mp4")!
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

struct IndoorAnimation5B_Previews: PreviewProvider {
    static var previews: some View {
        IndoorAnimation5B()
    }
}
