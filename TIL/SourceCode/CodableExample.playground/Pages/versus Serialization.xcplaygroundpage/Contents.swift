//: [Previous](@previous)
//: # Versus Serialization
import Foundation

struct Dog: Codable {
  let name: String
  let age: Int
}

/*:
 ---
 ### Question
 - JSONSerialization을 이용해 Dog객체 생성
 - JSONDecoder를 이용해 Dog객체 생성
 ---
 */

/*
 Basic
 */
print("\n---------- [ Basic ] ----------\n")
let jsonData = """
  {
    "name": "Tory",
    "age": 3,
  }
  """.data(using: .utf8)!

struct myDog: Codable {
  let name: String?
  let age: Int?
}

// JSONSerialization
print(jsonData)
print(" --- JSONSerialization --- ")
let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
if let jsonObject = jsonObject {
  if let name = jsonObject["name"] as? String,
    let age = jsonObject["age"] as? Int {
    print("\(name), \(age)")
  }
}

// JSONDecoder
print(" --- JSONDecoder --- ")
let jsonDecoder = JSONDecoder()
if let decodeMyDog = try? jsonDecoder.decode(myDog.self, from: jsonData) {
  print(decodeMyDog)
}




/*
 Array
 */
print("\n---------- [ Array ] ----------\n")
let jsonArrData = """
  [
    { "name": "Tory", "age": 3 },
    { "name": "Tory", "age": 3 },
  ]
  """.data(using: .utf8)!

print(" --- JSONSerialization --- ")
// JSONSerialization
if let jsonObject = try? JSONSerialization.jsonObject(with: jsonArrData) {
  
  if let json = jsonObject as? [[String:Any]] {
    
    for item in json {
      if let name = item["name"] as? String,
        let age = item["age"] as? Int {
        print("name : \(name), age: \(age)")
      }
    }
  }
}

// JSONDecoder
print(" --- JSONDecoder --- ")
if let decodeArrData = try? jsonDecoder.decode([myDog].self, from: jsonArrData) {
  print("name \(decodeArrData[0].name), age: \(decodeArrData[0].age)")
  print("name \(decodeArrData[1].name), age: \(decodeArrData[1].age)")
}



/*
 Dictionary
 */
print("\n---------- [ Dictionary ] ----------\n")
let jsonDictData = """
{
  "data": [
    { "name": "Tory", "age": 3 },
    { "name": "Tory", "age": 3 },
  ]
}
""".data(using: .utf8)!

// JSONSerialization
print(" --- JSONSerialization --- ")

if let jsonObject = try? JSONSerialization.jsonObject(with: jsonDictData) {
  
  if let json = jsonObject as? [String:Any] {
    if let dicArry = json["data"] as? [[String:Any]] {
      
      for item in dicArry {
        if let name = item["name"] as? String,
          let age = item["age"] as? Int {
          print("name : \(name), age: \(age)")
        }
      }
      
    }
  }
}

// JSONDecoder
print(" --- JSONDecoder --- ")
//
//if let decodeDic = try? JSONDecoder().decode([String:[Dog]].self, from: jsonDictData) {
//
//  print(decodeDic)
//
//}






/*:
 ---
 ### Answer
 ---
 */
print("\n---------- [ Answer ] ----------\n")

extension Dog {
  init?(from json: [String: Any]) {
    guard let name = json["name"] as? String,
      let age = json["age"] as? Int
      else { return nil }
    self.name = name
    self.age = age
  }
}

/*
 Basic
 */
print("---------- [ Basic ] ----------")
// JSONSerialization
if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
  if let dog = Dog(from: jsonObject) {
    print("Serialization :", dog)
  }
}

// JSONDecoder
if let dog = try? JSONDecoder().decode(Dog.self, from: jsonData) {
  print("Decoder :", dog)
}

/*
 Array
 */
print("\n---------- [ Array ] ----------")
// JSONSerialization
if let jsonObjects = try? JSONSerialization.jsonObject(with: jsonArrData) as? [[String: Any]] {
  
  jsonObjects
    .compactMap { Dog(from: $0) }
    .forEach { print("Serialization :", $0) }
}

// JSONDecoder
if let dogs = try? JSONDecoder().decode([Dog].self, from: jsonArrData) {
  dogs.forEach { print("Decoder :", $0) }
}


/*
 Dictionary
 */
print("\n---------- [ Dictionary ] ----------")
// JSONSerialization
if let jsonObject = try? JSONSerialization.jsonObject(with: jsonDictData) as? [String: Any],
  let data = jsonObject["data"] as? [[String: Any]] {
  
  data
    .compactMap { Dog(from: $0) }
    .forEach { print("Serialization :", $0) }
}

// JSONDecoder
if let dogs = try? JSONDecoder().decode([String: [Dog]].self, from: jsonDictData) {
  dogs.values.forEach { $0.forEach { print("Decoder :", $0) } }
}



//: [Table of Contents](@Contents) | [Previous](@previous) | [Next](@next)
