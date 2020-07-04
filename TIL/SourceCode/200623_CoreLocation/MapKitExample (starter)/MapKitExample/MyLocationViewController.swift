//
//  MyLocationViewController.swift
//  MapKitExample
//
//  Copyright © 2020년 giftbot. All rights reserved.
//

import MapKit
import UIKit

final class MyLocationViewController: UIViewController {
  
  @IBOutlet private weak var mapView: MKMapView!
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    
    // 권한 요청
    checkAuthorizationStatus()
    
    //나의 위치를 보여줌
    mapView.showsUserLocation = true
    mapView.mapType = .standard //위성 정보 .satellite, .hybrid
                              
  }
  
  func checkAuthorizationStatus() {
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted, .denied: break
    case .authorizedWhenInUse:
      fallthrough
    case .authorizedAlways:
      // 위치 추적 시작
      startUpdatingLocation()
    @unknown default: fatalError()
    }
  }
  
  func startUpdatingLocation() {
    // 사용자의 위치정보 권한을 가져와서 확인하는 작업
    let status = CLLocationManager.authorizationStatus()
    guard status == .authorizedAlways || status == .authorizedWhenInUse,
      CLLocationManager.locationServicesEnabled() else { return }
    
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters // 정확도 설정
    locationManager.distanceFilter = 10.0                              // 어느정도의 거리를 보여줄지 설정
    locationManager.startUpdatingLocation()                            // 위치 정보 업데이트 시작
  }
  
  // 방향 로케이션 모니터링
  @IBAction func mornitoringHeading(_ sender: Any) {
    guard CLLocationManager.headingAvailable() else {return}  // 해당 장치가 기능이 있는지 확인
    locationManager.startUpdatingHeading()  // 위치정보 수집 시작
  }
  
  @IBAction func stopMornitoring(_ sender: Any) {
    locationManager.stopUpdatingHeading()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    // 도북 : 지도상의 북쪽
    print("trueHeading :" , newHeading.trueHeading) // 진북
    print("magneticHeading: ", newHeading.magneticHeading) // 자북
  }
}


extension MyLocationViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // 권한 체크
    switch status {
    case .authorizedWhenInUse, .authorizedAlways:
      print("Authorized")
    default:
      print("Authorized")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // [CLLocation] 위치 정보를 배열 형태로 가지고 있음
    let current = locations.last!
    
    // 현제 시간으로부터 몇 초나 차이나는지 확인 한뒤 음/양수의 절대값 내부의 데이터만 처리하도록
    if(abs(current.timestamp.timeIntervalSinceNow) < 10 ) {
      let coordinate = current.coordinate //위 경도
      
      // 크기를 어느정도 보여줄지 정하는
      // 경도 1도는 약 11km, 위도 1도는 위도에 따라 다름, 적도 (111km) ~ 극지방 (0km)
      let span = MKCoordinateSpan(latitudeDelta: 0.0002, longitudeDelta: 0.0002)
      
      let regin = MKCoordinateRegion(center: coordinate, span: span)
      mapView.setRegion(regin, animated: true)
      
      // 위치 찍기 ( 현재 위치 전달 )
      addAnnotation(location: current)
    }
  }
  
  func addAnnotation(location: CLLocation) {  // 특정 위치에 핀 찍기
    let annotation = MKPointAnnotation()
    annotation.title = "MyLocation"                // 핀 이름 설정
    annotation.coordinate = location.coordinate    // 위치 설정
    mapView.addAnnotation(annotation)              // mapView에 추가
  }
  
}
