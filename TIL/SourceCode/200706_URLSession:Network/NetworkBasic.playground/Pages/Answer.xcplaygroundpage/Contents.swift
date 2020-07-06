//: [Previous](@previous)
import Foundation

/*
 [ 실습1 ]
 다음 주소를 통해 얻은 json 데이터(국제정거장 위치 정보)를 파싱하여 출력하기
 http://api.open-notify.org/iss-now.json
 */

func practice1() {
  let apiURL = URL(string: "http://api.open-notify.org/iss-now.json")!
  
  let dataTask = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
    guard let data = data,
      let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
      else { return print("No Data") }
    
    guard let coordinate = jsonObject["iss_position"] as? [String: String],
      let latitude = coordinate["latitude"],
      let longitude = coordinate["longitude"]
      else { return }
    
    print("\n---------- [ 국제 정거장 위치 ] ----------\n")
    print(latitude, longitude)
  }
  dataTask.resume()
}

practice1()


/*
 [ 실습2 ]
 Post 구조체 타입을 선언하고
 다음 주소를 통해 얻은 JSON 데이터를 파싱하여 Post 타입으로 변환한 후 전체 개수 출력하기
 "https://jsonplaceholder.typicode.com/posts"
 */

struct Post {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

func practice2() {
  let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
  
  let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let data = data,
      let postList = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]]
      else { return print("No Data") }

    var posts: [Post] = []
    for post in postList {
      guard let userId = post["userId"] as? Int,
        let id = post["id"] as? Int,
        let title = post["title"] as? String,
        let body = post["body"] as? String
        else { continue }
      let post = Post(userId: userId, id: id, title: title, body: body)
      posts.append(post)
    }

    print("\n---------- [ 포스트 ] ----------\n")
    print("총 \(posts.count)개")
  }
  dataTask.resume()
}

practice2()


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)

