//
//  RoundedShadowButton.swift
//  rideSharing
//
//  Created by Aivars Meijers on 21.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {

    var origiSize: CGRect?
    
    func setupView(){
        origiSize = self.frame
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize.zero
        
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func animateButton(shouldLoad: Bool, withMessage message: String? ){
    
        let spiner = UIActivityIndicatorView()
        spiner.activityIndicatorViewStyle = .whiteLarge
        spiner.color = UIColor.darkGray
        spiner.alpha = 0.0
        spiner.hidesWhenStopped = true
        spiner.tag = 42
        
        if shouldLoad{
            self.addSubview(spiner)
            
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2, animations: { 
                self.layer.cornerRadius = self.frame.height / 2
                self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }, completion: { (finished) in
                if finished == true{
                    
                    spiner.startAnimating()
                    spiner.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.width / 2 + 1)
                    spiner.fadeTo(alphaValue: 1.0, withDuration: 0.2)
                    
                }
            })
            self.isUserInteractionEnabled = false
        }else{
            self.isUserInteractionEnabled = true
            
            for subview in self.subviews{
                if subview.tag == 42 {
                    subview.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: 0.2, animations: { 
                self.layer.cornerRadius = 5.0
                self.frame = self.origiSize!
                self.setTitle(message, for: .normal)
            })
            
        }
        

        
    }

}
