//: [Previous](@previous)
import Foundation
/*:
 ---
 # NoEscaping
 - 기본값 (Swift 3.0 버전 이전까지는 @escaping이 기본)
 - 함수에서 사용된 파라미터는 함수 종료와 함께 소멸
 - self 키워드 불필요
 ---
 */
class Callee {
  deinit { print("Callee has deinitialized") }
  
  func doSomething(closure: () -> Void) { closure() }
}

class Caller {
  deinit { print("Caller has deinitialized") }
  
  let callee = Callee()
  var name = "James"
  
  func doSomething() {
    callee.doSomething {
//      self.name = "Giftbot"
      name = "Giftbot"
    }
  }
}


print("---------- [ NoEscaping ] ----------\n")

var caller: Caller? = Caller()
caller?.doSomething()

print("caller = nil")
caller = nil



//: [Next](@next)
