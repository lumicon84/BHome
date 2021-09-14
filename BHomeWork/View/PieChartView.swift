//
//  PieChartView.swift
//  BHomeWork
//
//  Created by Oh june Kwon on 2021/09/14.
//

import Foundation
import UIKit

class PieChartView: UIView, CAAnimationDelegate {
    
    let circleLayer: CAShapeLayer = CAShapeLayer()
    
    var myCenter = CGPoint.zero
    var items: [CoinModel]?
    
    func update(_ items:[CoinModel]) -> UIView {
        self.items = items
        return self
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        self.myCenter = CGPoint(x: rect.midX, y: rect.midY)
        self.startAnimation()
        
    }
    
    func startAnimation() {
        guard let items = self.items else { return }
        let total = CGFloat(items.reduce(0) { total, item in
            return total + item.coinShare
        })
        var startAngle: CGFloat = (-(.pi) / 2)
        var endAngle: CGFloat = 0.0
        
        UIColor.clear.set()
        
        items.forEach { (value) in
            endAngle = (CGFloat(value.coinShare) / total) * (.pi * 2)

            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center,
                        radius: 60,
                        startAngle: startAngle,
                        endAngle: startAngle + endAngle,
                        clockwise: true)

            UIColorFromRGB(value.coinColor).set()
            path.fill()
            startAngle += endAngle
            path.close()
            path.stroke()
        }
        
    }
    
    // #FFFFFF
    func UIColorFromRGB(_ rgbValue: String) -> UIColor! {
        var hexInt: UInt64 = 0
        let scanner = Scanner.init(string: rgbValue)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt64(&hexInt)
        
        return UIColor(
            red: CGFloat((Float((hexInt & 0xff0000) >> 16)) / 255.0),
            green: CGFloat((Float((hexInt & 0x00ff00) >> 8)) / 255.0),
            blue: CGFloat((Float((hexInt & 0x0000ff) >> 0)) / 255.0),
            alpha: 1.0)
    }
}
