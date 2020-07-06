//: [Previous](@previous)
import Foundation
/*:
 ---
 ## URLSession
 - 네트워크 데이터 전송 작업에 관련된 클래스 그룹을 조정하는 객체
 - 비동기 방식으로 Data, Download, Upload, Stream 4가지 유형의 작업 지원
 - SessionConfiguration에 의해 대부분의 기능과 동작 방식 결정 (shared, default 등)
 - ComplectionHandler 또는 Delegate 방식 택일
 ---
 */

// http://open-notify.org/Open-Notify-API/

let astronauts = "http://api.open-notify.org/astros.json"  // 우주비행사 정보
let apiURL = URL(string: astronauts)!

struct Astronaut {
  let craft: String
  let name: String
}

let dataTask = URLSession.shared.dataTask(with: apiURL) { data, response, error in
  guard error == nil else { print(error!); return }
  
  guard let response = response as? HTTPURLResponse,
    (200..<400).contains(response.statusCode)
    else { return print("Invalid response") }
  
  guard let data = data else { return } // 데이터 정상 확인
  
  guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
    
    print(jsonObject)
  
    guard (jsonObject["message"] as? String) == "success",
      let people = jsonObject["people"] as? [[String: String]],
      let peoplecount = jsonObject["number"] as? Int
      else { return print("Parsing Error") }
  
  print("=====[ parding Success] ========")
  
  print("총 \(peoplecount)명의 조종사가 탑승 중입니다.")
  
  print(" = 우주비행사 명단 =")
  
  people
  .compactMap {
    guard let craft = $0["craft"], let name = $0["name"] else { return nil }
    return Astronaut(craft: craft, name: name)
  }
  .forEach { print($0) }
  
}

dataTask.resume()


/*:
 ---
 ### URLSessionConfiguration
 - Shared: 별도의 구성 객체나 Delegate를 사용하지 않는 싱글톤 객체. 간단한 기본 설정으로 충분한 경우 사용
 - Default: 기본 세션. 캐시, 쿠키 등을 디스크에 기록해두었다가 이후 활용
 - Ephemeral: 임시 세션. 캐시, 로그인 정보 등을 메모리에만 기록하고 있다가 세션 종료 시 제거
 - Background: 백그라운드 세션. 앱이 실행 중이지 않은 상태에서도 데이터 전송이 필요한 경우
 ---
 */
_ = URLSession.shared
_ = URLSessionConfiguration.default
_ = URLSessionConfiguration.ephemeral
_ = URLSessionConfiguration.background(withIdentifier: "kr.giftbot.example.backgroundConfig")


// 세션 설정
let sessionConfig = URLSessionConfiguration.default

sessionConfig.allowsCellularAccess = false // 와이피이만 가능하도록
sessionConfig.timeoutIntervalForRequest = 20 // 타임아웃 대기 시간
sessionConfig.requestCachePolicy = .returnCacheDataElseLoad // 케쉬데이터 관련 설정
sessionConfig.waitsForConnectivity = true // 연결 실패 시 즉각 실패를 반환할 것인지 더 기다릴 것인지구별

sessionConfig.urlCache = URLCache.shared // 캐시 설정

// * 주의 *
// URLSession 생성 시 Configuration의 값을 복사하는 것이므로 이후의 변경 사항은 반영되지 않음
let defaultSession = URLSession(configuration: sessionConfig)
defaultSession.dataTask(with: apiURL) { (_, _, _) in }



//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)


