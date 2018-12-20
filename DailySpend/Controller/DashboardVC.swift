//
//  DashboardVC.swift
//  DailySpend
//
//  Created by apple on 20/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet weak var semicircleView: UIView!
    var semiCirleLayer: CAShapeLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(createSemiCircleView), with: nil, afterDelay: 0)
    }
    

    @objc func createSemiCircleView() {
        if semiCirleLayer == nil {
            let arcCenter = CGPoint(x: semicircleView.bounds.size.width / 2, y: semicircleView.bounds.size.height / 1.5)
            let circleRadius = semicircleView.bounds.size.width / 2.5
            let circlePath = UIBezierPath(arcCenter: arcCenter, radius: circleRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
            
            semiCirleLayer = CAShapeLayer()
            semiCirleLayer.path = circlePath.cgPath
            semiCirleLayer.fillColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.62).cgColor
            semicircleView.layer.addSublayer(semiCirleLayer)
            
            // Make the view color transparent
            semicircleView.backgroundColor = UIColor.clear
        }
    }

}
