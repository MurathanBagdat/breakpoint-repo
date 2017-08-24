//
//  ShadowView.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    
    func setupView(){
        self.layer.shadowOpacity = 0.75
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
    }
}
