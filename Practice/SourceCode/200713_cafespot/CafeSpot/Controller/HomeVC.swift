//
//  ViewController.swift
//  CafeSpot
//
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

final class HomeVC: UIViewController {
  
  // MARK: - Properties
  var cafeData:[CafeModel] = []
  var fileteredCafeData:[CafeModel] = []
  let searchController = UISearchController(searchResultsController: nil)
  
  var fileredOn: Bool = false
  
  //  let searchBar: UISearchBar = {
  //    let sBar = UISearchBar()
  //    sBar.placeholder = "찾기..."
  //    sBar.setShowsCancelButton(false, animated: true)
  //    //    sBar.tintColor = .white
  //    return sBar
  //  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "CafeSpot"
    label.font = UIFont(name: "Zapfino", size: 20)
    label.textAlignment = .center
    return label
  }()
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  struct Standard {
    static let myPadding: CGFloat = 10
    static let myEdge = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    static let itemCountLine = 2
  }
  
  // MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchData()
    
    configureNavi()
    
    configureCollectionView()
    
    configureUI()
    
    configureConstaint()
    
  }
  
  private func configureUI() {
    
    view.backgroundColor = .systemBackground
    
    view.addSubview(collectionView)
    
  }
  
  private func configureNavi() {
    
    navigationItem.titleView = titleLabel
    navigationItem.searchController = searchController
    navigationItem.title = "HotSpot"
    
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "검색..."
    searchController.searchBar.delegate = self
    
    definesPresentationContext = true
  }
  
  private func configureCollectionView() {
    
    collectionView.backgroundColor = .systemBackground
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: HomeViewCell.identifier)
    
    //    collectionView.register(
    //      UICollectionReusableView.self,
    //      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
    //      withReuseIdentifier: "reuseableView"
    //    )
    
  }
  
  private func configureConstaint() {
    
    let safeGuide = view.safeAreaLayoutGuide
    
    [collectionView].forEach{
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
    ])
  }
  
  // MARK: - API
  func fetchData() {
    // 로컬 Json 데이터 불러오기
    guard let cafeDateUrl = Bundle.main.url(
      forResource: "CafeList",
      withExtension: "json"
      ) else { return }
    
    if let cafeData = try? Data(contentsOf: cafeDateUrl) {
      // 데이터 분석
      if let jsonObject = try? JSONDecoder().decode([CafeModel].self, from: cafeData) {
        self.cafeData = jsonObject
      }
    }
  }
}

// MARK: - UISearchBar
extension HomeVC: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    fileteredCafeData = []
    fileredOn = true
    
    for cafe in cafeData where cafe.title.contains(searchText) {
      for selectCafe in fileteredCafeData {
        if selectCafe.title == cafe.title {
          return
        }
      }
      fileteredCafeData.append(cafe)
    }
    collectionView.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    fileredOn = false
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if fileredOn {
      // 카페 검색 필더 활성화 시
      return fileteredCafeData.count
    } else {
      // 전체 카페 리스트 전달
      return cafeData.count
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.identifier, for: indexPath) as? HomeViewCell else { fatalError() }
    
    if fileredOn {
      // 카페 검색 필더 활성화 시
      cell.cafeData = fileteredCafeData[indexPath.item]
    } else {
      // 전체 카페 리스트 전달
      cell.cafeData = cafeData[indexPath.item]
      cell.heartCheckButton.addTarget(self, action: #selector(tabFavoritButton(_:)), for: .touchUpInside)
      cell.heartCheckButton.tag = indexPath.row
    }

    return cell
  }
  
  
  @objc func tabFavoritButton(_ sender: UIButton) {
    print(sender.tag)
    cafeData[sender.tag].isFavorite.toggle()
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Standard.myPadding*2
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Standard.myPadding
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return Standard.myEdge
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width:CGFloat = (view.frame.width - Standard.myEdge.right - Standard.myEdge.left - Standard.myPadding * CGFloat(Standard.itemCountLine - 1)) / CGFloat(Standard.itemCountLine)
    
    return CGSize(width: width, height: width+50)
  }
}

extension HomeVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
    guard let cell = collectionView.cellForItem(at: indexPath) as? HomeViewCell else { return }
    
    let detailCafeVC = DetailCafeVC()
    detailCafeVC.cafeData = cell.cafeData
    navigationController?.pushViewController(detailCafeVC, animated: true)
    
  }
  
  
  // reuseable cell 하트 표시 방지
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    guard let homeViewCell = cell as? HomeViewCell else { return }
    if cafeData[indexPath.item].isFavorite == true {
      homeViewCell.heartCheckButton.tintColor = .systemPink
    } else {
      homeViewCell.heartCheckButton.tintColor = .white
    }
  }

}


