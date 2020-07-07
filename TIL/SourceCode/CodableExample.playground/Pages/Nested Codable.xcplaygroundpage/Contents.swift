//: # Nested Codable
import Foundation

let jsonData = """
{
  "message": "success",
  "number": 3,
  "people": [
    { "craft": "ISS", "name": "Anton Shkaplerov" },
    { "craft": "ISS", "name": "Scott Tingle" },
    { "craft": "ISS", "name": "Norishige Kanai" },
  ]
}
""".data(using: .utf8)!

// 개별적으로 Codable을 적용하는 것과 동일
//[
//  { "craft": "ISS", "name": "Anton Shkaplerov" },
//  { "craft": "ISS", "name": "Scott Tingle" },
//  { "craft": "ISS", "name": "Norishige Kanai" },
//]

struct Astronauts: Decodable {
  let message: String
  let number: Int
  let people: [Person] // 내가 만든타입같은 경우에는 하단에 별로돌 Decodable 추가해줘야함
  
  struct Person: Decodable {
    let name: String
  }
}

do {
  let astronauts = try JSONDecoder().decode(Astronauts.self, from: jsonData)
  print(astronauts.message)
  print(astronauts.number)
  astronauts.people.forEach { print($0)}
} catch {
  print(error.localizedDescription)
}



//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
