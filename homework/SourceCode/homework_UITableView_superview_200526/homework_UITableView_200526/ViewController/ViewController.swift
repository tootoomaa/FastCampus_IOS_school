//
//  ViewController.swift
//  homework_UITableView_200526
//
//  Created by 김광수 on 2020/05/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    var dataArray = Array(1...50)
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    func setTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), style: .plain)
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CellID")
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! CustomCell
        cell.textLabel?.text = "\(dataArray[indexPath.row])"
        cell.plusButton.addTarget(self, action: #selector(tabplusButton), for: .touchUpInside)
        return cell
    }
    
    @objc func tabplusButton(sender:UIButton) {
        if let cell = sender.superview?.superview as? CustomCell,
            let row = tableView.indexPath(for: cell)?.row {
            let addedNumber = dataArray[row] + 1
            dataArray[row] = addedNumber
            cell.textLabel?.text = "\(addedNumber)"
        }
    }
}

