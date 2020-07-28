//
//  AnnotationModel.swift
//  CafeSpot
//
//  Created by 김광수 on 2020/07/13.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import MapKit

class MyAnnotation: NSObject, MKAnnotation {
  
  let title: String?
  let cafeName: String
  let detailInfo: String
  let coordinate: CLLocationCoordinate2D
  
  init(cafeName: String, detailInfo: String, coordinate: CLLocationCoordinate2D ) {
    self.title = cafeName
    self.cafeName = cafeName
    self.detailInfo = detailInfo
    self.coordinate = coordinate
    
    super.init()
  }
}
