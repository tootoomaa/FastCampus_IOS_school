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
  "cost": 200,
},
{
  "name": "Watermelon",
  "cost": 300,
},
]
""".data(using: .utf8)!


struct Fruit: Codable {
  var name: String
  var cost: Int
  var description: String?
}

let fruits = try decoder.decode([Fruit].self, from: jsonFruits)
fruits.forEach { print($0) }


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

struct Report: Codable {
  let name: String
  let reportId: String
  let readCount: String
  let reportDate: String
  
  private enum CodingKeys: String, CodingKey {
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

if let report = try? decoder.decode(Report.self, from: jsonReport) {
  print(report)
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
      { "title": "Big Fish", "release_year": 2003 },
      { "title": "Gran Torino", "release_year": 2008 },
      { "title": "3 Idiots", "release_year": 2009 },
    ]
  }
]
""".data(using: .utf8)!

struct Person: Decodable {
  let name: String
  let favoriteMovies: [Movie]
  
  private enum CodingKeys: String, CodingKey {
    case name
    case favoriteMovies = "favorite_movies"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    favoriteMovies = try container.decode([Movie].self, forKey: .favoriteMovies)
  }
  
  struct Movie: Decodable {
    let title: String
    let releaseYear: Int
    
    private enum CodingKeys: String, CodingKey {
      case title
      case releaseYear = "release_year"
    }
    
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      title = try container.decode(String.self, forKey: .title)
      releaseYear = try container.decode(Int.self, forKey: .releaseYear)
    }
  }
}

if let report = try? decoder.decode([Person].self, from: jsonMovie) {
  print("Name :", report[0].name)
  report[0].favoriteMovies.forEach { print($0) }
}


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
