//
//  TextFieldWithInsets.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class TextFieldWithInsets: UITextField {

    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
    func setupView(){
        
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        self.attributedPlaceholder = placeholder
    }
}
