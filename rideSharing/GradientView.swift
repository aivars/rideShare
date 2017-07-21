//
//  GradientView.swift
//  rideSharing
//
//  Created by Aivars Meijers on 21.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        setupGradienView()
    }
    
    func setupGradienView(){
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x:0, y:1)
        gradient.locations = [0.8, 1.0]
        self.layer.addSublayer(gradient)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
