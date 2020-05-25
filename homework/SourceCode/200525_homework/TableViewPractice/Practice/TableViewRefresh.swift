//
//  TableViewRefresh.swift
//  TableViewPractice
//
//  Created by giftbot on 2020/05/25.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class TableViewRefresh: UIViewController {
    
    /***************************************************
     UIRefreshControl을 이용해 목록을 갱신할 때마다 임의의 숫자들이 출력되도록 할 것
     랜덤 숫자의 범위는 출력할 숫자 개수의 +50 이며, 모든 숫자는 겹치지 않아야 함.
     e.g.
     20개 출력 시, 랜덤 숫자의 범위는 0 ~ 70
     40개 출력 시, 랜덤 숫자의 범위는 0 ~ 90
     
     < 참고 >
     (0...10).randomElement()  -  0부터 10사이에 임의의 숫자를 뽑아줌
     ***************************************************/
    
    override var description: String { "Practice 2 - Refresh" }
    let tableView = UITableView()
    
    var printDataNumber = 20
    var dataArray:[Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        makeNewArrayData(printDataNumber)
        
        let refreshingButton = UIBarButtonItem(
            title: "Refresh", style: .plain, target: self,
            action: #selector(reloadData))
        
        let printNumberSeletngButton = UIBarButtonItem(
        title: "SettingNum", style: .plain, target: self,
        action: #selector(settingNumber))
        
         navigationItem.rightBarButtonItems = [printNumberSeletngButton, refreshingButton]
        
        let refreschControl = UIRefreshControl()
        refreschControl.tintColor = .blue
        refreschControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        tableView.refreshControl = refreschControl
    }
    
    func setupTableView() {
        tableView.frame = view.frame
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
    }
    
    @objc func settingNumber() {
        let addAlertMenu = UIAlertController(title: "옵션", message: "정수를 입력하세요", preferredStyle: .alert)
        //숫자를 입력받기 위한 textField 추가
        addAlertMenu.addTextField()
        // alert 창의 "Add Count" 메뉴 누를 시
        let addAction = UIAlertAction(title: "set Number", style: .default) { _ in
            if let userInputNumber = Int((addAlertMenu.textFields?.first?.text)!) {
                self.printDataNumber = userInputNumber
            }
        }
        // alert 창의 "Cancle" 메뉴 누를 시
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        //각 메뉴 alert창에 추가
        addAlertMenu.addAction(addAction)
        addAlertMenu.addAction(cancelAction)
        // 화면에 띄우기
        present(addAlertMenu, animated: true)
    }
    
    @objc func reloadData() {
        
        makeNewArrayData(printDataNumber)
        tableView.refreshControl?.endRefreshing() // refreshing 후 원상태로 돌아가는
        tableView.reloadData()
    }
    
    func makeNewArrayData(_ makeNumber:Int) {
        dataArray = []
        while dataArray.count != makeNumber {
            var temp = (0...makeNumber+50).randomElement()
            if !dataArray.contains(temp!) {
                dataArray.append(temp!)
            }
        }
        print(dataArray)
    }
    
}

// MARK: - UITableViewDataSource

extension TableViewRefresh: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = "\(dataArray[indexPath.row])"
        return cell
    }
}
