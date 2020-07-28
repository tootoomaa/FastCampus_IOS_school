//
//  CafeModel.swift
//  CafeSpot
//
//  Created by 김광수 on 2020/07/10.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation


struct CafeModel {
  var title: String
  var description: String
  var isFavorite: Bool
  
  // location Detail Imformation
  var address: String
  var lat: Double
  var lng: Double
  
  enum CodingKeys: String, CodingKey {
    case title
    case description
    case isFavorite
    case location
  }
  
  enum AdditionalLocationKeys: String, CodingKey {
    case address
    case lat
    case lng
  }
}

extension CafeModel: Decodable {
  init(from decoder: Decoder) throws {
    let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
    title = try keyedContainer.decode(String.self, forKey: .title)
    description = try keyedContainer.decode(String.self, forKey: .description)
    isFavorite = try keyedContainer.decode(Bool.self, forKey: .isFavorite)
    
    let additionalInfo = try keyedContainer.nestedContainer(
      keyedBy: AdditionalLocationKeys.self,
      forKey: .location)
    address = try additionalInfo.decode(String.self, forKey: .address)
    lat = try additionalInfo.decode(Double.self, forKey: .lat)
    lng = try additionalInfo.decode(Double.self, forKey: .lng)
    
  }
}


/* Data Infomation
 {
   "title": "센터커피",
   "description": "커피가 맛있는 서울숲 카페",
   "location": {
     "address": "성동구 서울숲2길 28-11",
     "lat": 37.546555,
     "lng": 127.041563,
   },
   "isFavorite": false,
 },
 */
