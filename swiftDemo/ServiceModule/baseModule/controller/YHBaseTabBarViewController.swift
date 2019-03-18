//
//  YHBaseTabBarViewController.swift
//  swiftDemo
//
//  Created by yinghu on 2019/3/15.
//  Copyright © 2019 yinghu. All rights reserved.
//

import UIKit

class YHBaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let v1  = YHFirstViewController ()
        let item1 : UITabBarItem = UITabBarItem (title: "首页", image: UIImage(named: "tabbar_首页"), selectedImage: UIImage(named: "tabbar_首页_highlight_new"))
        v1.tabBarItem = item1
        
        
        let v2 = YHSecondViewController()
        let item2 : UITabBarItem = UITabBarItem (title: "产品", image: UIImage(named: "tabbar_产品"), selectedImage: UIImage(named: "tabbar_产品_highlight_new"))
        v2.tabBarItem = item2
        
        let v3 = YHThirdViewController()
        let item3 : UITabBarItem = UITabBarItem (title: "保问", image: UIImage(named: "tabbar_保问"), selectedImage: UIImage(named: "tabbar_保问_highlight_new"))
        v3.tabBarItem = item3
        
        let tabArray = [v1, v2, v3]
        self.viewControllers = tabArray
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
