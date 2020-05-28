//
//  TableViewMultipleSelection.swift
//  TableViewPractice
//
//  Created by giftbot on 2020/05/25.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class TableViewMultipleSelection: UIViewController {
    
    /***************************************************
     [ 실습 - TableViewRefresh 기능을 이어서 수행 ]
     
     1) 처음 화면에 띄워질 목록은 1부터 지정한 숫자까지의 숫자들을 출력
     2) 이후 갱신할 때마다 임의의 숫자들이 출력되도록 할 것
     랜덤 숫자의 범위는 출력할 숫자 개수의 +50 이며, 모든 숫자는 겹치지 않아야 함.
     (여기까지 TableViewRefresh 실습 내용과 동일)
     3) 특정 테이블뷰셀을 선택하고 갱신하면 해당 셀에 있던 숫자는 유지되고 나머지 숫자들만 랜덤하게 갱신되도록 처리
     (셀을 선택한 순서에 따라 그대로 다음 갱신 목록에 출력)
     e.g. 20, 10 두 개의 숫자를 선택하고 갱신하면, 다음 숫자 목록은 (20, 10, random, random...)
     4) 위 3번에서 숫자를 선택할 때 그 숫자가 7보다 작은 셀은 선택이 되지 않도록 처리.
     
     < 힌트 키워드 >
     willSelectRowAt - scrollViewDelegate 참고, 선택 가능 여부
     selectedRow(s) - tableView 속성, 현재 선택된 행에 대한 정보
     multipleSelection - 다중 선택 가능 여부
     ***************************************************/
    
    override var description: String { "Practice 3 - MultipleSelection" }
    let tableView = UITableView()
    
    var printDataNumber = 20
    var dataArray:[Int] = []
    var selectedDataArray:[Int] = []
    
    
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
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
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
        dataArray = selectedDataArray
        while dataArray.count != makeNumber {
            let temp = (0...makeNumber+50).randomElement()
            if !dataArray.contains(temp!) {
                dataArray.append(temp!)
            }
        }
        selectedDataArray = []
        print(dataArray)
    }
    
}

// MARK: - UITableViewDataSource

extension TableViewMultipleSelection: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = "\(dataArray[indexPath.row])"
        return cell
    }
}

extension TableViewMultipleSelection: UITableViewDelegate {
    
    // row를 선택 해제 했을떄
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedDataArray.remove(at: selectedDataArray.firstIndex(of: dataArray[indexPath.row])!)
    }
    // row를 선택 했을때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if dataArray[indexPath.row] > 7 {
            selectedDataArray.append(dataArray[indexPath.row])
//        }
    }
    
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if dataArray[indexPath.row] < 7 {
            return nil
        }
        return indexPath
    }
}
