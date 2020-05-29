//
//  CategoryViewController.swift
//  Dominos11_Starter
//
//  Created by Lee on 2020/05/26.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - properties
    var productData: ProductData?   // SceneDelegate 에서 얻음
    var tableView = UITableView()
    var mainImageView: UIImageView = {
        var view = UIImageView()
        return view
    }()
    
    //MARK: - BuilUI with TableView
    func buildUI() {
        view.backgroundColor = .white
        navigationItem.title = "Domino's"
        view.addSubview(tableView)
    }
    
    func makeTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "Cellid")
        tableView.tableHeaderView = mainImageView
        
        mainImageView.frame = CGRect(x: 20, y: 20, width: 150, height: 200)
        mainImageView.image = UIImage(named: "logo")
        mainImageView.contentMode = .scaleAspectFit
    }
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        buildUI()
        makeTableView()
    }
    
    func fetchData() {
        guard let getProductData = productData else { return }
        productData = getProductData
    }
}

//MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (productData?.mainCategoryList.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cellid", for: indexPath) as! CategoryTableViewCell
        cell.delegate = self
        
        cell.mainButton.setImage(UIImage(named: productData!.mainCategoryList[indexPath.row]), for: .normal)
        cell.mainButton.tag = indexPath.row
        return cell
    }
}

//MARK: - CategoryViewControllerDelegate
extension CategoryViewController: CategoryTableViewDelegate {
    func tabMainButtonDelegate(_ cell: CategoryTableViewCell, row: Int) {
        let productVC = ProductViewController()
        productVC.selectedMenuNumber = row
        productVC.productData = self.productData!
        navigationController?.pushViewController(productVC, animated: true)
    }
}
