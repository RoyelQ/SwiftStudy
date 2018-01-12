//
//  HomeViewController.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/9.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.title = "首页"
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect.init(x: 100, y: Navi_Height + 50, width: 120, height: 40)
        button.setTitle("下一页", for: UIControlState.normal)
        button.backgroundColor = UIColor.brown
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.pro_tabBarController().setTabBarHidden(hidden: true)
    }

    @objc func buttonClick(sender : UIButton) -> Void {
        
        self.navigationController?.pushViewController(AssetsViewController(), animated: false)
    }

    
    
}
