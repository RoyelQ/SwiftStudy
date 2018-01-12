//
//  PromotViewController.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/9.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

class PromotViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.addBackButton {
          
            self.backAction()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
