//: [Previous](@previous)
import Foundation

let decoder = JSONDecoder()

/*
 1번 문제
 - 다음 JSON 내용을 Fruit 타입으로 변환
 */
print("\n---------- [ 1번 문제 (Fruits) ] ----------\n")
let jsonFruits = """
[
{
  "name": "Orange",
  "cost": 100,
  "description": "A juicy orange"
},
{
  "name": "Apple",
  "cost": 200
},
{
  "name": "Watermelon",
  "cost": 300
},
]
""".data(using: .utf8)!


struct Fruit {
  let name: String?
  let cost: Int?
  
//  enum CodingKeys: String, CodingKey {
//    case name
//    case cost
//  }
}

extension Fruit: Decodable {
  
}

if let fruit = try? JSONDecoder().decode([Fruit].self, from: jsonFruits) {
  fruit.forEach { (item) in
    print(item)
  }
}


/*
 2번 문제
 - 다음 JSON 내용을 Report 타입으로 변환
 */
print("\n---------- [ 2번 문제 (Report) ] ----------\n")
let jsonReport = """
{
  "name": "Final Results for iOS",
  "report_id": "905",
  "read_count": "10",
  "report_date": "2019-02-14",
}
""".data(using: .utf8)!

struct Report: Decodable {
  var name: String
  var reportId: String
  var readCount: String
  var reportDate: String
  
  enum CodingKeys: String, CodingKey {
    case name
    case reportId = "report_id"
    case readCount = "read_count"
    case reportDate = "report_date"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    reportId = try container.decode(String.self, forKey: .reportId)
    readCount = try container.decode(String.self, forKey: .readCount)
    reportDate = try container.decode(String.self, forKey: .reportDate)
  }
}


if let data = try? decoder.decode(Report.self, from: jsonReport) {
  print(data)
} else {
  print("Fail")
}


/*
 3번 문제
 - Nested Codable 내용을 참고하여 다음 JSON 내용을 파싱
 */

print("\n---------- [ 3번 문제 (Movie) ] ----------\n")
let jsonMovie = """
[
  {
    "name": "Edward",
    "favorite_movies": [
      { "title": "Gran Torino", "release_year": 2008 },
      { "title": "3 Idiots", "release_year": 2009 },
      { "title": "Big Fish", "release_year": 2003 },
    ]
  }
]
""".data(using: .utf8)!

struct Person: Decodable {
  
  var name: String
  var title: String
  var releaseYear: Int
  
  enum CodingKeys: String, CodingKey {
    case name
    case favoriteMovies = "favorite_movies"
  }
  
  struct Movie: Codable {
    var title: String
    var releaseYear: Int
  }
  
  enum AdditionalInfoKeys: String, CodingKey {
    case title
    case releaseYear = "release_year"
  }

  init(from decoder: Decoder) throws {
    let nukeyedContainer = try decoder.unkeyedContainer()
    
    let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
    name = try keyedContainer.decode(String.self, forKey: .name)
    
    let additionalInfo = try keyedContainer.nestedContainer(
      keyedBy: AdditionalInfoKeys.self,
      forKey: .favoriteMovies
    )
    title = try additionalInfo.decode(String.self, forKey: .title)
    releaseYear = try additionalInfo.decode(Int.self, forKey: .releaseYear)
  }
}

if let data = try? decoder.decode([Person].self, from: jsonMovie) {
  print(data)
} else {
  print("error")
}





//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
