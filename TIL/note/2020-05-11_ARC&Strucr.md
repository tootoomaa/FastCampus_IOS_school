# Memory Management & Struct

## 기본 이론

### ARC 이전에 메모리 관리 방식

1. GC (Garbage Collection)
   - 정기적으로 Garbage Collector 가 동작하여 더이상 사용되지 않는 메모리를 반환하는 방식 OS X 에서만 지원했었으나 버전 10.8 (Mountain Lion) 부터 deprecated
2. MRR (Manual Retain-Release) / MRC (Manual Referece Counting)
   - RC(Reference Counting) 를 통해 메모리를 수동으로 관리하는 방식 retain / release / autorelease 등의 메모리 관리 코드를 직접 호출 개발자가 명시적으로 RC 를 증가시키고 감소시키는 작업 수행



### ARC (Automatic Reference Counting)

- ARC 는 클래스의 인스턴스에만 적용
  -  (Class - Reference 타입 , Struct / Enum - Value 타입**)**
- 활성화된 참조카운트가 하나라도 있을 경우 메모리에서 해제 되지 않음
- 참조 타입
  - 강한 참조 (Strong) : 기본값**.** 참조될 때마다 참조 카운트 1 증가
  - 약한 참조 (Weak), 미소유 참조 (Unowned) : 참조 카운트를 증가시키지 않음 강한 순환 참조 (Strong Reference Cycles) 에 대한 주의 필요

### 참조의 종류

1. strong : 기본값. 강한 참조. Reference Count 1 증가
2. unowned : 미소유 참조. Count 증가하지 않음. 참조 객체 해제 시에도 기존 포인터 주소 유지
3. weak : 약한 참조. Count 증가하지 않음. 참조하던 객체 해제 시 nil 값으로 변경

## ARC 실습

- 일반 참조 방식 실습

```swift
class Person {
  let testCase: String
  init(testCase: String) {
    self.testCase = testCase
  }
  deinit { // person이 해제되면 아래 print문 출력
    print("\(testCase) is being deinitialized")
  }
}

//----  ### case 1. Allocation & Release  ----

var obj1: Person? = Person(testCase: "case1") // refCount = 1 
obj1 = nil  //case1 is being deinitialized		// refCount = 0, 메모리 해제


 // ---- ### case 2. 참조 카운트 증가  ----

var obj2: Person? = Person(testCase: "case2")		//refCount = 1
var countUp = obj2															//refCount = 2

obj2 = nil																			// refCount = 1
countUp = nil  // case2 is being deinitialized  // refcount = 0,  메모리 해제


// ---- ### case 3. Collection 에 의한 참조 카운트  ----

var obj3: Person? = Person(testCase: "case3")		// refCount = 1
var array = [obj3, obj3]												// refCount = 3

obj3 = nil																			// refCount = 2
array.remove(at: 0)															// refCount = 1
array.remove(at: 0)  //case3 is being deinitialized		//refCount = 0, 메모리 해제

```



- String, unowned, week 참조 방식 실습

```swift
var strongObj4 = Person(testCase: "case4")	// count = 1
print(strongObj4)														// person 출력

weak var weakObj4 = Person(testCase: "case4") // count = 0
print(weakObj4)																// nil, 생성되자마자 파기됨

unowned var unownedObj4 = Person(testCase: "case4")	// count = 0
print(unownedObj4)	  // 만들어지자마자 없어졌지만 해당 주소에 값이 없음	//  Error


// unowned 와 weak 의 타입은?
print("Unowned type: ", type(of: unownedVar))	// Unowned type:  Person\n"
print("Weak type: ", type(of: weakVar))				// Weak type:  Optional<Person>\n"

```

- Strong Reference Cycles

```swift
class Person {
  var pet: Dog?
  func doSomething() {}
  deinit {
    print("Person is being deinitialized")
  }
}

class Dog {
  var owner: Person?
  func doSomething() {}
  deinit {
    print("Dog is being deinitialized")
  }
}

var giftbot: Person? = Person()  // count 1
var tory: Dog? = Dog()					// count 1

giftbot?.pet = tory							// Dog - count 2
tory?.owner = giftbot						// Person - count 2

// -- Question -----------------------------------
// 두 객체를 메모리에서 할당 해제하려면 어떻게 해야 할까요?

// 순서 주의, 순서가 변경될 경우 해재 불가
giftbot?.pet = nil // Dog - count 1
tory?.owner = nil  // person - count 1

giftbot = nil	// Person - count 0
tory = nil		// Dog - count 0

```



### 연습 문제 

