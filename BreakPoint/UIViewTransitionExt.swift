//
//  UIViewTransitionExt.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 26.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit


extension UIViewController{
    
    func presentDetail(_ viewControllerToPresent : UIViewController){
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        
        self.view.window?.layer.add(transition, forKey: kCATransition)

        dismiss(animated: true, completion: nil)

    }
}
