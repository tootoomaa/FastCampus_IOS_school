//
//  ViewController.swift
//  URLSessionExample
//
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!
  private let imageUrlStr = "https://loremflickr.com/860/640/cat"
  
  
  // MARK: - Sync method
  
  @IBAction private func asyncMethod() {
    print("\n---------- [ asyncMethod ] ----------\n")
    
    guard let url = URL(string: imageUrlStr) else { return }
    
    // 동기
    //    DispatchQueue.global().async {
    //      self.imageView.image = UIImage(data: data)
    //    }
    
    //   비동기
    //    DispatchQueue.global().async {
    //
    //      if let data = try? Data(contentsOf: url ) {
    //        DispatchQueue.main.async {
    //          self.imageView.image = UIImage(data: data)
    //        }
    //      }
    //    }
    
    //    URLSession.shared.downloadTask(with: <#T##URL#>)  // 파일형태로 다운로드
    //    URLSession.shared.streamTask(with: <#T##NetService#>) // 바이트 단위의 전달 소켓통신
    
    //
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self.imageView.image = UIImage(data: data)
      }
    }
    task.resume()
  }
  
  
  // MARK: - Get, Post, Delete
  
  // https://jsonplaceholder.typicode.com/ // json 파싱 연습
  
  struct Todo {
    let userId: Int?
    let id: Int?
    let completed: Int?
    let title: String?
  }
  
  @IBAction func requestGet(_ sender: Any) {
    print("\n---------- [ Get Method ] ----------\n")
    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
    // 데이터를 읽어올때 사용
    
    guard let url = URL(string: todoEndpoint) else {
      return print("Error: cannot create URL")
    }
    print(url)
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else { return  print(error!) }
      guard let response = response as? HTTPURLResponse,
        (200..<300).contains(response.statusCode),
      response.mimeType == "application/json"
        else { return }
      
      if let data = data {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
          
          if let userId = jsonObject["userId"] as? Int,
            let id = jsonObject["id"] as? Int,
            let completed = jsonObject["completed"] as? Int,
            let title = jsonObject["title"] as? String {
            
            print("\(id), \(title)")
          }
        }
      }
    }
    task.resume()

  }
  
  
  @IBAction func requestPost(_ sender: Any) {
    print("\n---------- [ Post Method ] ----------\n")
    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos"
    
    guard let url = URL(string: todoEndpoint) else {
      return print("Error: cannot create url")
    }
    
    let newTodo: [String: Any] = ["title": "MyTodo", "userId":"20"]
    guard let jsonTodo = try? JSONSerialization.data(withJSONObject: newTodo) else { return }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = jsonTodo
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      guard let response = response as? HTTPURLResponse else { return }
      guard let data = data,
        let newItem = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else { return }
      
      print(newItem)                // 서버로 업데이트한 내용 표시
      print(response.statusCode)    // 서버 업로드 후 리스폰스 값 확인 // 201 정상
    }
    task.resume()
    
  }
  
  
  @IBAction func requestDelete(_ sender: Any) {
    print("\n---------- [ Delete Method ] ----------\n")
    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
    
    let url = URL(string: todoEndpoint)!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "DELETE"
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      guard let response = response as? HTTPURLResponse,
        response.statusCode == 200 else { return }
      
      print("delete OK")
      
    }
    task.resume()
  }
}

