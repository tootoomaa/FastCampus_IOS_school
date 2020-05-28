//
//  OrderPage.swift
//  ShoppingItems
//
//  Created by 김광수 on 2020/05/27.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

class OrderPage: UIViewController {

    var userOrderList:[String] = []
    var userOrderListCount:[Int] = []
    var delegate: OrderPageDelegate? //ViewController
    
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Order List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "PlaceOrder", style: .plain, target: self, action: #selector(tapPlaceOrderAction))
        tableView = UITableView(frame: view.frame)
        tableView.register(OrderCell.self, forCellReuseIdentifier: "CellId")
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
    
    @objc func tapPlaceOrderAction(_ sender:UIButton) {
        let alretController = UIAlertController(title: "주문이 완료되었습니다.", message: "구매 해주셔서 감사합니다. \n 이전화면으로 돌아갑니다.", preferredStyle: .alert)
        
        let comfirmAction = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alretController.addAction(comfirmAction)
        present(alretController, animated: true)
        
        delegate?.tabPlaceOrderAction(userOrderProductList: userOrderList, userOrderProductListCount: userOrderListCount)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDataSource
extension OrderPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userOrderList.count == 0 {
            let alretController = UIAlertController(title: "주문서가 비었습니다.", message: "이전화면으로 돌아갑니다.", preferredStyle: .alert)
            
            let comfirmAction = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }
            
            alretController.addAction(comfirmAction)
            present(alretController, animated: true)
        }
        return userOrderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! OrderCell
        cell.productImageView.image = UIImage(named: userOrderList[indexPath.row])
        cell.productImageView.contentMode = UIView.ContentMode.scaleAspectFit
        cell.productNameLabel.text = userOrderList[indexPath.row]
        cell.productCountLabel.text = "\(userOrderListCount[indexPath.row])"
        return cell
    }

}

//MARK: - UITableViewDataSource
extension OrderPage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "DELETE") {
            (action, sourceView, actionPerformed)
            in
            self.deleteList(indexPath.row)
            actionPerformed(true)
        }
        deleteAction.backgroundColor = .red
        
        let configure = UISwipeActionsConfiguration(actions: [deleteAction])
        configure.performsFirstActionWithFullSwipe = false
        return configure
    }
    
    func deleteList(_ row:Int) {
        self.userOrderListCount.remove(at: row)
        self.userOrderList.remove(at: row)
        tableView.reloadData()
    }
}
