//: [Previous](@previous)
import Foundation
/*:
 # Capture Example
 */

final class Person: CustomStringConvertible {
  let name: String
  init(name: String) {
    self.name = name
    print("\(self) has entered a chat room")
  }
  var description: String { "\(name)" }
  deinit { print("\(self) has exited!\n") }
}



func withoutBinding() {
  print("\n---------- [ Without Binding ] ----------\n")
  var person = Person(name: "James")
  
  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    print("- After 2 seconds -")
    print("\(person) is still in a chat room")
  }
  
  person = Person(name: "Doppelganger")
}

withoutBinding()
//





func captureBinding() {
  print("\n---------- [ Binding ] ----------\n")
  var person = Person(name: "James")
  
  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    [doppelganger = person] in
    print("- After 2 seconds -")
    print("\(doppelganger) is still in a chat room")
  }
  person = Person(name: "Doppelganger")
}

//captureBinding()



func equivalentToBinding() {
  print("\n---------- [ Equivalent to Binding ] ----------\n")
  var person = Person(name: "James")
  
  let doppelganger = person
  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    print("- After 2 seconds -")
    print("\(doppelganger) is still in a chat room")
  }
  person = Person(name: "Doppelganger")
}

equivalentToBinding()   // 도플,



// 반환 값 = 클로져
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
  print("\n---------- [ makeIncrementer ] ----------\n")
  var runningTotal = 0 // 함수의 지역 변수 설정
  
  // 함수 형태. 중첩 함수는 클로저의 한 종류
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  
  // 클로저 형태
//  let incrementer: () -> Int = {
//    runningTotal += amount
//    return runningTotal
//  }
  return incrementer // 함수 자체를 리턴
}

// 함수
// var runningTotal = 0의 값을 유지해서 계속 올려줌
//
let incrementer = makeIncrementer(forIncrement: 7)
incrementer()
incrementer()
incrementer()


//: [Next](@next)
