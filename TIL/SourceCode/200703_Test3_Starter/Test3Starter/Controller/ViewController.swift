//
//  ViewController.swift
//  Test3Starter
//
//  Created by Lee on 2020/07/03.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Properties
  
  let tableView = UITableView()
  var cachedOffset:[Int:CGPoint] = [:]
  
  // MARK: - Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    
  }
  
  func configureTableView() {
    
    tableView.backgroundColor = .white
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 600
    
    view.addSubview(tableView)
    tableView.register(
      CustomTableViewCell.self,
      forCellReuseIdentifier: CustomTableViewCell.identifier
    )
    tableView.frame = view.frame
  }  
}
// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dominoData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: CustomTableViewCell.identifier,
      for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
    
    guard let categoryImageString = dominoData[indexPath.row]["카테고리"] as? String,
    let menuDetailDataArray = dominoData[indexPath.row]["메뉴"] as? [[String : Any]]
      else { return UITableViewCell() }
    
    cell.categoryImageString = categoryImageString
    cell.menuDetailDataArray = menuDetailDataArray

    return cell
  }
}

extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? CustomTableViewCell else { return }
    cell.offset = cachedOffset[indexPath.row] ?? .zero
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? CustomTableViewCell else { return }
    print(cell.offset)
    cachedOffset[indexPath.row] = cell.offset
    
  }
}
