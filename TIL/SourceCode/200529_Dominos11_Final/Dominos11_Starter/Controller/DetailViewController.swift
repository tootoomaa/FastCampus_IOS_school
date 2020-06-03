//
//  DetailViewController.swift
//  Dominos11_Starter
//
//  Created by Lee on 2020/05/26.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    var getSelectCellImformation:UITableViewCell?
    var productData:ProductData?
    var getProductPrice:Int?
    var getProductName:String = "" {
        didSet {
            navigationItem.title = getProductName
        }
    }
    var orderCount:Int = 0 {
        didSet {
            countLabel.text = "\(orderCount) 개"
        }
    }
    
    //MARK: - UI Properties
    
    var productImage: UIImageView = {
        var imgView = UIImageView()
        return imgView
    }()
    var plusButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("+", for: .normal)
        bt.layer.borderWidth = 2
        bt.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        bt.setTitleColor(.gray, for: .normal)
        bt.tag = 0
        bt.addTarget(self, action: #selector(taPlusSubButton(_:)), for: .touchUpInside)
        bt.backgroundColor = .white
        return bt
    }()
    var subButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setTitle("-", for: .normal)
        bt.layer.borderWidth = 2
        bt.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        bt.setTitleColor(.black, for: .normal)
        bt.tag = 1
        bt.addTarget(self, action: #selector(taPlusSubButton(_:)), for: .touchUpInside)
        bt.backgroundColor = .white
        return bt
    }()
    var countLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 20)
        label.text = "0 개"
        return label
    }()
    
    fileprivate func buildUI() {
        view.backgroundColor = .white
        
        productImage.frame = CGRect(x: 0, y: 150, width: view.frame.size.width, height: view.frame.size.width)
        productImage.image = UIImage(named: getProductName)
        plusButton.frame = CGRect(x: 30, y: 600, width: 60, height: 60)
        countLabel.frame = CGRect(x: 90, y: 600, width: 210, height: 60)
        subButton.frame = CGRect(x: 300, y: 600, width: 60, height: 60)
        
        view.addSubview(productImage)
        view.addSubview(plusButton)
        view.addSubview(countLabel)
        view.addSubview(subButton)
    }
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchData() // 데이터 생성
        buildUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 데이터 재생성 - Wish List에서 돌아올때 목록지우기한 경우 수량 다시표기
        fetchData()
    }
    
    //MARK: - Function
    func fetchData() {
        // productData 옵셔널 재거
        guard let getSelectCellImformation = getSelectCellImformation else {return}
        guard let productName = getSelectCellImformation.textLabel?.text else {return}
        getProductName = productName
        // 사용자가 주문한 주문서에 해당 메뉴의 카운트가 있을 경우 숫자 복원
        if let number = productData?.userOrderList[getProductName] {
            orderCount = number
        } else { // Wish List에서 초기화 할 경우 카운트 초기화
            orderCount = 0
        }
    }
    
    @objc func taPlusSubButton(_ sender:UIButton) {
        // plus:tag 0 , sub:tag 1
        if sender.tag == 0 {
            orderCount += 1
        } else {
            if orderCount > 0 {
                orderCount -= 1
            }
        }
        guard orderCount != 0 else {
            productData?.userOrderList.removeValue(forKey: getProductName)
            return
        }
        productData?.userOrderList.updateValue(orderCount, forKey: getProductName)
    }
}
