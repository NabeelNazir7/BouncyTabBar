//
//  BouncyTabBarView.swift
//  BouncyTabBar
//
//  Created by Shahbaz Saleem on 1/21/20.
//  Copyright © 2020 No Organization. All rights reserved.
//

import UIKit
@available(iOS 10.0, *)
public class BouncyTabBarView: UIView {
    
   internal var viewControllers: [UIViewController]! {
        didSet {
            drawTabs()
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let innerCircleView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private let backgroundShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.yellow.cgColor
        return shape
    }()
    
//    private let outerCircleView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .red
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
//    private let tabSelectedImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    private var tabWidth: CGFloat {
        return UIScreen.main.bounds.width / CGFloat(viewControllers.count)
    }
    
    weak var tabBarDelegate: SOTabBarDelegate?
    
    private var selectedIndex: Int = 0
    private var previousSelectedIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        dropShadow()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        dropShadow()
    }
    
    private func dropShadow() {
        backgroundColor = .clear
        layer.shadowColor = SOTabBarSetting.tabBarShadowColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 3
    }
    
    internal func setupView() {
        drawBackground()
        drawConstraint()
        DispatchQueue.main.async { [weak self] in
            self?.didSelectTab(index: 0)
        }
    }
    
    private func drawBackground(){
        layer.addSublayer(backgroundShape)
    }
    
    private func drawTabs() {
        for vc in viewControllers {
            let barView = SOTabView(tabBar: vc.tabBarItem)
            barView.heightAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarHeight).isActive = true
            barView.translatesAutoresizingMaskIntoConstraints = false
            barView.isUserInteractionEnabled = false
            self.stackView.addArrangedSubview(barView)
        }
    }
    
    private func drawConstraint() {
        addSubview(stackView)
        addSubview(innerCircleView)
      
//        innerCircleView.addSubview(outerCircleView)
//        outerCircleView.addSubview(tabSelectedImageView)
 
        var constraints = [NSLayoutConstraint]()
        
        innerCircleView.frame.size = SOTabBarSetting.tabBarCircleSize
        innerCircleView.layer.cornerRadius = SOTabBarSetting.tabBarCircleSize.width / 2
        
//        outerCircleView.layer.cornerRadius = (innerCircleView.frame.size.height - 10) / 2
//        constraints.append(outerCircleView.centerYAnchor.constraint(equalTo: self.innerCircleView.centerYAnchor))
//        constraints.append(outerCircleView.centerXAnchor.constraint(equalTo: self.innerCircleView.centerXAnchor))
//        constraints.append(outerCircleView.heightAnchor.constraint(equalToConstant: innerCircleView.frame.size.height - 10))
//        constraints.append(outerCircleView.widthAnchor.constraint(equalToConstant: innerCircleView.frame.size.width - 10))
        
//        constraints.append(tabSelectedImageView.centerYAnchor.constraint(equalTo: outerCircleView.centerYAnchor))
//        constraints.append(tabSelectedImageView.centerXAnchor.constraint(equalTo: outerCircleView.centerXAnchor))
//        constraints.append(tabSelectedImageView.heightAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarSizeSelectedImage))
//        constraints.append(tabSelectedImageView.widthAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarSizeSelectedImage))
        
        stackView.frame = self.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        if #available(iOS 11.0, *) {
            constraints.append(stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))
        } else {
            constraints.append(stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        }
        constraints.append(stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(stackView.topAnchor.constraint(equalTo: self.topAnchor))
    
        constraints.forEach({ $0.isActive = true })
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touchArea = touches.first?.location(in: self).x else {
            return
        }
        let index = Int(floor(touchArea / tabWidth))
        didSelectTab(index: index)
    }
    
    private func didSelectTab(index: Int) {
        if index + 1 == selectedIndex {return}
//        animateTitle(index: index)
 
        previousSelectedIndex = selectedIndex
        selectedIndex  = index + 1
        
        tabBarDelegate?.soTabBar(self, didSelectTabAt: index)
        animateCircle(with: circlePath())
//        animateBackground(with: backgroundPath())
//        animateImage()
        
//        guard let image = self.viewControllers[index].tabBarItem.selectedImage else {
//            fatalError("You should insert selected image to all View Controllers")
//        }
//        self.tabSelectedImageView.image = image
    }
    
//    private func animateTitle(index: Int) {
//        for i in self.stackView.arrangedSubviews {
//            if i == stackView.arrangedSubviews[index] {
//                if let barView = self.stackView.arrangedSubviews[index] as? SOTabView {
//                    barView.animateTabSelected()
//                }
//            }else {
//                if let barView = i as? SOTabView {
//                    barView.animateTabDeSelect()
//                }
//            }
//        }
//    }
    
//    private func animateImage() {
//        tabSelectedImageView.alpha = 0
//        UIView.animate(withDuration: SOTabBarSetting.tabBarAnimationDurationTime) { [weak self] in
//            self?.tabSelectedImageView.alpha = 1
//        }
//    }
    
    private func circlePath() -> CGPath {
        let startPoint_X =  CGFloat(previousSelectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let endPoint_X = CGFloat(selectedIndex ) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let y = CGFloat(0)
        let controlPoint_Y = ((endPoint_X-startPoint_X)/2) > 0 ? -((endPoint_X-startPoint_X)/2) : ((endPoint_X-startPoint_X)/2)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startPoint_X, y: y))
        path.addQuadCurve(to: CGPoint(x: endPoint_X, y: y), controlPoint: CGPoint(x: startPoint_X + ((endPoint_X-startPoint_X)/2), y: controlPoint_Y))
//        path.addLine(to: CGPoint(x: endPoint_X, y: y))
        return path.cgPath
    }
    
    private func animateCircle(with path: CGPath) {
        liftTheCircle()
        fillTheHole()
//        let caframeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
//        caframeAnimation.path = path
//        caframeAnimation.duration = SOTabBarSetting.tabBarAnimationDurationTime
//        caframeAnimation.fillMode = .both
//        caframeAnimation.isRemovedOnCompletion = false
//        innerCircleView.layer.add(caframeAnimation, forKey: "circleLayerAnimationKey")
    }
    
    private func liftTheCircle(){
        let startPoint_X =  CGFloat(previousSelectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let y = CGFloat(0)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startPoint_X, y: y))
        path.addLine(to: CGPoint(x: startPoint_X, y: -CGFloat(SOTabBarSetting.tabBarCircleSize.height * 0.5)))
        
        let caframeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        caframeAnimation.path = path.cgPath
        caframeAnimation.duration = SOTabBarSetting.tabBarAnimationDurationTime * 0.2
        caframeAnimation.fillMode = .both
        caframeAnimation.isRemovedOnCompletion = false
        innerCircleView.layer.add(caframeAnimation, forKey: "circleLayerAnimationKey1")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + caframeAnimation.duration * 0.9) { [weak self] in
            self?.moveTheCircle()
            self?.moveTheHole()
        }
        
    }
    
    private func moveTheCircle(){
        let startPoint_X =  CGFloat(previousSelectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let endPoint_X = CGFloat(selectedIndex ) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let y = -CGFloat(SOTabBarSetting.tabBarCircleSize.height * 0.5)
        
        let controlPoint_Y = ((endPoint_X-startPoint_X)/2) > 0 ? -((endPoint_X-startPoint_X)/2) : ((endPoint_X-startPoint_X)/2)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startPoint_X, y: y))
        path.addQuadCurve(to: CGPoint(x: endPoint_X, y: y), controlPoint: CGPoint(x: startPoint_X + ((endPoint_X-startPoint_X)/2), y: controlPoint_Y))
        
        let caframeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        caframeAnimation.path = path.cgPath
        caframeAnimation.duration = SOTabBarSetting.tabBarAnimationDurationTime * 0.6
        caframeAnimation.fillMode = .both
        caframeAnimation.isRemovedOnCompletion = false
        innerCircleView.layer.add(caframeAnimation, forKey: "circleLayerAnimationKey2")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + caframeAnimation.duration * 0.9) { [weak self] in
            self?.dropTheCircle()
            self?.createTheHole()
        }
    }
    
    private func dropTheCircle(){
        let endPoint_X = CGFloat(selectedIndex ) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let y = -CGFloat(SOTabBarSetting.tabBarCircleSize.height * 0.5)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: endPoint_X, y: y))
        path.addLine(to: CGPoint(x: endPoint_X, y: CGFloat(0)))
        
        let caframeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        caframeAnimation.path = path.cgPath
        caframeAnimation.duration = SOTabBarSetting.tabBarAnimationDurationTime * 0.2
        caframeAnimation.fillMode = .both
        caframeAnimation.isRemovedOnCompletion = false
        innerCircleView.layer.add(caframeAnimation, forKey: "circleLayerAnimationKey3")
        
    }
    
    private func fillTheHole(){
        let startPoint_X =  CGFloat(previousSelectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let circleSize = SOTabBarSetting.tabBarCircleSize
        
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        
        let firstCurveStart = CGPoint(x: startPoint_X - (circleSize.width) - 4, y: 0)
        path.addLine(to: firstCurveStart)
        
        
        path.addLine(to: CGPoint(x: startPoint_X - circleSize.width * 0.5 - 4, y: 0))
        
        path.addLine(to: CGPoint(x: startPoint_X + circleSize.width * 0.5 + 4, y: 0))
        
        path.addLine(to: CGPoint(x: startPoint_X + circleSize.width + 4, y: 0))
        
        path.addLine(to: CGPoint(x: frame.size.width, y: 0))
        path.addLine(to: CGPoint(x: frame.size.width, y: SOTabBarSetting.tabBarHeight))
        path.addLine(to: CGPoint(x: 0, y: SOTabBarSetting.tabBarHeight))
        path.close()
        
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = SOTabBarSetting.tabBarAnimationDurationTime * 0.2
        animation.fromValue = backgroundShape.path
        animation.toValue = path.cgPath
        animation.isRemovedOnCompletion = false
        backgroundShape.add(animation, forKey: "circleLayerAnimationKey4")
        backgroundShape.path = path.cgPath
    }
    
    private func moveTheHole(){
        let endPoint_X = CGFloat(selectedIndex ) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let circleSize = SOTabBarSetting.tabBarCircleSize
        
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        
        let firstCurveStart = CGPoint(x: endPoint_X - (circleSize.width) - 4, y: 0)
        path.addLine(to: firstCurveStart)
        
        
        path.addLine(to: CGPoint(x: endPoint_X - circleSize.width * 0.5 - 4, y: 0))
        
        path.addLine(to: CGPoint(x: endPoint_X + circleSize.width * 0.5 + 4, y: 0))
        
        path.addLine(to: CGPoint(x: endPoint_X + circleSize.width + 4, y: 0))
        
        path.addLine(to: CGPoint(x: frame.size.width, y: 0))
        path.addLine(to: CGPoint(x: frame.size.width, y: SOTabBarSetting.tabBarHeight))
        path.addLine(to: CGPoint(x: 0, y: SOTabBarSetting.tabBarHeight))
        path.close()
        
        
//        let animation = CABasicAnimation(keyPath: "path")
//        animation.duration = SOTabBarSetting.tabBarAnimationDurationTime * 0.8
//        animation.fromValue = backgroundShape.path
//        animation.toValue = path.cgPath
//        animation.isRemovedOnCompletion = false
//        backgroundShape.add(animation, forKey: "circleLayerAnimationKey4")
        backgroundShape.path = path.cgPath
    }
    
    private func createTheHole(){
        animateBackground(with: backgroundPath())
    }
    
    private func backgroundPath() -> CGPath{
        let endPoint_X = CGFloat(selectedIndex ) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let circleSize = SOTabBarSetting.tabBarCircleSize
        
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        
        let firstCurveStart = CGPoint(x: endPoint_X - (circleSize.width) - 4, y: 0)
        path.addLine(to: firstCurveStart)
        
        
        let curve1_to = CGPoint(x: endPoint_X - circleSize.width * 0.5 - 4, y: circleSize.height * 0.25)
        let curve1_cp = CGPoint(x: curve1_to.x - ((curve1_to.x - firstCurveStart.x) * 0.25), y: curve1_to.y * 0.25)
        path.addQuadCurve(to: curve1_to, controlPoint: curve1_cp)
        
        let curve2_to = CGPoint(x: endPoint_X + circleSize.width * 0.5 + 4, y: curve1_to.y)
        let curve2_cp = CGPoint(x: endPoint_X, y: circleSize.height + 4)
        path.addQuadCurve(to: curve2_to, controlPoint: curve2_cp)

        let curve3_to = CGPoint(x: endPoint_X + circleSize.width + 4, y: 0)
        let curve3_cp = CGPoint(x: curve3_to.x - ((curve3_to.x - curve2_to.x) * 0.75), y: curve1_to.y * 0.25)
        path.addQuadCurve(to: curve3_to, controlPoint: curve3_cp)
        
        path.addLine(to: CGPoint(x: frame.size.width, y: 0))
        path.addLine(to: CGPoint(x: frame.size.width, y: SOTabBarSetting.tabBarHeight))
        path.addLine(to: CGPoint(x: 0, y: SOTabBarSetting.tabBarHeight))
        path.close()
        return path.cgPath
    }
    
    private func animateBackground(with path: CGPath){
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = SOTabBarSetting.tabBarAnimationDurationTime * 0.2
        animation.fromValue = backgroundShape.path
        animation.toValue = path
        animation.isRemovedOnCompletion = false
        backgroundShape.add(animation, forKey: "circleLayerAnimationKey5")
        backgroundShape.path = path

    }
}
