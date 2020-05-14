//
//  CustomView.swift
//  200512_customView
//
//  Created by 김광수 on 2020/05/12.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

protocol CustomViewDelegate: class {  // class 만 쓸수 있게 지정
    func colorForBackground(_ newColor: UIColor?) -> UIColor
}


class CustomView: UIView {
    weak var delegate: CustomViewDelegate?
    override var backgroundColor: UIColor? {
        get { super.backgroundColor }
        set {
            let color = delegate?.colorForBackground(newValue)
            let newColor = color ?? newValue ?? .gray
            super.backgroundColor = newColor
            print("새로 변경될 색은 :", newColor)
        }
    }
}

