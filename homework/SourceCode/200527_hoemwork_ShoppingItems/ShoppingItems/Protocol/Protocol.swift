//
//  Protocol.swift
//  ShoppingItems
//
//  Created by 김광수 on 2020/05/27.
//  Copyright © 2020 giftbot. All rights reserved.
//

protocol CustomCellDelegate {
    func tabPlusButtonAction(_ cell:CustomCell, row: Int)
}

protocol OrderPageDelegate {
    func tabPlaceOrderAction(userOrderProductList:[String],userOrderProductListCount:[Int])
}
