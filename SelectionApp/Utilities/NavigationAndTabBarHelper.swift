//
//  NavigationAndTabBarHelper.swift
//  Selection
//
//  Created by Muhammed Emin Bardakcı on 18.05.2023.
//

import UIKit

struct NavigationAndTabBarHelper {
    
    static func configureForThisApp() {
        UINavigationBar.appearance().tintColor = Constant.appColor
        UITabBar.appearance().tintColor = Constant.appColor
    }
}
