//
//  ViewController.swift
//  ShoppingItems
//
//  Created by giftbot on 2020. 05. 26..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    var tableView = UITableView()
    
    var productList = ["iphone4s_white","iPhone8","iphone11_black", "iphone11_perple",
                       "iphone11_yellow","iphone11Pro_black","iphone11ProMax_black",
                       "iPhoneSE_Gold","iphoneSE2_black","iphoneSE2_red","iphoneSE2_rosegold",
                       "iphoneSE2_white","iPhoneX_SpaceGray","iPhoneX_White"]
    var productCount = [1,3,2,8,9,4,6,3,1,7,10,3,2,2]
    var userSelectCount:[Int] = []
    var userOrderList:[String] = []
    var userOrderListCount:[Int] = []
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSelectCount = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
        let orderButton = UIBarButtonItem(title: "Order", style: .plain, target: self, action:
            #selector(tabOrderButton(_:)))
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(tabResertButton(_:)))
        
        navigationItem.title = "Select Your Iphone"
        navigationItem.rightBarButtonItems = [orderButton,resetButton]
        
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CellId")
        view.addSubview(tableView)
    }
    
    //MARK: - BarButton Action
    
    // order 버튼을 클릭한 경우
    @objc func tabOrderButton(_ sender:UIButton) {
        // 주문 제품이 비었을때
        if userSelectCount.reduce(0,+) == 0 {
            let alertController = UIAlertController(title: "주문 사항이 비었습니다.", message: "제품을 선택해주세요", preferredStyle: .alert)
            let confirmButton = UIAlertAction(title: "ok", style: .default)
            alertController.addAction(confirmButton)
            present(alertController, animated: true)
        } else { // 주문 제품이 있을 경우
            makeOrderList()
            let orderPageVC = OrderPage()
            orderPageVC.userOrderList = self.userOrderList
            orderPageVC.userOrderListCount = self.userOrderListCount
            orderPageVC.delegate = self
            navigationController?.pushViewController(orderPageVC, animated: true)
        }
    }
    
    //reset 버튼을 클릭한 경우
    @objc func tabResertButton(_ sender:UIButton) {
        
        //alert Action 지정
        let alertController = UIAlertController(title: "주문 초기화", message: "주문을 초기화하시겠습니까?", preferredStyle: .alert)
        let cancleButton = UIAlertAction(title: "cancel", style: .cancel)
        let confirmButton = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
            self.initialization()
        }
        // alert Button 추가
        alertController.addAction(confirmButton)
        alertController.addAction(cancleButton)
        present(alertController, animated: true)
    }
    // orderPage로 주문 내역 전달 ( 배열 2개 )
    func makeOrderList() {
        userOrderList = []
        userOrderListCount = []
        for i in 0..<userSelectCount.count {
            if userSelectCount[i] != 0 {
                userOrderList.append(productList[i])
                userOrderListCount.append(userSelectCount[i])
            }
        }
    }
    // 초기화 함수
    func initialization() {
        userSelectCount = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        userOrderList = []
        userOrderListCount = []
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! CustomCell
        cell.delegate = self
        cell.plusButton.tag = indexPath.row
        cell.plusButton.tintColor = .lightGray
        cell.productCountLabel.text = "\(userSelectCount[indexPath.row])"
        cell.productImageView.image = UIImage(named: productList[indexPath.row])
        cell.productImageView.contentMode = UIView.ContentMode.scaleAspectFit
        cell.productNameLabel.text = productList[indexPath.row]
        
        return cell
    }
}

//MARK: - CustomCellDelegate

extension ViewController: CustomCellDelegate {
    func tabPlusButtonAction(_ cell: CustomCell, row: Int) {
        if let getProductInputString = cell.productCountLabel.text {
            guard let getProductInputNumber = Int(getProductInputString) else { return }
            if getProductInputNumber >= productCount[row]{
                UITableViewCell.animate(withDuration: 0.3) {
                    cell.backgroundColor = .red
                    cell.backgroundColor = .white
                }
                //alert Action 지정
                let alertController = UIAlertController(title: "재고부족", message: "해당 제품의 재고가 부족합니다.\n (최대 \(productCount[row])개 가능)", preferredStyle: .alert)
                let cancleButton = UIAlertAction(title: "확인", style: .default)
                alertController.addAction(cancleButton)
                present(alertController, animated: true)
            } else {
                userSelectCount[row] = getProductInputNumber+1
                cell.productCountLabel.text = String(userSelectCount[row])
            }
        }
    }
}

extension ViewController: OrderPageDelegate {
    func tabPlaceOrderAction(userOrderProductList:[String], userOrderProductListCount:[Int]) {
        for i in 0..<userOrderProductList.count {
            guard let index = productList.firstIndex(of: userOrderProductList[i]) else { return }
            productCount[index] -= userOrderProductListCount[i]
        }
        initialization()
    }
}
