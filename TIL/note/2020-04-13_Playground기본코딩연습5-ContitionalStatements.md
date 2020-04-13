# playgrond 를 통한 기본 문법 연습 5 - Conditional Statements

## if Statements


- if 다음에 주어진 조건에 따라서 실행하는지 안하는지를 검사

- 조건은 bool값이 나오 도록 설정 필요


  - if문 기본 문법 

- ```swift
  /*
   if <#condition#> {
     <#code#>
   }
   
   if <#condition#> {
     <#statements#>
   } else {
     <#statements#>
   }
   
   - condition 은 Bool 값 (true, false)
   */
  ```


  - 유형

    - 단일 If 사용
      
      - ```swift
        var temperatureInFahrenheit = 30
        
        if temperatureInFahrenheit <= 32 {
          print("It's very cold. Consider wearing a scarf.")
        }
        ```
    - if ~ else 구분
      
      - ```swift
        temperatureInFahrenheit = 40
        
        if temperatureInFahrenheit <= 32 {
          print("It's very cold. Consider wearing a scarf.")
        } else { 				//위 조건이 틀릴 경우 무조건 실행됨
          print("It's not that cold. Wear a t-shirt.")
        }
        ```
    - if ~ else if ~ else 구문
      
      - ```swift
        temperatureInFahrenheit = 90
        
        if temperatureInFahrenheit <= 32 {
          print("It's very cold. Consider wearing a scarf.")
        } else if temperatureInFahrenheit >= 86 {
          print("It's really warm. Don't forget to wear sunscreen.")
        } else {
          print("It's not that cold. Wear a t-shirt.")
        }
        ```
    - if ~ else if
      - ```swift
        temperatureInFahrenheit = 72
        if temperatureInFahrenheit <= 32 {
          print("It's very cold. Consider wearing a scarf.")
        } else if temperatureInFahrenheit >= 86 {
          print("It's really warm. Don't forget to wear sunscreen.")
        } // 둘다 해당이 안되면 실행 안됨
        ```

**아래 상황 고려해보기**

  	- if ~ else if  / if 문을 2개 하는 것과 차이점?
	```swift
        var number = 9
      if number < 10 {
        print("10보다 작다")
      } else if number < 20 {
        print("20보다 작다")
      }
      
      if number < 10 {
      print("10보다 작다")
     }
      if number < 20 {
        print("20보다 작다")
      }
     ```

------

## switch 문

- 주어진 조건 case에 해당하는 경우에 따라서 다른 값을 리턴해주는 조건문

 ```swift
/*
 switch <#value#> {
 case <#value 1#>:
     <#respond to value 1#>
 case <#value 2#>,
      <#value 3#>:
     <#respond to value 2 or 3#>
 default:
     <#otherwise, do something else#>
 }
 
 - switch 문은 가능한 모든 사례를 반드시 다루어야 함 (Switch must be exhaustive) 
 - 앞에 조건에 안맞을 경우 무조건 default 실행
*/
 ```

  - **Switch 예문**
    - 기본적인   switch 모형으로 a, z 일 경우 문장을 출력하도록 설정

```swift
let alphabet: Character = "a"

switch alphabet {
case "a":
  print("The first letter of the alphabet")
case "z":
  print("The last letter of the alphabet")
default:
  break
//  print("Some other character")
}
```

- **Switch Default 문**
  - default를 사용하여 앞선 조건들에 해당이 안될경우 기본으로 적용되도록 설정

```swift
let approximateCount = 30

switch approximateCount {
case 0...50: 									//범위 연산자 사용 0~50 사이의 수
  print("0 ~ 50")
case 51...100:								//범위 연산자 사용
  print("51 ~ 100")		
default:
  print("Something else")			//위 조건들에 해당이 안될 경우 출력
}
```

- **value binding**
  - 변수 지정 하여 해당 위치로 어떠한 값이 오더라도 조건문에 영향을 주지 않음

```swift
let somePoint = (9, 0)

switch somePoint {
case (let distance, 0), (0, let distance):				// let distance로 정의된 값은 조건에 관계없음
  print("On an axis, \(distance) from the origin")
default:
  print("Not on an axis")  //axis 축
}
```

  - **where clause**
    - case 조건에서 추가적인 조건을 주기 위해 사용하는 옵션

```swift
let anotherPoint = (1, -1)
switch anotherPoint {
case let (x, y) where x == y:										// where 1 == -1 거짓
  print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:									// where 1 == -(-1) 참
  print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
  print("(\(x), \(y)) is just some arbitrary point")
}
```

- **fallthrough**

  - case조건에서 위에 조건에 해당하더라도 다음 조건을 무조건 실행하게됨

  ```swift
  let integerToDescribe = 3
  var description = "The number \(integerToDescribe) is"
  
  switch integerToDescribe {
  case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough											//fallthrough 로 인해 defaul 추가 실행
  default:
    description += " an integer."
  }
  print(description) // The number 3 is a prime number, and also an integer.
  ```

- **Early Exit** 

  - 조건문에서 조건만족시 즉시 해당 함수 종료
  - 기본 예제

  ```swift
  func someFunction() {
    // ...
    // ...
    
    // if 문의 조건이 맞으면 어떤 코드를 수행할 것
    if Bool.random() {
      // Bool.random()이 참일 경우 실행
    }
  
    // gaurd문의 조건을 만족할 때만 다음으로 넘어갈 것
    guard Bool.random() else { return }		 // guard 문의 조건이 true 일때 아래 조건 실행, false면 { return } 수행
    
    // ...
    // ...
  }
  ```
