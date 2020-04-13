# playgrond 를 통한 기본 문법 연습 7 - Loop(for, while)

## for-in Loops


- 특징 

  - 주어진 값에 따라서 순차적으로 반복하는 loop문


  - 유형

    - 기본적인 문법
      
      - ```swift
        for index in 1...4 {			// index 는 1부터 4까지 순차적으로 증가
          print("\(index) times 5 is \(index * 5)")
        }
        // 1 times 5 is 5
        // 2 times 5 is 10
        // 3 times 5 is 15
        // 4 times 5 is 20
        ```
      
    - string to chracter with terminator
      
      - ```swift
        for chr in "Hello" {
          print(chr, terminator: " ")
        }
        print()
        ```
      
    - string to charater
      
      - string에 조건 포함 시 첫글자부터 문자(charactor)로 변경함
        
      - ```swift
        for chr in "Hello" {					// 문자열을 charactor형 으로 변경 
          print(chr, terminator: " ") // \n 개행 문자가 아닌 " "으로 변경
        }
        print()	// H e l l o 
        ```
      
    - list with loop
      - ```swift
        let list = ["Swift", "Programming", "Language"]
        for str in list { //list에 있는 변수를 하나씩 입력 받음
          print(str) 		
        }
        // swift
    // Programming
    	  // Language
        ```
    	
    - **연습 문제 풀어보기**
    
      - 1. for 문을 이용하여 3 의 10 제곱에 대한 결과값을 표현하는 코드 구현
          ```swift
        var result:Int = 3
        for i in 0..<10 {
            result *= 3
            print(i)
        }
        print(result)
          ```
         2. for 문을 이용하여 10부터 1까지 내림차순으로 출력하는 코드 구현
        
         ```swift
        for i in 0..<10 {
            print(10-i)
        }
        //reserved(). terminator 사용
        for i in (1...10).reversed() {
            print(i,terminator: " ")
        }
         ```

------

## While Loops

- **특징**
  - 조건이 거짓이 될 때까지 일련의 명령문 수행
  - 첫 번째 반복이 시작되기 전에 반복 횟수를 알지 못할 때 많이 사용
  - while / repeat-while
- 유형
  - 기본 문법
    - ```swift
  /*
       while <#condition#> {
         <#code#>
       }
      
       - 루프를 통과하는 각 패스의 시작 부분에서 조건을 평가
       */
      ```
    
  - while 기본 : 조건을 먼저 검사하고 코드를 실행
    - ```swift
	  var num = 0
    var sum = 0
    while num <= 100 { // num이 101이 되면 종료
        sum += num	//1~100 까지의 합
        num += 1
      }
      num  // 101
      sum  // 5050    
      ```
    
  - repeat ~ while : 코드를 먼저 실행하고 조건을 체크함
    - ```swift
	  // 특정 숫자를 받아서 해당 숫자의 구구단을 출력하는 방법
    func printMultiplicationTable1(for number: Int) {
      var i = 1
        repeat {
          print("\(number) * \(i) = \(number * i)")
          i += 1
        } while i <= 9	// 조건이 뒤쪽에 있기 때문에 위 함수가 반드시 한번은 실행됨
      }
		  printMultiplicationTable1(for: 3) // 구구단 3단 출력
      ```
  
 - **연습문제** 

    - 1. 2 ~ 9 사이의 숫자를 입력받아 해당 숫자에 해당하는 구구단 내용을 출력하는 함수 (while)

    - ```swift
      func googoodan(number: Int) {
          var count = 1
          
          while count < 10 {
              print("\(number) * \(count) = \(number*count)")
              count += 1
          }
      }
      ```

