# playgrond 를 통한 기본 문법 연습 12 - Optionals

## Optionals


- 특징 

  - Optional 은 값이 없을 수 있는(absent) 상황에 사용
  - Objective-C 에는 없는 개념
  - 옵셔널 타입은 2가지 가능성을 지님
    - 값을 전혀 가지고 있지 않음		=> nil
    - 값이 있으며, 그 값에 접근하기 위해 옵셔널을 벗겨(unwrap)낼 수 있음

- Optional 예제
  
  - ```swift
    let possibleNumber = "123"
    var convertedNumber = Int(possibleNumber) //	123
    type(of: convertedNumber)									//Optional<Int>.Type
    
    type(of: Int("123"))											//Optional<Int>.Type
    type(of: Int(3.14))												//<Int>.Type
    ```
  


- 기본 문법  및 초기화 선언

  - ```swift
    // 기본 형태
    var <#variable name#>: <#Type?#>
    var <#variable name#>: <#Optional<Type>#>
    // 초기화 선언 방법
    var optionalType1: String?   						 // 자동 초기화 nil
    var optionalType2: Optional<Int> = nil   // 수동 초기화. (값 또는 nil)
    ```
    
  
- Optional 값 변경 하기

  - ```swift
    // Optional -> NonOptional 불가능 
    
    var nonOptional1 = nil									//Error	어떤 타입의 nil인지 모른다.
    var nonOptional2: Int = nil							//Error 변수는 무조건 값이 있어야 한다
    /var nonOptionalType: Int = optionalInt	//Error 타입이 다름
    
    ```
  
  - ```swift
    // Optional <- NonOptional 가능
    
    let nonOptional = 1					// 1
    optionalInt = nonOptional		// 1
    optionalInt = 100						// 100
    
    // 각 타입이 가질 수 있는 값의 범위
     var nonOptionalNumber: Int    // 정수
     var optionalNumber: Int?      // 정수 or nil
    ```
  
- **Optional 바인딩**

  - 값이 있을수도, 없을수도 있는 옵셔널 변수를 처리하기 위한 방법
    
  - 안전한 프로그래밍 작성 가능
    
    - 기본 문법
    
    ```swift
    if let <#nonOptional#> = <#OptionalExpression#> {
       <#Code#>
     }
     while let <#nonOptional#> = <#OptionalExpression#> {
       <#Code#>
     }
     guard let <#nonOptional#> = <#OptionalExpression#> else {
       <#Code#>
     }
    ```
    
  - 예제

    ```swift
    // 예제 1
    if let number = Int(someValue) {	 // someValue를 Int변경 성공 시
      print("\"\(someValue)\" has an integer value of \(number)")
    } else {														// someValue를 Int변경 실패 시
      print("Could not be converted to an integer")
    }
    
    // 예제 2
    // 2개의 정수를 입력받아 Modulo 연산(%)의 결과를 반환하는 함수
    func calculateModulo(op1: Int, op2: Int?) -> Int? {
        guard let op2 = op2, op2 != 0 else {
            return nil
        }
        return op1 % op2
    }
    
    calculateModulo(op1: 10, op2: 4)		// 2
    calculateModulo(op1: 39, op2: 5)		// 4
    calculateModulo(op1: 20, op2: nil)	// nil
    ```

- **Forced Unwrapping**

  - 어떤 옵셔널 타입의 값에 있는 데이터를 추출하라고 컴파일러 에게 전달
    
  - 확실하게 값이 있는걸 알고 있을때 사용
    
    - 기본 문법
    
    ```swift
    if convertedNumber != nil {
    //  print("convertedNumber has an integer value of \(convertedNumber).")
      print("convertedNumber has an integer value of \(convertedNumber!).")
    }
    
    print(convertedNumber)		// "Optional(123)\n"
    print(convertedNumber!)		// "123\n"
    ```
    
  - 예제
  
    ```swift
  if let number = Int(someValue) {	 // someValue를 Int변경 성공 시
      print("\"\(someValue)\" has an integer value of \(number)")
    } else {														// someValue를 Int변경 실패 시
      print("Could not be converted to an integer")
    }
    ```
    

