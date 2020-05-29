//
//  WishListViewController.swift
//  Dominos11_Starter
//
//  Created by Lee on 2020/05/26.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController {
    
    //MARK: - Properties
    var tableView = UITableView()
    var productData:ProductData? // SceneDelegate 에서 얻음
    var userOrderProductList:[String:Int] = [:]
    var orderProductNameStringArray:[String] = []
    
    //MARK: - init
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setNavigation()
        buildTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        tableView.reloadData()
    }
    
    
    func buildTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cellid")
        view.addSubview(tableView)
    }
    
    func setNavigation() {
        navigationItem.title = "Wish List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "목록 지우기", style: .plain, target: self, action: #selector(tabResetButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "주문", style: .plain, target: self, action: #selector(tabPlaceOrderButton(_:)))
    }
    
    @objc func tabResetButton(_ sender:UIButton) {
        productData?.userOrderList = [:]
        orderProductNameStringArray = []
        tableView.reloadData()
    }
    
    @objc func tabPlaceOrderButton(_ sender:UIButton) {
        let OrderAlertController = UIAlertController(title: "결제내역", message: orderAlertStringMake(), preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "돌아가기", style: .cancel)
        let placeOrder = UIAlertAction(title: "결제하기", style: .default) { _ in
            self.productData?.userOrderList = [:]
            self.orderProductNameStringArray = []
            self.tableView.reloadData()
        }
        
        OrderAlertController.addAction(cancelAction)
        OrderAlertController.addAction(placeOrder)
        
        present(OrderAlertController, animated: true, completion: nil)
    }
    

    func orderAlertStringMake() -> String {
        var resultString:String = ""    // 메시지 저장
        var calculatePrice:Int = 0      // 총 금액 저장
        
        for productName in orderProductNameStringArray {
            if let count = userOrderProductList[productName] {
                resultString += "\(productName) - \(count)개\n"
                calculatePrice += (productData?.getProductPrice(productName: productName))!*count
            }
        }
        resultString += "결제금액 : \(calculatePrice)"
        return resultString
    }
    
    func fetchData() {
        guard let orderList = productData?.userOrderList else {return}
        userOrderProductList = orderList
        orderProductNameStringArray = Array(userOrderProductList.keys)
    }
}

//MARK: - UITableDataSource Delegate
extension WishListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderProductNameStringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        let productName = orderProductNameStringArray[indexPath.row]
        cell.imageView?.image = UIImage(named: productName)
        cell.textLabel?.text = productName
        cell.detailTextLabel?.text = "주문수량 : \(userOrderProductList[productName]!)"
        return cell
    }
}
