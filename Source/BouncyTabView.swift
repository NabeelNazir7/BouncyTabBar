//
//  BouncyTabView.swift
//  BouncyTabBar
//
//  Created by Shahbaz Saleem on 1/21/20.
//  Copyright © 2020 No Organization. All rights reserved.
//

import UIKit
@available(iOS 10.0, *)
class BouncyTabView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        lbl.textColor = BouncyTabBarSetting.titleColor
        lbl.font = BouncyTabBarSetting.titleFontStyle
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var tabImageView: UIImageView = {
        return UIImageView()
    }()
    
    init(tabBar: UITabBarItem){
        super.init(frame: .zero)
        guard let selecteImage = tabBar.image else {
            fatalError("You should set image to all view controllers")
        }
        tabImageView = UIImageView(image: selecteImage)
        tabImageView.contentMode = .scaleAspectFit
        tabImageView.image = tabImageView.image?.withRenderingMode(.alwaysTemplate)
        tabImageView.tintColor = BouncyTabBarSetting.tabBarTintColor
        titleLabel.text = tabBar.title ?? ""
        drawConstraints()
    }
    
    internal func updateSelectedTab(){
        titleLabel.font = BouncyTabBarSetting.selectedTabTitleFont
        tabImageView.tintColor = BouncyTabBarSetting.selectedTabTintColor
    }
    
    internal func updateUnSelectedTab(){
        titleLabel.font = BouncyTabBarSetting.titleFontStyle
        tabImageView.tintColor = BouncyTabBarSetting.tabBarTintColor
    }
    
    private func drawConstraints() {
        self.addSubview(titleLabel)
        self.addSubview(tabImageView)
        var constraints = [NSLayoutConstraint]()
        
        tabImageView.translatesAutoresizingMaskIntoConstraints = false
//        constraints.append(tabImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        constraints.append(tabImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -BouncyTabBarSetting.tabbarTitleTopOffset))
        constraints.append(tabImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(tabImageView.heightAnchor.constraint(equalToConstant: BouncyTabBarSetting.tabBarSizeImage))
        constraints.append(tabImageView.widthAnchor.constraint(equalToConstant: BouncyTabBarSetting.tabBarSizeImage))
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor))
//        constraints.append(titleLabel.heightAnchor.constraint(equalToConstant: 26))
        constraints.forEach({ $0.isActive = true })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
