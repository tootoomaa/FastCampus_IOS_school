//
//  TableViewAccessoryType.swift
//  TableViewPractice
//
//  Created by giftbot on 2020/05/25.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class TableViewAccessoryType: UIViewController {
    
    /***************************************************
     - 미리 정해진 동물의 이미지와 텍스트를 테이블뷰에 표현
     - 각 셀의 크기는 80
     - 셀을 선택하면 체크박스가 나타나고 다시 선택하면 체크표시가 해제되도록 구현
     
     도전 과제)
     테이블뷰의 각 셀을 위아래로 스크롤 했다가 다시 나타낼 때, 체크 표시가 기존에 했던 곳에 정확히 다시 나타나도록 구현
     ***************************************************/
    
    override var description: String { "Task 2 - AccessoryType" }
    
    let animals = [
        "bear", "buffalo", "camel", "dog", "elephant",
        "koala", "llama", "panda", "lion", "horse",
        "guinea_pig", "koala", "whale_shark", "whale", "duck",
        "seagull", "black_swan", "peacock", "giraffe"
    ]
    var selectedAnimalList:[Int] = []
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.frame)
        
        setTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ReLoad", style: .plain, target: self, action: #selector(tabReloadButton))
        
        view.addSubview(tableView)
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
    }
    
    @objc func tabReloadButton() {
        tableView.refreshControl?.endRefreshing() // refreshing 후 원상태로 돌아가는
        tableView.reloadData()
    }
}


extension TableViewAccessoryType: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        let animalName = animals[indexPath.row]
        cell.textLabel?.text = animalName
        cell.imageView?.image = UIImage(named: animalName)
        
        // selectedAnimalList에 저장된 순서에 row는 checkmark 지정
        if selectedAnimalList.contains(indexPath.row) {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        return cell
    }
}


extension TableViewAccessoryType: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnimalList.append(indexPath.row)
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // Reload 후 중복으로 저장되는 indexPath.row 값 모두 제거
        while selectedAnimalList.contains(indexPath.row) != false {
            selectedAnimalList.remove(at: selectedAnimalList.firstIndex(of: indexPath.row)!)
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
    }
}
