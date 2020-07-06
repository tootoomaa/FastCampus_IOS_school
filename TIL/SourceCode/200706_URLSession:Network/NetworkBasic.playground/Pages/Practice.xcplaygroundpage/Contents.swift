//: [Previous](@previous)

import Foundation

/*
 [ 실습1 ]
 다음 주소를 통해 얻은 json 데이터(국제정거장 위치 정보)를 파싱하여 출력하기
 http://api.open-notify.org/iss-now.json
 
 {"message": "success", "timestamp": 1594020334, "iss_position": {"longitude": "-126.0497", "latitude": "19.4640"}}
 
 */

func practice1() {
  let urlString = "http://api.open-notify.org/iss-now.json"
  guard let url = URL(string: urlString) else { return }
  //URLsession
  let task = URLSession.shared.dataTask(with: url) { data, response, error in
    guard error == nil else { return print(error!) }

    guard let data = data else { return }

    if let jsonObject = try! JSONSerialization.jsonObject(with: data) as? [String: Any] {

      if let coordinate = jsonObject["iss_position"] as? [String: String] {
        guard let latitude = coordinate["latitude"],
            let longitude = coordinate["longitude"]
            else { return }
          
          print(latitude, longitude)
      }

    }
  }
  task.resume()
}
practice1()



/*
 [ 실습2 ]
 Post 구조체 타입을 선언하고
 다음 주소를 통해 얻은 JSON 데이터를 파싱하여 Post 타입으로 변환한 후 전체 개수 출력하기
 https://jsonplaceholder.typicode.com/posts
 [
 {
   "userId": 1,
   "id": 1,
   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
   "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
 },
 */

struct Post {
  let userId: Int?
  let id: Int?
  let title: String?
  let body: String?
}

var posts = [Post]()

func practice2() {
  let urlString = "https://jsonplaceholder.typicode.com/posts"
  
  guard let url = URL(string: urlString) else { return }
  
  let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
    
    guard error == nil else { return print(error!) }
    guard let response = response as? HTTPURLResponse,
      (200..<400).contains(response.statusCode) else { return print("Invalid response") }
    
    guard let data = data else { return }
    print(data)
    
    guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else { return }
    
    for json in jsonObject {
      if let userId = json["userId"] as? Int,
        let id = json["id"] as? Int,
        let title = json["title"] as? String,
        let body = json["body"] as? String {
        
        posts.append(Post.init(userId: userId, id: id, title: title, body: body))
      }
    }
  }
  dataTask.resume()
}

practice2()

posts.count



//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)


