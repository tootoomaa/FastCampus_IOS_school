//: [Previous](@previous)
/*:
 # JSON
 */
import Foundation

struct MacBook: Codable {
  let model: String
  let modelYear: Int
  let display: Int
}

let macBook = MacBook(
  model: "MacBook Pro", modelYear: 2020, display: 16
)

// Codable 이전 - JSONSerialization
// Codable 이후 - JSONEncoder / JSONDecoder

/*:
 ---
 ## Encoder
 ---
 */
// 스위프트에서 제공되는 기본 타입(Int,String 등)의 경우에는 바로 인코딩가능
// 사용자가 개별로 만든 타입의 경우 별도로 인코딩을 하기 위한 코드를 작성해주어야 함
print("\n---------- [ Encoder ] ----------\n")
let jsonEncoder = JSONEncoder()
let encodedMacBook = try! jsonEncoder.encode(macBook)
print(encodedMacBook) // 53byte (0,1,~~~ 데이터로 변경)


// JSON파일로 저장
let documentDir = FileManager.default.urls(
  for: .documentDirectory, in: .userDomainMask
  ).first!
let archiveURL = documentDir
  .appendingPathComponent("macBookData")
  .appendingPathExtension("json")     // macBookData.json 이름으로 저장

do {
  try encodedMacBook.write(to: archiveURL) // 파일 자체를 저장
  print(archiveURL)
} catch {
  print(error.localizedDescription)
}

/*
 file:///Users/kimkwangsoo/Library/Developer/XCPGDevices/5E207CFD-9A46-4D94-B281-3D19C487031A/data/Containers/Data/Application/6D7B0EF5-6DA5-4D24-B08F-CE8BE9A8CA9E/Documents/macBookData.json
 */

/*:
 ---
 ## Decoder
 ---
 */
print("\n---------- [ Decoder ] ----------\n")
let jsonDecoder = JSONDecoder()
if let decodedMacBook = try? jsonDecoder.decode(MacBook.self, from: encodedMacBook) {
  print(decodedMacBook)
}

// 파일에서 불러오기
if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedMacBook = try? jsonDecoder.decode(MacBook.self, from: retrievedData) {
  print(retrievedData)  // 변환 전
  print(decodedMacBook) // 젼환 후
}



/*
 Array
 */
print("\n---------- [ Array ] ----------\n")
let arr = [macBook, macBook, macBook] // 53 * 3 + a(4byte) (배열 정보 저장)

let encodedArr = try! jsonEncoder.encode(arr)
try? encodedArr.write(to: archiveURL)

if let decodedArr = try? jsonDecoder.decode([MacBook].self, from: encodedArr) {
  print(decodedArr)
}

if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedArr = try? jsonDecoder.decode([MacBook].self, from: retrievedData) {
  print(retrievedData)
  print(decodedArr)
}


/*
 Dictionary
 */
print("\n---------- [ Dictionary ] ----------\n")
let dict = ["mac": macBook, "mac1": macBook, "mac2": macBook]
let encodedDict = try! jsonEncoder.encode(dict)
try? encodedDict.write(to: archiveURL)

if let decodedDict = try? jsonDecoder.decode([String: MacBook].self, from: encodedDict) {
  print(decodedDict)
}

if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedDict = try? jsonDecoder.decode([String: MacBook].self, from: retrievedData) {
  print(retrievedData)
  print(decodedDict)
}


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
