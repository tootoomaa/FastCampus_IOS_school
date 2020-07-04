//
//  GeocodeViewController.swift
//  MapKitExample
//
//  Copyright © 2020년 giftbot. All rights reserved.
//

import MapKit
import UIKit


final class GeocodeViewController: UIViewController {

  @IBOutlet private weak var mapView: MKMapView!
  
  @IBAction func recognizeTap(gesture: UITapGestureRecognizer) {
    
    let touchPoint = gesture.location(in: gesture.view) // 화면 상에서 터치한 부분 터치 정보 얻어옴
    print("touchPoint: \(touchPoint)")
    //(112.0, 233.5)
    
    let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView) // mapView 내에서 터치한 좌표로 변경
    print("coordinate: \(coordinate)")
    //CLLocationCoordinate2D(latitude: 37.560440826855356, longitude: 126.98387169279137)
    
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude) // 위도와 경도 구하기
    print("location: \(location)")
    //location: <+37.56044083,+126.98387169> +/- 0.00m (speed -1.00 mps / course -1.00) @ 2020/07/04 15:30:29 Korean Standard Time
    
    reverseGeocoder(location: location)
  }
  
  func reverseGeocoder(location :CLLocation) {
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { placeMark, error in
      print("\n---------- [ 위경도 -> 주소 ] ----------")
      if error != nil {
        return print(error!.localizedDescription)
      }
      
      // 국가별 주소체계에 따라 어떤 속성 값을 가질지 다름
      guard let address = placeMark?.first,
        let country = address.country,
        let administrativeArea = address.administrativeArea,
        let locality = address.locality,
        let name = address.name
        else { return }
      
      let addr = "\(country) \(administrativeArea) \(locality) \(name)"
      print(addr)
      self.geocodeAddressString(addr)
    }
  }
  
  func geocodeAddressString(_ addressString: String) {
    print("\n ---- 주소 -> 위경도 ----- >")
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placeMark, error) in
      if error != nil {
        return print(error!.localizedDescription)
      }
      
      guard let place = placeMark?.first else { return }
      print(place.location?.coordinate)
    }
  }
}
