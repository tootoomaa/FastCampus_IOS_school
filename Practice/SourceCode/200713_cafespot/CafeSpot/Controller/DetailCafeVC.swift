//
//  DetailCafeVC.swift
//  CafeSpot
//
//  Created by 김광수 on 2020/07/11.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailCafeVC: UIViewController {
  
  // MARK: - Properties
  
  var cafeData: CafeModel? = nil {
    didSet {
      navigationItem.title = cafeData?.title
      
      guard let cafeData = cafeData else { return }
      cafeName.text = "   \(cafeData.title)"
      cafeDiscription.text  = "     \(cafeData.description)"
      
      let annotation = MKPointAnnotation()
      annotation.title = cafeData.title
      annotation.coordinate = CLLocationCoordinate2DMake(cafeData.lat, cafeData.lng)
      cafeLocationMap.addAnnotation(annotation)
      
      
      let camera = MKMapCamera()
      camera.centerCoordinate = CLLocationCoordinate2DMake(cafeData.lat, cafeData.lng)
      camera.centerCoordinateDistance = 200  // 고도
      camera.pitch = 0 // 카메라 각도 (0일 때 수직으로 내려다보는 형태)
      camera.heading = 0   // heading: 카메라 방향 0 ~ 360 (맵을 바라보는 방향)
      cafeLocationMap.setCamera(camera, animated: true)
      
    }
  }
  
  let locationManager = CLLocationManager()
  var currentCafeImage: [UIImage] = []
  
  let scrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.backgroundColor = .systemBackground
    scroll.alwaysBounceVertical = false
    scroll.showsVerticalScrollIndicator = true
    return scroll
  }()
  
  let horizionScrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.backgroundColor = .systemGray3
    scroll.alwaysBounceHorizontal = false
    scroll.showsHorizontalScrollIndicator = true
    return scroll
  }()
  
  lazy var pageControl: UIPageControl = {
    let pageControl = UIPageControl(frame: .zero)
    pageControl.numberOfPages = currentCafeImage.count
    pageControl.pageIndicatorTintColor = .gray
    pageControl.currentPage = 0
    pageControl.currentPageIndicatorTintColor = UIColor.white
    pageControl.backgroundColor = .systemGray3
    pageControl.layer.cornerRadius = 10
    pageControl.alpha = 0.5
    
    return pageControl
  }()
  
  let cafeName: UILabel = {
    let label = UILabel()
    label.text = "CafeName.."
    label.textColor = .black
    label.font = .systemFont(ofSize: 30)
    return label
  }()
  
  let cafeDiscription: UILabel = {
    let label = UILabel()
    label.text = "This Cafe is Nice.."
    label.textColor = .systemGray2
    label.font = .systemFont(ofSize: 20)
    return label
  }()
  
  let spaceViewFirst: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray5
    return view
  }()
  
  let spaceViewSecond: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray5
    return view
  }()
  
  let locationImage: UIImageView = {
    
    let systemSymbolConf = UIImage.SymbolConfiguration(
      pointSize: 30,
      weight: .regular,
      scale: .medium
    )
    let mapImage = UIImage(systemName: "map",withConfiguration: systemSymbolConf)
    
    var image = UIImageView(image: mapImage)
    image.tintColor = .black
    return image
  }()
  
  let locationLabel: UILabel = {
    let label = UILabel()
    label.text = "위치 정보"
    label.textColor = .black
    label.font = .systemFont(ofSize: 30)
    return label
  }()
  
  let cafeLocationMap: MKMapView = {
    let map = MKMapView()
    
    return map
  }()
  
  let addInfoImage: UIImageView = {
    
    let systemSymbolConf = UIImage.SymbolConfiguration(
      pointSize: 30,
      weight: .regular,
      scale: .medium
    )
    let infoImage = UIImage(systemName: "info.circle",withConfiguration: systemSymbolConf)
    
    var image = UIImageView(image: infoImage)
    
    image.tintColor = .black
    return image
  }()
  
  let addInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "추가 정보"
    label.textColor = .black
    label.font = .systemFont(ofSize: 30)
    return label
  }()
  
  lazy var naverButton: UIButton = {
    let button = UIButton()
    
    button.tag = 1
    
    button.setImage(UIImage(named: "navermap"), for: .normal)
    button.setTitle("네이버 길 찾기", for: .normal)
    button.setTitleColor(.black, for: .normal)
    
    button.backgroundColor = .white
    button.layer.cornerRadius = 5
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemGray3.cgColor
    
    button.addTarget(self, action: #selector(tabLinkButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  lazy var instagramButton: UIButton = {
    let button = UIButton()
    
    button.tag = 0
    
    button.setImage(UIImage(named: "instagram"), for: .normal)
    button.setTitle("인스타그램 확인", for: .normal)
    button.setTitleColor(.black, for: .normal)
    
    button.backgroundColor = .white
    button.layer.cornerRadius = 5
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemGray3.cgColor
    
    button.addTarget(self, action: #selector(tabLinkButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    fetchCafePictures()
    
    configureLocation()
    
    checkAuthorizationStatus()
    
    configureScrollView()
    
    configureAutoLayout()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2000)
  }
  
  private func configureScrollView() {
    
    let viewWidth = UIScreen.main.bounds.width
    
    // vertical ScrollView Setting
    scrollView.delegate = self
    scrollView.isScrollEnabled = true
    scrollView.frame = view.frame
    scrollView.contentSize = CGSize(width: viewWidth, height: 2000)
    
    // horizion ScrollView Setting
    horizionScrollView.isScrollEnabled = true
    horizionScrollView.isPagingEnabled = true
    horizionScrollView.delegate = self
    
    // 이미지 배열을 통한 이미지 뷰 생성
    for i in 0..<currentCafeImage.count{
      
      let imageView = UIImageView()
      imageView.image = currentCafeImage[i]
      imageView.contentMode = .scaleToFill //scaleAspectFit //  사진의 비율을 맞춤.
      
      let xPosition = viewWidth * CGFloat(i)
      // 각각의 이미지 별로 위치를 지정 해줌
      imageView.frame = CGRect(x: xPosition, y: 0,
                               width: viewWidth,
                               height: viewWidth*1.1)
      
      horizionScrollView.contentSize.width = viewWidth * CGFloat(1+i)
      
      horizionScrollView.addSubview(imageView)
      
    }
    
  }
  
  private func configureAutoLayout() {
    
    view.addSubview(scrollView)
    
    let safeGuide = scrollView.contentLayoutGuide
    
    [horizionScrollView, cafeName, cafeDiscription, spaceViewFirst, spaceViewSecond, cafeLocationMap].forEach{
      scrollView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
      $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    view.addSubview(pageControl)
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    
    [locationImage, locationLabel, addInfoImage, addInfoLabel, naverButton, instagramButton].forEach{
      scrollView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      horizionScrollView.topAnchor.constraint(equalTo: safeGuide.topAnchor ),
      horizionScrollView.heightAnchor.constraint(equalTo: horizionScrollView.widthAnchor, multiplier: 1.1),
      
      pageControl.leadingAnchor.constraint(equalTo: horizionScrollView.leadingAnchor, constant: 30),
      pageControl.trailingAnchor.constraint(equalTo: horizionScrollView.trailingAnchor, constant: -30),
      pageControl.bottomAnchor.constraint(equalTo: horizionScrollView.bottomAnchor, constant: -30),
      pageControl.heightAnchor.constraint(equalToConstant: 40),
      
      cafeName.topAnchor.constraint(equalTo: horizionScrollView.bottomAnchor,constant: 10),
      cafeName.heightAnchor.constraint(equalToConstant: 40),
      
      cafeDiscription.topAnchor.constraint(equalTo: cafeName.bottomAnchor,constant: 2),
      cafeDiscription.heightAnchor.constraint(equalToConstant: 40),
      
      spaceViewFirst.topAnchor.constraint(equalTo: cafeDiscription.bottomAnchor),
      spaceViewFirst.heightAnchor.constraint(equalToConstant: 10),
      
      locationImage.topAnchor.constraint(equalTo: spaceViewFirst.bottomAnchor, constant: 20),
      locationImage.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 20),
      
      locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 10),
      locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
      
      cafeLocationMap.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
      cafeLocationMap.heightAnchor.constraint(equalTo: cafeLocationMap.widthAnchor, multiplier: 0.8),
      
      spaceViewSecond.topAnchor.constraint(equalTo: cafeLocationMap.bottomAnchor, constant: 10),
      spaceViewSecond.heightAnchor.constraint(equalToConstant: 10),
      
      addInfoImage.topAnchor.constraint(equalTo: spaceViewSecond.bottomAnchor, constant: 20),
      addInfoImage.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 20),
      
      addInfoLabel.leadingAnchor.constraint(equalTo: addInfoImage.trailingAnchor, constant: 10),
      addInfoLabel.centerYAnchor.constraint(equalTo: addInfoImage.centerYAnchor),
      
      instagramButton.topAnchor.constraint(equalTo: addInfoLabel.bottomAnchor, constant: 20),
      instagramButton.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 10),
      instagramButton.heightAnchor.constraint(equalToConstant: 70),
      
      naverButton.centerYAnchor.constraint(equalTo: instagramButton.centerYAnchor),
      naverButton.leadingAnchor.constraint(equalTo: instagramButton.trailingAnchor, constant: 10),
      naverButton.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -10),
      naverButton.widthAnchor.constraint(equalTo: instagramButton.widthAnchor, multiplier: 1),
      naverButton.heightAnchor.constraint(equalToConstant: 70),
      
      instagramButton.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor,constant: -40),
      naverButton.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor,constant: -40),
      
      
    ])
    
  }
  
  // MARK: - API
  
  func fetchCafePictures() {
    
    guard let cafeTitle = cafeData?.title else { return }
    
    var imageName: String = ""
    
    // 이미지 텍스트를 통한 이미지 배열 생성
    for index in 1..<20 {
      if index < 10 {
        imageName = "\(cafeTitle)0\(index)"
      } else {
        imageName = "\(cafeTitle)\(index)"
      }
      
      guard let image = UIImage(named: imageName) else { return }
      currentCafeImage.append(image)
    }
    
  }
  
  // MARK: - Handler
  @objc func tabLinkButton(_ sender: UIButton) {
    guard let cafeData = cafeData else { return }
  
    // 인스타그램 오픈을 위한 URL을 미리 저장해둠
    var searchString = "instagram://tag?name=\(cafeData.title)"
    var searchAppName:String = "instagram"
    
    if sender == naverButton {
      // 사용자가 네이버 버튼을 누른 경우 searchString 변경
      guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
      searchAppName = "nmap"
      searchString = "nmap://route/walk?slat=\(locValue.latitude)&slng=\(locValue.longitude)&sname=\("내 위치")&dlat=\(cafeData.lat)&dlng=\(cafeData.lng)&dname=\(cafeData.title)&appname=\("com.kr.tootoomaa")"
    }

    // URL에 한글이 포함된 경우 인코딩을 통해서 변환해주어야 정상적으로 URL생성 가능
    if let encoded  = searchString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
      let myURL = URL(string: encoded){
      if UIApplication.shared.canOpenURL(myURL) {
        UIApplication.shared.open(myURL, options: [:], completionHandler: nil)
      } else {
        UIApplication.shared.open(URL(string: "itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software&term=\(searchAppName)")!, options: [:], completionHandler: nil)
      }
    }
  }
  
  // MARK: - Location Controller
  
  private func configureLocation() {
    // 사용자에게 실제로 권한을 요청 하는 부분 ( 팝업 )
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters // 위치정보 정확도
      locationManager.startUpdatingLocation()
    }
  }
  
  private func checkAuthorizationStatus() {
    // 사용자가 승인한 권한에 따라 위치 정보 접근
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted, .denied: break
    case .authorizedWhenInUse:
      fallthrough
    case .authorizedAlways:
      startUpdatingLocation()
    @unknown default: fatalError()
    }
  }
  
  private func startUpdatingLocation() {
    // 사용자가 승인한 권한 확인
    let status = CLLocationManager.authorizationStatus()
    // 권한이 올바른 경우에만 위치 정보 업데이트 시작 가능
    guard status == .authorizedAlways || status == .authorizedWhenInUse,
      CLLocationManager.locationServicesEnabled()
      else { return }
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.distanceFilter = 10.0
    // 위치 정보 업데이트 시작
    locationManager.startUpdatingLocation()
  }
  
}

// MARK: - UIScrollViewDelegate
extension DetailCafeVC: UIScrollViewDelegate {
  
  // pageContol 사진별 인덱스 처리
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let viewWidth = UIScreen.main.bounds.width
    
    let index = scrollView.contentOffset.x / viewWidth
    pageControl.currentPage = Int(index)
    
  }
}

extension DetailCafeVC: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedWhenInUse, .authorizedAlways:
      print("Authorized")
    default:
      print("Unauthorized")
    }
  }
  
}
