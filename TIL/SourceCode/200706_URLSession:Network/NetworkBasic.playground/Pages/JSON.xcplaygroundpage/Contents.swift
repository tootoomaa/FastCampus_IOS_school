//: [Previous](@previous)
import Foundation
/*:
 ---
 # JSON
 ---
 */

print("---------- [ JSON Parsing (1) ] ----------")

let jsonData1 = """
{
  "greeting": "hello world",
  "foo": "bar",
  "iOS": "Swift"
}
""".data(using: .utf8)!

do {
  if let json = try JSONSerialization.jsonObject(with: jsonData1) as? [String: String],
    let greeting = json["greeting"],
    let foo = json["foo"],
    let iOS = json["iOS"] {
    print(greeting)
    print(foo)
    print(iOS)
  }
} catch {
  print(error)
}


print("\n---------- [ JSON Parsing (2) ] ----------")

let jsonData2 = """
{
  "greeting": "hello world",
  "iOS": true,
  "SwiftVersion": 5
}
""".data(using: .utf8)!

if let json = try? JSONSerialization.jsonObject(with: jsonData2) as? [String: Any],
  let greeting = json["greeting"] as? String,
  let iOS = json["iOS"] as? Bool,
  let version = json["SwiftVersion"] as? Int {
  print(greeting)
  print(iOS)
  print(version)
}


print("\n---------- [ JSON Parsing (3) ] ----------")

// 배열안에 dictionary가 있는 경우
let jsonData3 = """
[
  {
     "postID": 1,
     "title": "JSON",
     "body": "Javascript Object Notation"
  },
  {
    "postID": 2,
    "title": "JSON 파싱",
    "body": "JSONSerialization을 이용한 방법"
  }
]
""".data(using: .utf8)!

struct Post {
  let postID: Int
  let title: String
  let body: String
}

if let jsonObjects = try? JSONSerialization.jsonObject(with: jsonData3) as? [[String: Any]] {
  for json in jsonObjects {
    if let postID = json["postID"] as? Int,
      let title = json["title"] as? String,
      let body = json["body"] as? String {
      let post = Post(postID: postID, title: title, body: body)
      print(post)
    }
  }
}



/*:
 ---
 ### Question
 ---
 */
/*
 User 구조체 타입을 선언하고, 다음 JSON 형식의 데이터를 User 타입으로 변환하여 출력하기
 
 e.g.
 User(id: 1, firstName: "Robert", lastName: "Schwartz", email: "rob23@gmail.com")
 User(id: 2, firstName: "Lucy", lastName: "Ballmer", email: "lucyb56@gmail.com")
 */

// 힌트: TopLevel의 타입 - Dictionary
print("\n---------- [ JSON Question ] ----------")
let userJSONData = """
{
  "users": [
    {
      "id": 1,
      "first_name": "Robert",
      "last_name": "Schwartz",
      "email": "rob23@gmail.com"
    },
    {
      "id": 2,
      "first_name": "Lucy",
      "last_name": "Ballmer",
      "email": "lucyb56@gmail.com"
    },
  ]
}
""".data(using: .utf8)!

//
//struct User {
//  let id: Int
//  let first_name: String
//  let last_name: String
//  let email: String
//}
//
//var resultArray = [User]()
//
//if let jsonObjects = try? JSONSerialization.jsonObject(with: userJSONData) as? [String:[Any]] {
//
//  if let tempArray = jsonObjects["users"] as? [[String:Any]] {
//
//    for json in tempArray {
//      if let userId = json["id"] as? Int,
//        let first_name = json["first_name"] as? String,
//        let last_name = json["last_name"] as? String,
//        let email = json["email"] as? String {
//        let user = User(id: userId, first_name: first_name, last_name: last_name, email: email)
//        print(user)
//      }
//    }
//  }
//}



print("\n---------- [ Answer ] ----------")

struct User {
  let id: Int
  let firstName: String
  let lastName: String
  let email: String

  init?(from json: [String: Any]) {
    guard let id = json["id"] as? Int,
      let firstName = json["first_name"] as? String,
      let lastName = json["last_name"] as? String,
      let email = json["email"] as? String
      else { print("Parsing error"); return nil }

    self.id = id
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
  }
}

func answer(jsonData: Data) {
  guard let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
    let userList = json["users"] as? [[String: Any]]
    else { return }

  let users: [User] = userList.compactMap { User(from: $0) }
  users.forEach { print($0) }
}

answer(jsonData: userJSONData)





//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)


