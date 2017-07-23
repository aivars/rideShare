//
//  RoundedCornerTextField.swift
//  rideSharing
//
//  Created by Aivars Meijers on 23.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit

class RoundedCornerTextField: UITextField {

    var textRecOffset: CGFloat = 20
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0 + textRecOffset, y: 0 + (textRecOffset / 2), width: self.frame.width - textRecOffset
            , height: self.frame.height + textRecOffset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0 + textRecOffset, y: 0 + (textRecOffset / 2), width: self.frame.width - textRecOffset
            , height: self.frame.height + textRecOffset)
    }

}
