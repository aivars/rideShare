//
//  rounShadow.swift
//  rideSharing
//
//  Created by Aivars Meijers on 21.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit

class roundShadow: UIView {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

}