//
//  TableViewSection.swift
//  TableViewPractice
//
//  Created by giftbot on 2020/05/25.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class TableViewSection: UIViewController {
    
    /***************************************************
     Data :  x ~ y까지의 숫자 (x, y는 임의의 숫자) (10 ~ 50, 60 ~ 78, 0 ~ 100)
     섹션 타이틀을 10의 숫자 단위로 설정하고 각 섹션의 데이터는 해당 범위 내의 숫자들로 구성
     
     e.g.
     섹션 0 - 0부터 9까지의 숫자
     섹션 1 - 10부터 19까지의 숫자
     ...
     
     let data = [5, 7, 16, 19, 22, 29, 30, 39, 44, 48, 50]
     위 데이터가 주어지면
     섹션 0 - 5, 7
     섹션 1 - 16, 19
     섹션 2 - 22, 29
     ...
     ***************************************************/
    
    override var description: String { "Practice 3 - Section" }
    
//    let data = Array(1...100)
//    let data = [5, 7, 16, 19, 22, 29, 30, 39, 44, 48, 50]
    let data = [5, 7, 22, 29, 30, 39, 44, 48, 50]
    var tempData:[Int] = []
    var sectionCount: Int = 0
    var numberCategories: [Int: [Int]] = [:]
    var sectionTitles: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        
        // Data 분류
        tempData = data
        inputData()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        tableView.dataSource = self
    }
    
    // Data Input Function
    func inputData() {
        // Get
        sectionCount = tempData.max()!/10
        for i in 1..<sectionCount+1 {
            numberCategories.updateValue([], forKey: i)
            for number in tempData {
                if i*10 > number {
                    numberCategories[i]?.append(number)
                    tempData.remove(at: tempData.firstIndex(of: number)!)
                }
            }
            // Empty Session Delete
            if numberCategories[i]!.count == 0 {
                numberCategories.removeValue(forKey: i)
            } else {
                sectionTitles.append(i)
            }
        }
    }
}


// MARK: - UITableViewDataSource

extension TableViewSection: UITableViewDataSource {
    // section의 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    // 각 섹션의 해더 이름을 지정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String("Secsion \(sectionTitles[section])")
    }
    
    // 각 session 내 하위 row 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberCategories[sectionTitles[section]]!.count
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        let sectionNumber = numberCategories[sectionTitles[indexPath.section]]!
        cell.textLabel?.text = "\(sectionNumber[indexPath.row])"
        return cell
    }
}
