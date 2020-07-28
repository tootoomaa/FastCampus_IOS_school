//
//  MapFinderVC.swift
//  CafeSpot
//
//  Created by 김광수 on 2020/07/10.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import MapKit

class MapFindVC: UIViewController {
  
  // MARK: - Properties
  
  var cafeData: [CafeModel] = []
  var clusterAnnotationArray: [MKAnnotation] = []
  var visibleAnnotraion: [MyAnnotation] = []
  var collectionViewHideOption: Bool = false
  
  struct Standard {
    static let padding:CGFloat = 10
    static let myEdgeinset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
  }
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  lazy var hideCollectionViewButton: UIButton = {
    let button = UIButton()
    let systemSymbolConf = UIImage.SymbolConfiguration(
      pointSize: 30,
      weight: .light,
      scale: .small
    )
    let downSquareImage = UIImage(systemName: "chevron.down.square",withConfiguration: systemSymbolConf)
    
    button.setImage(downSquareImage, for: .normal)
    button.imageView?.tintColor = .darkGray
    
    button.layer.cornerRadius = 14
    button.backgroundColor = .systemGray3
    button.addTarget(self, action: #selector(tabHideCollectionViewButton), for: .touchUpInside)
    
    return button
  }()
  
  let cafeLocationMap: MKMapView = {
    let map = MKMapView()
    return map
  }()
  
  let cameraView: MKMapCamera = {
    let camera = MKMapCamera()
    camera.centerCoordinateDistance = 2000  // 고도
    camera.pitch = 0 // 카메라 각도 (0일 때 수직으로 내려다보는 형태)
    camera.heading = 0   // heading: 카메라 방향 0 ~ 360 (맵을 바라보는 방향)
    return camera
  }()
  
  
  // MARK: - Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchData()

    configureMapInitializaiton()
    
    configureSetUI()
    
    configureAutolayout()
  
    
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
  
  func configureMapInitializaiton() {
    
    // Annotation 설정
    let annotation = MKPointAnnotation()
    annotation.title = cafeData[1].title
    annotation.coordinate = CLLocationCoordinate2DMake(cafeData[1].lat, cafeData[1].lng)
    cafeLocationMap.addAnnotation(annotation)
    
    // 카메라 설정
    cameraView.centerCoordinate = CLLocationCoordinate2DMake(cafeData[1].lat, cafeData[1].lng)
    cafeLocationMap.setCamera(cameraView, animated: true)
    
    // map에 Annotation 추가
    for cafe in cafeData {
      let coordinate = CLLocationCoordinate2DMake(cafe.lat, cafe.lng)
      
      let annotation = MyAnnotation.init(cafeName: cafe.title, detailInfo: cafe.description, coordinate: coordinate)
//      clusterAnnotationArray.append(annotation)
      
      cafeLocationMap.addAnnotation(annotation)
    }
    
    // cluster annotaion 설정
  }
  
  func configureSetUI() {
    
    // mapView
    view.addSubview(cafeLocationMap)
    cafeLocationMap.frame = view.frame
    cafeLocationMap.delegate = self
    
    // collectionView
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    collectionView.register(MapFindCell.self, forCellWithReuseIdentifier: MapFindCell.identifier)
  }
  
  func configureAutolayout() {
    
    let safeGuide = view.safeAreaLayoutGuide
    
    [hideCollectionViewButton, collectionView].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
  
    NSLayoutConstraint.activate([
      
      collectionView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 200),
    
      hideCollectionViewButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor,constant: 6),
      hideCollectionViewButton.heightAnchor.constraint(equalToConstant: 40)
      
    ])
  }
  
  // MARK: - Handler
  
  @objc func tabHideCollectionViewButton() {
    if collectionViewHideOption == false {
      // 표시 -> 숨김
      UIView.animate(withDuration: 0.5) {
        self.collectionView.center.y += 200
        self.hideCollectionViewButton.center.y += 200
      }
    } else {
      // 숨김 -> 표시
      UIView.animate(withDuration: 0.5) {
        self.collectionView.center.y -= 200
        self.hideCollectionViewButton.center.y -= 200
      }
    }
    collectionViewHideOption.toggle()
    loadViewIfNeeded()
  }
  
}

// MARK: - MKMapViewDelegate
extension MapFindVC: MKMapViewDelegate {
  
  // 화면 이동에 따른 annotation 변경 사항 업데이트
  func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
    var tempVisibleAnnotraion: [MyAnnotation] = []
    for myAnnotaion in cafeLocationMap.annotations(in: cafeLocationMap.visibleMapRect) {
      if let annotation = myAnnotaion as? MyAnnotation {
        tempVisibleAnnotraion.append(annotation)
      }
    }
    if visibleAnnotraion.count != tempVisibleAnnotraion.count {
      visibleAnnotraion = tempVisibleAnnotraion
    }
    collectionView.reloadData()
  }
  
  // 첫 시작시 annotation 리스트 생성
  func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    visibleAnnotraion = []
    for myAnnotaion in cafeLocationMap.annotations(in: cafeLocationMap.visibleMapRect) {
      if let annotation = myAnnotaion as? MyAnnotation {
        visibleAnnotraion.append(annotation)
      }
    }
    collectionView.reloadData()
  }
  
  // 특정 Annotation 선택시 해당 카페의 상세 정보 보여줌
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard let myAnnotation = view.annotation as? MyAnnotation else { return }
    visibleAnnotraion = []
    visibleAnnotraion.append(myAnnotation)
    collectionView.reloadData()
  }
  
  
  func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    print("MKANnotationView")
    guard annotation is MKPointAnnotation else { return nil }
    
    let identifier = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
    
    annotationView.clusteringIdentifier = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
  
    return annotationView
  }
  
}

// MARK: - UICollectionVeiwDataSource
extension MapFindVC: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return visibleAnnotraion.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapFindCell.identifier, for: indexPath) as? MapFindCell else { fatalError() }
    
    cell.myAnnotation = visibleAnnotraion[indexPath.item]
    
    return cell
  }
  
  // 카페 정보창 선택시 해당 Annotation의 위치로 이동
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    UIView.animate(withDuration: 0.5) {
      // 카메라 설정
      let camera = MKMapCamera()
      // 현재 맵뷰에 보이는 핀들의 목록에서
      let annotationCoordinate = self.visibleAnnotraion[indexPath.item].coordinate
      self.cameraView.centerCoordinate = CLLocationCoordinate2DMake(annotationCoordinate.latitude,annotationCoordinate.longitude)
      self.cafeLocationMap.setCamera(self.cameraView, animated: true)
      
      self.cafeLocationMap.centerCoordinate = self.visibleAnnotraion[indexPath.item].coordinate
    }
  }
}


// MARK: - UICollectionVeiwDelegateFlowLayout
extension MapFindVC: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Standard.padding
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Standard.padding
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return Standard.myEdgeinset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
//    let width = collectionView.frame.width - Standard.myEdgeinset.left - Standard.myEdgeinset.right - Standard.padding
    let height = collectionView.frame.height - Standard.myEdgeinset.top - Standard.myEdgeinset.bottom
 
    return CGSize(width: height*0.8, height: height)
  }
  
}
