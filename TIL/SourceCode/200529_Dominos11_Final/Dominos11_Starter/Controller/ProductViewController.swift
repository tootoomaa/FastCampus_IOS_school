//
//  ProductViewController.swift
//  Dominos11_Starter
//
//  Created by Lee on 2020/05/26.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    //MARK: - Properties
    var productData: ProductData? // mainView 에서 얻음
    var presentMenuKeyList:[String] = []
    var presentMenuList:[String:Int] = [:]
    var tableView = UITableView()
    var selectedMenuNumber:Int = 0
    
    //MARK: - Build UI
    func buildTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cellid")
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = productData?.mainCategoryList[selectedMenuNumber]
        fetchData()
        buildTableView()
    }
    
    // fetch data from ProductData
    func fetchData() {
        guard let loadProductList = productData?.productMenuList[selectedMenuNumber] else {return}
        presentMenuList = loadProductList
        presentMenuKeyList = Array(presentMenuList.keys)
    }
}


//MARK: - UITableViewDataSource

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        
        let productName = presentMenuKeyList[indexPath.row]
        
        cell.imageView?.image = UIImage(named: productName)
        cell.textLabel?.text = productName
        cell.detailTextLabel?.text = "\(String(presentMenuList[productName]!))원"
        return cell
    }
}

extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        guard let categoryTableViewCell = tableView.cellForRow(at: indexPath) else {return}
        detailVC.getSelectCellImformation = categoryTableViewCell
        detailVC.productData = self.productData
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
