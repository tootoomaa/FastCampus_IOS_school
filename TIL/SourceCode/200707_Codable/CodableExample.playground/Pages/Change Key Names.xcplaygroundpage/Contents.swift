//: [Previous](@previous)
import Foundation

// 서버에서 보내주는 정보가 우리가 받을 데이터와 키 값이 다른경우

let jsonData = """
{
  "user_name": "James",
  "user_email": "abc@xyz.com",
  "gender": "male",
}
""".data(using: .utf8)!


// 가져올 데이터보다 많은 변수가 정의되어 있으면 안됨
// 단, 서버에서 제공되는 데이터보다 내가 정의한 데이터가 적을 경우 필요한 데이터만 변환함으로 OK
struct User {
  let name: String
  let email: String
  let gender: String
  
//  private enum CodingKeys: String, CodingKey { // 네이밍 컨벤션이 다를수 있다
//    case name = "user_name"
//    case email = "user_email"
//    case gender
//  }
  
  private enum Somekeys: String, CodingKey {
    case a = "user_name"
    case b = "user_email"
    case c = "gender"
  }
}


let decoder = JSONDecoder()

do {
//  let user = try decoder.decode(User.self, from: jsonData)
  print(user)
} catch {
  print(error)
}


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
