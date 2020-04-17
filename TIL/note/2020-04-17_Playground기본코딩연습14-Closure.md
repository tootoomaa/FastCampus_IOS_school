# playgrond 를 통한 기본 문법 연습 14 - Closure

## Closure

- 특징
  
  - 코드에서 사용하거나 전달할 수 있는 독릭적인 기능을 가진 블럭
  - 함수도 클로저의 일종
  - 문법 간소화 가능, 주변 컨텍스트 값을 캡쳐하여 작업 수행 가능
  
- 종류

  - **글로벌 함수 ( Global Function )** 

    - 이름을 가지고 어디서든 사용할 수 있는 함수, 어떤 값도 캡쳐 하지 않음

  	- ```swift
      print(1)
      max(1, 2)
      func globalFunction() { }
      ```
    
  - **Nested functions**
  
    - 이름을 가지며, 감싸고 있는 함수의 값을 캡쳐하는 클로저
  
  	- ```swift
      func outsideFunction() -> () -> () {
        var x = 0
        
        func nestedFunction() {
          x += 1    // 그 자신의 함수가 가지지 않은 값을 사용
          print(x)
        }
        return nestedFunction
      }
      let nestedFunction = outsideFunction()
      nestedFunction()
      ```
      
  


   - **Closure**

       - 주변 문맥(context)의 값을 캡쳐할 수 있으며, 간단한 문법으로 쓰여진 이름 없는 클로져

       - ```swift
         /* 기본 정의 방법
          Closure Expression Syntax
          
          { <#(parameters)#> -> <#return type#> in
            <#statements#>
          }
          */
         // 기존 함수 형태
         func aFunction() {
           print("This is a function.")
         }
         aFunction()
         aFunction()
         // 클로져 호출 형태
         ({
           print("This is a closure.")
         })()
         
         // 클로저를 변수에 담아 이름 부여 가능
         let closure = {
           print("This is a closure.")
         }
         closure()
         
         // 함수도 변수로 저장 가능
         var function:() -> () = aFunction // 1  1,2번 방법 
         var function = aFunction					// 2	1,2번 방법
         function()
         
         // 같은 타입일 경우 함수나 클로저 관계없이 치환 가능
         function = closure		// () -> ()
         function()
         type(of: function)		// (() -> ()).Type
         type(of: closure)			// (() -> ()).Type
         ```
         

- **클로져 문법**

  - 파라미터 + 반환 타입을 가진 함수와 클로저 비교

  - ```swift
    // 함수
    func funcWithParamAndReturnType(_ param: String) -> String {
      return param + "!"
    }
  print(funcWithParamAndReturnType("function")) // function!
    // 클로져
    let closureWithParamAndReturnType2 = { (param: String) -> String in return param + "!"
    }
    print(closureWithParamAndReturnType2("closure")) // closure!
    
    ```
    
  - 반환 타입을 가진 클로저(파라미터 생략)
  
  - ```swift
    // Argument Label은 생략. 함수의 Argument Label을 (_)로 생략한 것과 동일
    let closureWithParamAndReturnType1: (String) -> String = { param in
      return param + "!"
    }
    print(closureWithParamAndReturnType1("closure"))
    ```
  - 파라미터, 반환 타입 모두 생략 ( 타입추론으로 자동으로 인식)
  
  - ```swift
    let closureWithParamAndReturnType3 = { param in
      param + "!"
    }
    print(closureWithParamAndReturnType3("closure"))
    ```
  - 연습문제 
  
  - ```swift
    //문자열을 입력받으면 그 문자열의 개수를 반환하는 클로져 구현
    // 1번 문제 예.   "Swift" -> 5
    let countChar = { (text: String) in text.count }
    print(countChar("swift"))
    
    //숫자 하나를 입력받은 뒤 1을 더한 값을 반환하는 클로져 구현
    // 2번 문제 예.   5 -> 6
    let plusOne = { num in  num + 1}
    plusOne(10)
    ```
  
-  **클로져 문법 최적화**

  -  특징
		- 문백을 통한 매개변수 및 반환 값에 대한 타입 추론
		- 단일 표현식 클로저에서의 반환 키워드 생략
		- 축약 인수명 / 후행 클로져 문법

  - 문법 최적화 예제
    
    ```swift
    // 입력된 문자열의 개수를 반환하는 클로져를 함수희 파라미터로 전달하는 예
    func performClosure(param: (String) -> Int) {
      param("Swift")
    }
    // 파라미터 정보:String , 반환인자 : Int, 클로져 기본 문법 상태
    performClosure(param: { (str: String) -> Int in
      return str.count
    })
    //type(of: performClosure(param: ))
    //str.count는 무조건 Int 형임으로 반환 값 생략 _ "-> Int" 삭제
    performClosure(param: { (str: String) in
      return str.count
    })
    //performClouse에 해당 클로져를 호출할 파라미터의 타입이 사전에 정의되어 있음
    // "(param: (String))"이 삭제됨
    performClosure(param: { str in
      return str.count
    })
    //파라미터 변수인 str은 $0으로 자동 매칭 됨
    performClosure(param: {
      return $0.count
    })
    //클로져 호출시 정의되어 있는 반환값으로 return 생략 가능
    performClosure(param: {
      $0.count
    })
    //이미 사전에 인식되어 있는 param: 생략 가능 
    performClosure(param: ) {
      $0.count
    }
    // 클로져 최종 최적화 형태
    performClosure() {
      $0.count
    }
    ```
