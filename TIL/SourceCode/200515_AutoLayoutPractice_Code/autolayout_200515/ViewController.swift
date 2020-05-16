//
//  ViewController.swift
//  autolayout_200515
//
//  Created by 김광수 on 2020/05/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let redView: UIView = {
        var view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let blueView: UIView = {
        var view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        view.addSubview(blueView)

    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print("---viewSafeAreaInsetsDidChange--")
        print(view.safeAreaInsets)
        
    }
    
    // layout를 변경하기 위한 목적으로는  바로 아래에 작성 필요
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        /*
         
         [강사님 ]
         override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           let margin: CGFloat = 20
           let padding: CGFloat = 10
           let safeLayoutInsets = view.safeAreaInsets
           let horizontalInset = safeLayoutInsets.left + safeLayoutInsets.right
           
           let yOffset = safeLayoutInsets.top + margin
           let viewWidth = (view.frame.width - padding - horizontalInset) / 2 - margin
           
           redView.frame = CGRect(
             x: safeLayoutInsets.left + margin,
             y: yOffset,
             width: viewWidth,
             height: view.bounds.height - yOffset - (safeLayoutInsets.bottom + margin)
           )
           
           blueView.frame = CGRect(
             origin: CGPoint(x: redView.frame.maxX + padding, y: yOffset),
             size: redView.bounds.size
           )
         }
         print(view.safeAreaInsets.right)
         
         view.safeAreaInsets.left
         view.safeAreaInsets.right
         view.safeAreaInsets.bottom
         view.safeAreaInsets.top
         */
        
        var sidePadding:Double = 20.0
        var midPaddng:Double = 10.0
        
        let viewWidth:Double = Double(view.frame.size.width)
        let viewHeigh:Double = Double(view.frame.size.height)
        let safeTop:Double = Double(view.safeAreaInsets.top)
        let safebottom:Double = Double(view.safeAreaInsets.bottom)
        let rectWidth:Double = Double(viewWidth - sidePadding*2 - midPaddng)/2
        let rectHeigth:Double = Double(viewHeigh - sidePadding*2 - safebottom*2)
        
        redView.frame = CGRect(x: sidePadding, y: safeTop + sidePadding, width: rectWidth, height: rectHeigth)
        
        //        redView.frame.maxX , horizonInsec
        blueView.frame = CGRect(x: Double(redView.frame.maxX) + midPaddng, y: safeTop + sidePadding, width: rectWidth, height: rectHeigth)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("--viewWillAppear--")
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("--viewDidAppear--")
    }

}

