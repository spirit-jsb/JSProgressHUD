//
//  JSSectorProgressView.swift
//  JSHUD
//
//  Created by Max on 2018/11/22.
//  Copyright © 2018 Max. All rights reserved.
//

import UIKit

public class JSSectorProgressView: UIView {

    // MARK: 属性
    @objc var progress: Float = 0.0 {
        willSet {
            if newValue < 0.0 || newValue > 1.0 {
                return
            }
            self.setNeedsDisplay()
        }
    }
    
    @objc dynamic var progressTintColor: UIColor! {
        didSet {
            if self.progressTintColor != oldValue {
                self.setNeedsDisplay()
            }
        }
    }
    
    @objc dynamic var trackTintColor: UIColor! {
        didSet {
            if self.trackTintColor != oldValue {
                self.setNeedsDisplay()
            }
        }
    }
    
    // MARK: 初始化
    convenience init() {
        self.init(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 设置方法
    private func setupView() {
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
    }
    
    // MARK: 重写父类方法
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 40.0, height: 40.0)
    }
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let lineWidth: CGFloat = 1.0
        let circleRect = self.bounds.insetBy(dx: lineWidth / 2.0, dy: lineWidth / 2.0)
        
        // Draw background
        context?.setLineWidth(1.0)
        context?.setStrokeColor(self.progressTintColor.cgColor)
        context?.setFillColor(self.trackTintColor.cgColor)
        
        context?.strokeEllipse(in: circleRect)
        
        // Draw progress
        let progressPath = UIBezierPath()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = (rect.height / 2.0) - 1.5
        let startAngle: CGFloat = -(.pi / 2.0)
        let endAngle = (CGFloat(self.progress) * 2.0 * .pi) + startAngle
        
        progressPath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressPath.addLine(to: center)
        
        context?.setBlendMode(.copy)
        
        self.progressTintColor.set()
        
        progressPath.fill()
    }
}
