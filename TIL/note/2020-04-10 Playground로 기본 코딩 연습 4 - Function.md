# playgrond 를 통한 기본 문법 연습 4 - Function

### Function


- 일련의 작업을 수행하는 코드 묶음을 식별할 수 있는 특정한 이름을 부여하여 사용하는 것

- 반복적으로 사용하는 코드를 함수로 만들어 재사용함으로써 효율 증가


  - 기본 모형

- ```swift
  /* 함수의 기본 문법
   func <#functionName#>(<#parameterName#>: <#Type#>) -> <#ReturnType#> {
     <#statements#>
   }
  */
  ```


  - 유형

    - Input 과 Output 이 모두 있는 것 (Function)
      
      - ```swift
        func addNumbers(a: Int, b: Int) -> Int {
          return a + b
        }
        
        addNumbers(a: 10, b: 20) 		// 30
        addNumbers(a: 3, b: 5)			// 8
        ```
    - Input 이 없고 Output 만 있는 것 (Generator)
      
      - ```swift
        print("Hello, world!")
        
        func hello2() -> String {
          return "Hello, world!"
        }
        
        hello2()   // 함수를 호출한 코드가 String 타입의 값을 돌려받음
        ```
    - Input 이 있고 Output 은 없는 것 (Consumer)
      
      - ```swift
        func say(number: Int) {
          print(number)
        }
        
        func say(word: String) -> Void {
          print(word)
        }
        
        func say(something: String) -> () {
          print(something)
        }
        
        say(number: 1)
        say(word: "1")
        say(something: "1")
        ```
    - Input 과 Output 이 모두 없는 것
      - ```swift
        func initialization() -> void {
          var test = 0
        }
        
        initialization()
        ```

- **Function Scope**
  
  - 함수 안에서 선언한 상수는 해당 변수가 포함된 함수의 밖에서 사용될 수 없다

 ```swift
let outside = "outside"
func scope() {
  print(outside)
  let inside = "inside"
  print(inside)
}

//print(inside)		// 함수 외부에서는 inside 변수에 접근 불가
 ```

- **Argument Label**
  - 함수에 전달인자를 전달하고 내부에서 사용할 수 있도록 값에 이름을 주는것
    - argument name : 함수 내부에서 사용
    - parameter name : 함수 외부에서 사용 ( 호출 시)

```swift
/* 
 func functionName(<#parameterName#>: <#Type#>) {}
 */
func someFunction(first: Int, second: Int) {
  print(first, second)
}
someFunction(first: 1, second: 2)

/*
 func functionName(<#argumentName#> <#parameterName#>: <#Type#>) {}
 */
// 호출할때와 내부에서 사용할때 구별하기 위해 파라미터 이름 지정해줌
// Specifying Argument Labels, 파라미터 이름을 지정하는 함수 형태
func multiplyNumber(lhs num1: Int, rhs num2: Int) {
  num1 + num2	// parateterName 함수 내부에서 사용 
}
multiplyNumber(lhs: 10, rhs: 10) // argumentName 함수 호출할때 사용하는 함수

// Omitting Argument Labels, first 파라미터 이름을 생략하는 함수 형태
func someFunction(_ first: Int, second: Int) {
  print(first, second)
}

//someFunction(first: 1, second: 2)
someFunction(1, second: 2)
```

- **Default Parameter Values**
  - 함수를 호출할 때 필수적으로 값이 필요한 파라미터 설정

```swift
func functionWithDefault(param: Int = 12) -> Int {
  return param
}

functionWithDefault(param: 6)
// param is 6

functionWithDefault()
// param is 12
```

- **Variadic Parameters**
  - 변수 지정 시 일정 범위로 지정

```swift
func average(num1: Int, num2: Int){
  // 평균
}
average(num1: 1, num2: 2)
//average(num1: 1, num2: 2, num3: 3)

func arithmeticAverage(_ numbers: Double...) -> Double {  //double뒤에 "..."
  var total = 0.0
  for number in numbers {
    total += number
  }
  return total / Double(numbers.count)
}

arithmeticAverage(1, 2, 3)
arithmeticAverage(1, 2, 3, 4, 5)
arithmeticAverage(3, 8.25, 18.75)
//-------------------------가변인자 사용 시 주의점--------------------------------

func arithmeticAverage2(_ numbers: Double..., _ last: Double) { // Error
  print(numbers)									// 가변인자 다음에 오는 인자 뒤에는 값이 있어야 함
  print(last)
}
arithmeticAverage2(1, 2, 3, 5)

func arithmeticAverage3(_ numbers: Double..., and last: Double) { // 정상
  print(numbers)
  print(last)
}
arithmeticAverage3(1, 2, 3, and: 5)
```



- **Nested Functions**
  - 외부에는 숨기고 함수 내부에서만 사용할 함수를 중첩하여 사용 가능

```swift
func chooseFunction(plus: Bool, value: Int) -> Int {
  func plusFunction(input: Int) -> Int { input + 1 }
  func minusFunction(input: Int) -> Int { input - 1 }
  
  if plus {  // 함수 안에 설정된 plus는 chooseFunction밖에서 사용이 불가능하다
    return plusFunction(input: value)
  } else {
    return minusFunction(input: value)
  }
}
var value = 4
chooseFunction(plus: true, value: value)
chooseFunction(plus: false, value: value)
```
