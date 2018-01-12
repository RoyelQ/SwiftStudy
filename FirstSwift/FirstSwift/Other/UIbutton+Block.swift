//
//  UIbutton+Block.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/10.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    private struct ActionAssociateKeys{
        
        static var key = "Action_Associate_Key"
    }
    typealias ButtonBlock = () -> Void
    
    
    func addAction(block : ButtonBlock) -> Void {
        
        objc_setAssociatedObject(self, &ActionAssociateKeys.key, block, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(action(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    func addAction(block : ButtonBlock, controllerEvent : UIControlEvents) -> Void {
        
        objc_setAssociatedObject(self, &ActionAssociateKeys.key, block, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        self.addTarget(self, action: #selector(action(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc func action(sender : Any) -> Void {
        
        let blockAction = objc_getAssociatedObject(self, &ActionAssociateKeys.key) as! ButtonBlock
        blockAction()
    }
}

