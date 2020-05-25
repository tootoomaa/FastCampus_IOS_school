//
//  TableViewNumbers.swift
//  TableViewPractice
//
//  Created by giftbot on 2020/05/25.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class TableViewNumbers: UIViewController, UITableViewDelegate {
  
  /***************************************************
   1부터 50까지의 숫자 출력하기
   ***************************************************/
  
  override var description: String { "Practice 1 - Numbers" }

    var data = Array(1...50)
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let tableView = UITableView(frame: view.frame)
    view.addSubview(tableView)
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.dataSource = self
    
  }
}

extension TableViewNumbers: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(data[indexPath.row])"
        return cell
    }
}
