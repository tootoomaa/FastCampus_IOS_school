# Type Check and Type Casting

## Type Check - type(of : )

- Any Type
  - 무조건 변수의 타입을 모르며 해당 변수를 사용할떄도 어떤 타입인지 확인을 해야 함

```swift
// Any
let anyArr: [Any] = [1, 2.0, "3"]
type(of: anyArr[0])
type(of: anyArr[1])
type(of: anyArr[2])

// 컴파일 타임(코딩하는 도중)에는 해당 변수가 int 타입인지 모른다.
antArr[0]. // int 메소드 사용 불가
```



- Generic 
  - 타입을 동적으로 변환할 수 있지만 내부에서는 타입이 한번 정해지면 이 속성에 따라 각각 처리할 수 있다.

```swift
func printGenericInfo<T>(_ value: T) { // t라는 변수에 어던 값이 들어올지 모름
  let types = type(of: value)
  print("'\(value)' of type '\(types)'")
}
// t에 값이 저장될 때 타입이 정해짐
printGenericInfo(1)			//'1' of type 'Int' , int관련 메소드도 사용 가능
printGenericInfo(2.0) 	// '2.0' of type 'Double'
printGenericInfo("3")		// '3' of type 'String'

//Any 타입과는 다르다.
```



## 타입 비교 - is

- 특정 변수에 대해서 타입이 같은지 검사 하고 Bool값 리턴 해줌

```swift
let number = 1
number == 1    // 값 비교
number is Int  // 타입 비교

let strArr = ["A", "B", "C"]

if strArr[0] is String {		// true, String 출력 
  "String"
} else {
  "Something else"
}
```

### 상속 관계

-  자신과 비교대상 클래스의 상태에 따라서 비교값이 달라짐
  - 자식 클래스 is 부모 클래스  -> true
  -  부모 클래스 is 자식 클래스  -> false

```swift
class Human {
  var name: String = "name"
}
class Baby: Human {
  var age: Int = 1
}
class Student: Human {
  var school: String = "school"
}
class UniversityStudent: Student {
  var univName: String = "Univ"
}

/*
    Human
   /     \
 Baby   Student
          |
    UniversityStudent
 */

let student = Student()
student is Human		// true
student is Baby			// false
student is Student  // true

let univStudent = UniversityStudent()
student is UniversityStudent  // true
univStudent is Student				// false


var human: Human = Student()
type(of: human)
// 해당 변수의 타입 vs 실제 데이터의 타입 student

// Q. human 변수의 타입, name 속성의 값, school 속성의 값은?
human.name    //  OK,   name 
human.school  //  Error!!

// 실제로 실행하여 런타임시키지 않을 경우 human은 현재 human 타입으로 되어있기 때문에
// studnet 타입의 변수에 접근할 수 없다. ( human, student의 공통 변수 제외)

// 위와 같은 맥락에서 봣을떄 자식 클래스들은 상위 클래스타입으로 가질 수 있음
human = Baby()
human = UniversityStudent()
```

- 상속 관계 연습 문제

```swift
class Human {
  var name: String = "name"
}
class Baby: Human {
  var age: Int = 1
}
class Student: Human {
  var school: String = "school"
}
class UniversityStudent: Student {
  var univName: String = "Univ"
}

/*
    Human
   /     \
 Baby   Student
          |
    UniversityStudent
 */

var james = Student()
james = UniversityStudent()

// Q. 다음 중 james 가 접근 가능한 속성은 어떤 것들인가
// A. james는 UniversityStuent값을 가지고 있지만 Student() 클래스로 정의 되어 있기때문에
//    baby 나 univName 에는 접근이 불가능하다,
james.name     // Human 속성
james.age      // Baby 속성							// Error
james.school   // Student 속성
james.univName // UniversityStudent 속성 //Error 

// Q. 그럼 Student 타입인 james 객체가 univName을 사용할 수 있도록 하려면 뭘 해야 할까요

if let james = james as? UniversityStudent {
	//james를 UniversityStudent로 정확하게 명시해주고 변수에 접근
  james.univName
}
```



## Type Casting

### 타입 변환 방법

- as : 타입 변환이 확실하게 가능한 경우(업캐스팅, 자기 자신 등) 에만 사용 가능. 그 외에는 컴파일 에러
- as? : 강제 타입 변환 시도. 변환이 성공하면 Optional 값을 가지며, 실패 시에는 nil 반환
- as! : 강제 타입 변환 시도. 성공 시 언래핑 된 값을 가지며, 실패 시 런타임 에러 발생

### upcasting

- 상속 관계에 있는 자식 클래스가 부모 클래스로 형 변환하는 것
- 업케스팅은 항상 성공하며 as 키워드를 사용
- 자기 자신에 대한 타입 캐스팅도 항상 성공하므로 as 키워드 사용

```swift
import UIKit

class Shape {
  var color = UIColor.black
  
  func draw() {
    print("draw shape")
  }
}

class Rectangle: Shape {
  var cornerRadius = 0.0
  override var color: UIColor {
    get { return .white }
    set { }
  }
  
  override func draw() {
    print("draw rect")
  }
}

class Triangle: Shape {
  override func draw() {
    print("draw triangle")
  }
}

// --- 자식 클라스 -
let rect = Rectangle()
rect.color					// 접근 가능
rect.cornerRadius		// 접근 가능

let t1 = rect as Shape			// 
let t2 = rect as Rectangle	// 

(rect as Shape).color						// OK, Shape의 클래스로 업캐스팅 되어 접근가능
(rect as Shape).cornerRadius		// Error, Shape클래스는 해당 프로퍼티가 없음

(rect as Rectangle).color					// OK
(rect as Rectangle).cornerRadius	// OK

// --- 자식 클래스 
let upcastedRect: Shape = Rectangle()
type(of: upcastedRect)   //

upcastedRect.color
upcastedRect.cornerRadius

(upcastedRect as Shape).color         // OK, 자기자신은 as 가능
(upcastedRect as Rectangle).color     // Error, 자식클래스는 사용 불가

//자식 클래스 타입 <= 부모 크래스 타입    // 불가
//자식 클래스 타입 => 부모 크래스 타입    // 성공

```



### downcasting

- 형제 클래스나 다른 서브 클래스 등 수퍼 클레스에서 파생된 각종 서브 클래스로의 타입 변환 의미
- 반드시 성공한다는 보장이 없으므로. as? 또는 as! 를 사용

```swift
let shapeRect: Shape = Rectangle()
var downcastedRect = Rectangle()

downcastedRect = shapeRect 								// Rectangle
downcastedRect = shapeRect as Rectangle		// Rectangle

downcastedRect: Rectangle = shapeRect as? Rectangle  //
downcastedRect = shapeRect as! Rectangle  //

//as? : 강제 타입 변환 시도. 변환이 성공하면 Optional 값을 가지며, 실패 시에는 nil 반환
//as! : 강제 타입 변환 시도. 성공 시 언래핑 된 값을 가지며, 실패 시 런타임 에러 발생



//Q. 아래 value 에 대한 Casting 결과는?
//A. 결과적으로 as를 통한 형변환은 불가능하다.
let value = 1
(value as Float) is Float  
(value as? Float) is Float  // value 옵셔널 변수 변환시 변환 실패로 nil반환 함으로 무조건 flase
(value as! Float) is Float  // 강제 변환 실패로 nil반환
```

