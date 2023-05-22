//
//  NavigationAndTabBarHelper.swift
//  Selection
//
//  Created by Muhammed Emin Bardakcı on 18.05.2023.
//

import UIKit

struct NavigationAndTabBarHelper {
    
    static func configureNavigationController() {
        UINavigationBar.appearance().barTintColor = Constant.backgroundColor
        UINavigationBar.appearance().tintColor = Constant.appColor
        //UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        //UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    static func configureTabbarController() {
        UITabBar.appearance().barTintColor = Constant.backgroundColor
        UITabBar.appearance().tintColor = Constant.appColor
    }
}
