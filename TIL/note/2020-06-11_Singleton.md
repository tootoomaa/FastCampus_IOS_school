# Singleton

## 기초 이론

- 특정 클래스의 인스턴스에 접근할 때 항상 동일한 인스턴스만을 반환하도록 하는 설계 패턴
- 한 번 생성된 이후에는 프로그램이 종료될 때까지 항상 메모리에 상주
- 어플리케이션에서 유일하게 하나만 필요한 객체에 사용

```swift
/*
 iOS 싱글톤 사용 예
 */
let screen = UIScreen.main
let userDefaults = UserDefaults.standard
let application = UIApplication.shared
let fileManager = FileManager.default		// 일반적으로 앱 전체에서 하나만 정의해서 사용하는 기능 등
let notification = NotificationCenter.default
```



- static 전역 변수를 선언한 것은 지연(lazy)  생성되므로 처음  Singleton을 생성하기 전까지 메모리에 올라가지 않음
  - static var, static let : 타입 프로퍼티
    - 타입자체에서 `.` 을 찍어서 접근

```swift
// ===== Singleton =====
class SingletonClass {
  static let shared = SingletonClass() // 0x1234
  var x = 0
}

let singleton1 = SingletonClass.shared // 새로운 인스턴스가 생성됨 (0x1234 생성)
// let singleton1 = SingletoneClass() 와 동일
singleton1.x = 10

let singleton2 = SingletonClass.shared // 위에서 생성된 인스턴스(0x1234)로 접근하여 사용됨
singleton2.x = 20

singleton1.x   // 20
singleton2.x   // 20

SingletonClass.shared.x = 30

SingletonClass.shared.x  // 30
singleton1.x  // 30
singleton2.x  // 30
// 같은 x 값을 공유하게 됨

// ===== 싱글톤을 사용하는 것과 같은 개념 =====
let someVar1 = NormalClass() // 인스턴스 생성
someVar1.x = 10
let someVar2 = someVar1 // 인스턴스 공유
someVar2.x = 20
// 같은 x 값을 공유
someVar1.x // 20
someVar2.x // 20 


// ===== 다음 코드의 결과는? =====
SingletonClass().x = 99 // 새로운 인스턴스를 만들고 99 값을 넣고 메모리 상에서 바로 사라짐
SingletonClass().x   		// 새로운 인스턴스가 생성됨으로 초기값으로 설정됨 
singleton1.x  //
singleton2.x  //
```



### Question. 항상 하나의 객체만을 사용하는 것을 보장해야 하는 상황에서 아래와 같은 싱글톤 클래스를 만들었는데, 현재 상태에서 생길 수 있는 문제점은?

```swift
class MySingleton {
  static let shared = MySingleton()
  var x = 0
}

let object1 = MySingleton.shared

// 여전히 새로운 객체를 만들고 다른 객체에 접근 가능

let object2 = MySingleton()
object1.x = 10
object2.x = 20

object1.x // 10 같은 값을 공유하고자 하는데 각각 다른 값을 갖게됨
object2.x // 20
```

### Answer.  외부에서 인스턴스를 직접 생성하지 못하도록 강제해야 할 경우 생성자를 private 으로 선언  단, 일부러 새로운 것을 만들어서 쓸 수 있는 여지를 주고 싶은 경우는 무관

```swift
class PrivateSingleton {
  static let shared = PrivateSingleton()
  private init() {} // private 추가
  var x = 1
}

//let uniqueSingleton = PrivateSingleton.init()  <- Private 오류 발생
let uniqueSingleton1 = PrivateSingleton.shared
let uniqueSingleton2 = PrivateSingleton.shared
uniqueSingleton1.x // 1 초기값 
uniqueSingleton2.x // 1 초기값

uniqueSingleton1.x = 20

uniqueSingleton1.x // 20
uniqueSingleton2.x // 20


```



## Practice

### 문제1. 싱글톤 방식으로 해보기 전에 아래의 주어진 코드를 이용해 User에 친구 추가하기

```swift
class User {
  var friends: [Friends] = []
  var blocks: [Friends] = []
}

struct Friends: Equatable {
  let name: String
}

/*
 ↑ User와 Friends 타입은 수정 금지
 ↓ FriendList 타입은 수정 허용
 */

class FriendList {
  var user: User
  
  init(user: User) {
    self.user = user
  }
  
  func addFriend(name: String) {
    let tempFriend = Friends(name: name)
    user.friends.append(tempFriend)
  }
  
  func blockFriend(name: String) {
    let tempFriends = Friends(name: name)
    user.blocks.append(tempFriends)
    
    // remove Friends at friends list
    if user.friends.contains(tempFriends) {
      if let index = user.friends.firstIndex(of: tempFriends) {
        user.friends.remove(at: index)
      }
    }
  }
}


let user = User()

var friendList = FriendList(user: user)
friendList.addFriend(name: "원빈")
friendList.addFriend(name: "장동건")
friendList.addFriend(name: "정우성")
user.friends   // 원빈, 장동건, 정우성

friendList.blockFriend(name: "정우성")
user.friends   // 원빈, 장동건
user.blocks    // 정우성

```

### 문제 2.  싱글톤 클래스 이용 

```swift
class User {
  static let shared = User() // 싱글톤 
  var friends: [Friends] = []
  var blocks: [Friends] = []
}

struct Friends: Equatable {
  let name: String
}

class FriendList {
  func addFriend(name: String) {
//    let user = User()  <= 공유하는 객체가 아닌 매번 신규 생성됨
//    let friend = Friends(name: name)
//    user.friends.append(friend)
    // "원빈", "장동건", "정우성" 3명을 친구로 추가했을 때
    // 최종적으로 user.friends 에 들어있는 friend 의 숫자는?
//    print(user.friends)  원빈 1번, 장동건 1번, 정우성 1번 실행됨
    
    let user = User.shared // 싱글톤 접근 객체 생성
    let friend = Friends(name: name)
    user.friends.append(friend)
  }
  
  func blockFriend(name: String) {
    let friend = Friends(name: name)
    
    if let index = User.shared.friends.firstIndex(of: friend) {
      User.shared.friends.remove(at: index)
    }
    if !User.shared.blocks.contains(friend) {
      User.shared.blocks.append(friend)
    }
  }
}


var friendList = FriendList()
friendList.addFriend(name: "원빈")
friendList.addFriend(name: "장동건")
friendList.addFriend(name: "정우성")
User.shared.friends  // 원빈, 장동권, 정우성

friendList.blockFriend(name: "원빈")
User.shared.friends // 장동건, 정우성
User.shared.blocks // 원빈
```



## 강의 노트 :point_right: [링크](../LectureNote/Singleton.playground)