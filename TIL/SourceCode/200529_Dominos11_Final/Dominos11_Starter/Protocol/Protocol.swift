//
//  Protocol.swift
//  Dominos11_Starter
//
//  Created by 김광수 on 2020/05/29.
//  Copyright © 2020 Kira. All rights reserved.
//


protocol CategoryTableViewDelegate {
    func tabMainButtonDelegate(_ cell:CategoryTableViewCell, row:Int)
}

protocol WishLisgViewControllerDelegate {
    func tabPlusSubButtonDelegate(productName:String, orderNumber:Int)
}
