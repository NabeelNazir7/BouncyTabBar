//
//  BouncyTabBarViewController.swift
//  BouncyTabBar
//
//  Created by Shahbaz Saleem on 1/21/20.
//  Copyright © 2020 No Organization. All rights reserved.
//

import UIKit
@available(iOS 10.0, *)
open class BouncyTabBarViewController: UIViewController, BouncyTabBarDelegate {
    
    public var selectedIndex: Int = 0
    public var previousSelectedIndex = 0
    
    public var viewControllers: [UIViewController]! {
        didSet {
            drawConstraint()
        }
    }
    
    private lazy var soTabBar: BouncyTabBarView = {
        let soBarView = BouncyTabBarView()
        soBarView.viewControllers = viewControllers
        soBarView.setupView()
        soBarView.tabBarDelegate = self
        self.view.addSubview(soBarView)
        return soBarView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        self.view.addSubview(view)
        return view
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func drawConstraint() {
        let safeAreaView = UIView()
        safeAreaView.backgroundColor = BouncyTabBarSetting.tabBarBackground
        self.view.addSubview(safeAreaView)
        
        var constraints = [NSLayoutConstraint]()
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            constraints.append(containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0))
           } else {
            constraints.append(containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(BouncyTabBarSetting.tabBarHeight)))
        }
        constraints.append(containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(containerView.topAnchor.constraint(equalTo: view.topAnchor))
        
        soTabBar.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            constraints.append(soTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
           } else {
            constraints.append(soTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        }
        constraints.append(soTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(soTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(soTabBar.heightAnchor.constraint(equalToConstant: BouncyTabBarSetting.tabBarHeight))
        
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(safeAreaView.topAnchor.constraint(equalTo: soTabBar.bottomAnchor))
        constraints.append(safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor))

        view.bringSubviewToFront(soTabBar)
        view.bringSubviewToFront(safeAreaView)
        constraints.forEach({ $0.isActive = true })
    }
    
    open func bouncyTabBar(_ tabBar: BouncyTabBarView, didSelectTabAt index: Int) {
        
        let previousVC = viewControllers?[previousSelectedIndex]
        previousVC?.willMove(toParent: nil)
        previousVC?.view.removeFromSuperview()
        previousVC?.removeFromParent()
        previousVC?.didMove(toParent: nil)
        previousSelectedIndex = (index - 1) < 0 ? 0 : index - 1
        
        let vc = viewControllers[index]
        addChild(vc)
        selectedIndex = index
        vc.view.frame = containerView.bounds
        vc.willMove(toParent: self)
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
}


// Here you can customize the tab bar to meet your neededs

public struct BouncyTabBarSetting {
    
    public static var tabBarHeight: CGFloat = 66
    public static var tabBarTintColor: UIColor = UIColor(red: 250/255, green: 51/255, blue: 24/255, alpha: 1)
    public static var tabBarBackground: UIColor = UIColor.white
    public static var tabBarCircleSize = CGSize(width: 65, height: 65)
    public static var tabBarSizeImage: CGFloat = 25
    public static var tabBarShadowColor = UIColor.lightGray.cgColor
    public static var tabBarSizeSelectedImage: CGFloat = 20
    public static var tabBarAnimationDurationTime: Double = 0.4
    
}


// use this protocol to detect when a tab bar item is pressed
@available(iOS 10.0, *)
protocol BouncyTabBarDelegate: AnyObject {
     func bouncyTabBar(_ tabBar: BouncyTabBarView, didSelectTabAt index: Int)
}

