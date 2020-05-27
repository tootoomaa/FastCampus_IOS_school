//
//  ViewController.swift
//  homework_UITableview_delegate_200526
//
//  Created by 김광수 on 2020/05/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberArray = Array(1...50)
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CellId")
        tableView.dataSource = self
        tableView.rowHeight = 60
        view.addSubview(tableView)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! CustomCell
        cell.delegate = self
        cell.plusButton.tag = indexPath.row
        cell.textLabel?.text = "\(numberArray[indexPath.row])"
        return cell
    }
}

extension ViewController: CustomCellDelegate {
    func tabPlusButtonDelegate(_ cell: CustomCell,buttonRow: Int) {
        numberArray[buttonRow] += 1
        cell.textLabel?.text = "\(numberArray[buttonRow])"
    }
}
