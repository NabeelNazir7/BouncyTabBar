//
//  ViewController.swift
//  Example
//
//  Created by Shahbaz Saleem on 1/21/20.
//  Copyright © 2020 No Organization. All rights reserved.
//

import UIKit
import BouncyTabBar

class ViewController: BouncyTabBarViewController, BouncyTabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bouncyTabbarDelegate = self
        BouncyTabBarSetting.tabBarTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        BouncyTabBarSetting.tabBarCircleSize = CGSize(width: 20, height: 20)
        BouncyTabBarSetting.tabBarCircleColor = UIColor.red
        BouncyTabBarSetting.tabbarBackgroundColor = .black
        BouncyTabBarSetting.tabBarHeight = 80
        BouncyTabBarSetting.tabbarTitleTopOffset = 15
        BouncyTabBarSetting.titleColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HOME_ID")
        let chatStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CHAT_ID")
        let sleepStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SLEEP_ID")
        let musicStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MUSIC_ID")
        let meStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ME_ID")
        
        homeStoryboard.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_Selected"))
        chatStoryboard.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(named: "chat"), selectedImage: UIImage(named: "chat_Selected"))
        sleepStoryboard.tabBarItem = UITabBarItem(title: "Sleep", image: UIImage(named: "moon"), selectedImage: UIImage(named: "moon_Selected"))
        musicStoryboard.tabBarItem = UITabBarItem(title: "Music", image: UIImage(named: "music"), selectedImage: UIImage(named: "music_Selected"))
        meStoryboard.tabBarItem = UITabBarItem(title: "Me", image: UIImage(named: "menu"), selectedImage: UIImage(named: "menu_Selected"))
        
        viewControllers = [homeStoryboard, chatStoryboard,sleepStoryboard,musicStoryboard,meStoryboard]
        
        selectedIndex = 3
        
    }
    
    func bouncyTabBar(didSelectTabAt index: Int) {
        viewControllers[index].tabBarItem.title = "abc"
    }
}
