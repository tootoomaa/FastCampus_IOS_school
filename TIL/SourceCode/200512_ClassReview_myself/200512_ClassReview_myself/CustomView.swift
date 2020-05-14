//
//  CustomView.swift
//  200512_ClassReview_myself
//
//  Created by 김광수 on 2020/05/12.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override var backgroundColor: UIColor? {
        get { super.backgroundColor }
        set {
            guard newValue != nil else {
                super.backgroundColor = .gray
                return
            }
            if newValue == .green {
                super.backgroundColor = .blue
            } else {
                super.backgroundColor = newValue
            }
            print("새로 변경될 색은 :", super.backgroundColor!)
        }
    }
}