- **IUO (Implicitly Unwrapped Optionals)** 

  - 옵셔널 변수에서 강제로 값을 추출하는 옵션
    
  -  주의사항
    
    - 추후 어느 순간에서라도 nil 이 될 수 있는 경우에는 이 것을 사용하지 말아야 함
    - nil value 를 체크해야 할 일이 생길 경우는 일반적인 옵셔널 타입 사용
    - 프로퍼티 지연 초기화에 많이 사용
    
  - 기본 문법

    ```swift
    var assumedString: String! = "An implicitly unwrapped optional string."
    let stillOptionalString = assumedString
    type(of: assumedString)				// Optional<String>.Type
    type(of: stillOptionalString)	// Optional<String>.Type
    print(assumedString)	// "Optional("An implicitly unwrapped optional string.")\n"
    print(assumedString!) // "An implicitly unwrapped optional string.\n"
    ```

  - 예제

    ```swift
    // Implicitly Unwrapped Optional
    // Non Optional 타입인 것처럼 함께 사용 가능
    var assumedString: String! = "An implicitly unwrapped optional string."
    let stillOptionalString = assumedString
    type(of: assumedString)					// Optional<String>.Type
    type(of: stillOptionalString)		// Optional<String>.Type
    print(assumedString)						// "Optional("An implicitly unwrapped optional string.")\n"
    print(assumedString!)						// "An implicitly unwrapped optional string.\n"
    ```

    

- **Nil-coalescing Operator**

  - 옵셔널 변수값이 nil일 경우 "??" 뒤에 있는 값을 설정 (기본 값이 있으면 그냥 통과)

    - 기본 문법

    ```swift
    // 예제 1
    let anotherExpression = optionalStr ?? "This is a nil value"
    print(optionalStr)					// "nil\n"
    print(anotherExpression)		// "This is a nil value\n"
    // 예제 2
    let optionalInteger: Int? = 100
    let anotherExpression2 = optionalInteger ?? -1
    print(anotherExpression2)		// 100 옵셔널 변수(optionalInteger)에 값이 있음
    ```

  - 예제

    ```swift
    if let number = Int(someValue) {	 // someValue를 Int변경 성공 시
    print("\"\(someValue)\" has an integer value of \(number)")
    } else {														// someValue를 Int변경 실패 시
      print("Could not be converted to an integer")
    }
    ```


- **Optioanl Chaining**

  - 옵셔널 변수값이 nil일 경우 "??" 뒤에 있는 값을 설정 (기본 값이 있으면 그냥 통과)

    - 예제

    ```swift
    let greeting: [String: String] = [
      "John": "Wassup",
      "Jane": "Morning",
      "Edward": "Yo",
      "Tom": "Howdy",
      "James": "Sup"
    ]
    
    print(greeting["John"])						// "Optional("Wassup")\n"
    print(greeting["John"]?.count)		// "Optional(6)\n"
    print(greeting["NoName"])					// "nil\n"
    
    // Optional Chaining
    print(greeting["John"]?.lowercased().uppercased())		// "Optional("WASSUP")\n"
    print(greeting["Alice"]?.lowercased().uppercased())		// "nil\n"
    
    // Optional Binding
    if let greetingValue = greeting["John"] {
      print(greetingValue.lowercased().uppercased())			// "WASSUP\n"
    }
    ```
    




---

### Question

아래 두 종류 옵셔널의 차이점이 무엇일까요?

```swift

var optionalArr1: [Int]? = [1,2,3]
var optionalArr2: [Int?] = [1,2,3]


var arr1: [Int]? = [1,2,3]		// [ ] 자체가 옵셔널
arr1.append(nil)							// Error
arr1 = nil										// OK

print(arr1?.count)						// "Optional(3)\n"
print(arr1?[1])								// "Optional(2)\n"


var arr2: [Int?] = [1,2,3]		// [ Int 옵셔널 ]
arr2.append(nil)							// OK
arr2 = nil										// Error

print(arr2.count)							// 3
print(arr2[1])								// "Optional(2)\n"
print(arr2.last)							// "Optional(Optional(3))\n"
```



---




- **Optional Function Types**

  - 변수에 특정 함수를 담을 수 있음

  - 옵셔널은 함수, 변수 등에 모두 사용 가능

    - 예제
  
    ```swift
    func voidFunction() {
      print("voidFunction is called")
    }
    
    //var functionVariable: () -> () = voidFunction
    var functionVariable: (() -> ())? = voidFunction
    functionVariable?()
    
    functionVariable = nil 			// nil
    functionVariable?()					// nil
    ```
    
  - 예제
  
    ```swift
    func sum(a: Int, b: Int) -> Int {
      a + b
    }
    sum(a: 2, b: 3)
  
    var sumFunction: (Int, Int) -> Int = sum(a:b:)	// (Int, Int) -> Int
  type(of: sumFunction)														// ((Int, Int) -> Int).Type
    
    var sumFunction: ((Int, Int) -> Int)? = sum(a:b:) // (Int, Int) -> Int
    type(of: sumFunction)															// Optional<(Int, Int) -> Int>.Type
    ```

