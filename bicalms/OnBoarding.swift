//
//  OnBoarding.swift
//  bicalms
//
//  Created by Rifki Triaditiya Putra on 27/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import UIKit

class OnBoarding: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelText1: UILabel!
    @IBOutlet weak var labelText2: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
   
    var tampilan: [String] = ["OnBoarding1", "OnBoarding2", "OnBoarding3"]
    var frame = CGRect.zero
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = tampilan.count
        setupScreens()

        scrollView.delegate = self
    }
    func setupScreens() {
        for index in 0..<tampilan.count {
            // 1.
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            // 2.
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: tampilan[index])

            self.scrollView.addSubview(imgView)
        }

        // 3.
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(tampilan.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}