```swift
/***************************************************
 1. 문제가 있는지 없는지 확인
 2. 문제가 없다면 참조카운트가 어떻게 바뀌면서 잘 해결이 되었는지 정리하고
    문제가 있다면 어떤 부분이 그런지 알아보고 직접 해결해 볼 것
 ***************************************************/
import UIKit

final class MemoryViewController: UIViewController {
  
  final class Person {
    var apartment: Apartment?
    let name: String
    
    init(name: String) {
      self.name = name
    }
    deinit {
      print("\(name) is being deinitialized")
    }
  }
  
  final class Apartment {
    var tenant: Person?
    let unit: String
    
    init(unit: String) {
      self.unit = unit
    }
    deinit {
      print("Apartment \(unit) is being deinitialized")
    }
  }
  
  var person: Person? = Person(name: "James")
  var apartment: Apartment? = Apartment(unit: "3A")
  
  func loadClass() {
    var person1 = Apartment.self
    var apartment1 = Person.self
    person?.apartment = apartment
    apartment?.tenant = person
  }
  
  deinit {
    print("MemoryViewController is being deinitialized")
  }
}


var memoryVC: MemoryViewController? = MemoryViewController()
memoryVC?.loadClass()
memoryVC = nil
/*MemoryViewController is being deinitialized
Person, apartment 가 해제되지 않음
*/
// -------------------- Answer  ------------------------
memoryVC?.person?.apartment = nil
memoryVC = nil

// MemoryViewController is being deinitialized
// Apartment 3A is being deinitialized
// James is being deinitialized
```



## Struct 

### 클래스와 구조체 공통점

- 값을 저장하기 위한 프로퍼티
- 기능을 제공하기 위한 메서드
- 초기 상태를 설정하기 위한 생성자
- 기본 구현에서 기능을 추가하기 위한 확장(Extension)
- 특정 값에 접근할 수 있는 첨자(Subscript)
- 특정한 기능을 수행하기 위한 프로토콜 채택
- Upper Camel Case 사용

### class, Struct  비교

```swift
// 생성자 비교
// 1. var로 선언된 변수
class UserClass1 {
  var name = "홍길동"
}
struct UserStruct1 {
  var name = "홍길동"
}

let userC1 = UserClass1()
let userS1_1 = UserStruct1()
let userS1_2 = UserStruct1(name: "깃봇") // struct는 프로퍼티 초기화 가능
userS1_1.name		// 홍길동
userS1_2.name		// 깃봇

// 2. 프로퍼티에 초기화 값이 없을때
class UserClass2 {
  var name: String
  // 클래스는 초기화 메서드 없으면 오류
  init(name: String) { self.name = name }
}

struct UserStruct2 {
  var name: String
  var age: Int
  
// 초기화 메서드 자동 생성
// 단, 생성자를 별도로 구현했을 경우 자동 생성하지 않음
//  init(name: String) {
//    self.name = name
//    self.age = 10
//  }
}


// 3. 저장 프로퍼티 중 일부에만 초기화 값이 있을 때
class UserClass3 {
  let name: String = "홍길동"
  // 저장 프로퍼티 중 하나라도 초기화 값이 없는 경우 생성자를 구현해야 함
//  let age: Int
}

struct UserStruct3 {
  let name: String = "홍길동"
  let age: Int
}
// 초기화 값이 없는 저장 프로퍼티에 대해서만 생성자로 전달
let userS3 = UserStruct3(age: 10) 		// age를 설정하도록 자동으로 만들어짐

```

- 편의 생성자 
  1. 편의 생성자는 초기화 조건의 일부를 기본값으로 할 수 있다.

```swift
class UserClass4 {
  let name: String
  let age: Int
  // 지정 생성자 에서는 모든 저장 프로퍼티를 초기화 해야 함
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
  // age는 새로 받고, name은 기본값으로 저장
  convenience init(age: Int) {	
    self.init(name: "홍길동", age: age)
  }
}
```

​	2.  편의 생성자는 다른 init을 받아다가 쓸 수 있다.

```swift
struct UserStruct4 {
  let name: String
  let age: Int
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
  
  // Convenience 키워드 사용 X, 지정과 편의 생성자 별도 구분 없음
//  convenience init(age: Int) {
  init(age: Int) {
    self.init(name: "홍길동", age: age)
  }
}
```



### 클래스만 제공되는 기능

- 상속 (Inheritance)
- 소멸자 (Deinitializer)
- 참조 카운트 (Reference counting)

```swift
// 상속
struct ParentS {}
//struct Child: Parent {}   // 오류


// 소멸자
struct Deinit {
//  deinit { }    // 오류
}

// 참조 카운트(Reference Counting)  X
```

