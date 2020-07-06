//: [Previous](@previous)
import Foundation
/*:
 ---
 ## UrlComponents
 ---
 */
print("\n---------- [ UrlComponents ] ----------\n")

/*
 http://username:password@www.example.com:80/index.html?key1=value1&key2=value2#myFragment
 */

var components = URLComponents()
components.scheme = "http"
print(components)
components.user = "username"
print(components)
components.password = "password"
print(components)
components.host = "www.example.com"
print(components)
components.port = 80
print(components)
// path의 경우에는 다른 것들과 달리 /로 시작해야 함
components.path = "/index.html"
print(components)
components.query = "key1=value1&key2=value2"
print(components)
components.fragment = "myFragment"
print(components)

// query만 교체하기
var comp = URLComponents(string: "http://www.example.com/index.html?key1=value1#frag")
comp?.queryItems = [
  URLQueryItem(name: "name", value: "tory"),
  URLQueryItem(name: "breed", value: "poodle"),
  URLQueryItem(name: "age", value: "5"),
]
print(comp?.url?.absoluteString ?? "")




/*:
 ---
 ## URLEncoding
 ---
 */
print("\n---------- [ URLEncoding ] ----------\n")

 // 영어 주소
let urlStringE = "https://search.naver.com/search.naver?query=swift"
print("영문 주소 변환 :", URL(string: urlStringE) ?? "Nil")


// 한글 주소
let urlStringK = "https://search.naver.com/search.naver?query=한글"
print(URL(string: urlStringK) ?? "Wrong URL")


// Percent Encoding
let str = "https://search.naver.com/search.naver?query=한글"
let queryEncodedStr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
let convertedURL = URL(string: queryEncodedStr)!
print("Encoded 한글 :", convertedURL)  // %ED%95%9C%EA%B8%80


/*
 CharacterSet.urlUserAllowed
 CharacterSet.urlPasswordAllowed
 CharacterSet.urlHostAllowed
 CharacterSet.urlPathAllowed
 CharacterSet.urlQueryAllowed
 CharacterSet.urlFragmentAllowed
 */


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)


