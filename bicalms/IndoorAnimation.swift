//
//  IndoorAnimation.swift
//  bicalms
//
//  Created by Eko Cahyo on 27/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI
import AVFoundation

struct IndoorAnimation: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIViewIndoor(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

class PlayerUIViewIndoor: UIView {
    private var playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Load video
        let fileUrl = Bundle.main.url(forResource: "D6", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        // Setup Video
        let player = AVPlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
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

struct IndoorAnimation_Previews: PreviewProvider {
    static var previews: some View {
        IndoorAnimation()
    }
}
