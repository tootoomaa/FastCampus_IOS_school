# playgrond 를 통한 기본 문법 연습 8 - **Control Transfer Statement**

## Control Transfer Statement


- 특징 

  - 특정 코드에서 다른 코드로 제어를 이전하여 코드 실행 순서를 변경하는 것
  - swift에는 5가지 키워드 사용
    - continue / break / fallthrough / return / throw


  - 유형

    - continue
      
      - 현재 반복문의 작업을 중단하고 다음 반복 아이템에 대한 작업 수행
        
      - ```swift
        for num in 0...15 {
          if num % 2 == 0 {
            continue				// 짝수일 경우 다음 num으로 넘어감
          }
          print(num) 				// 홀수만 출력 됨
        } 
        ```
      
    - return 
      
      - 함수를 즉시 종료하고, return type에 해당하는 자료를 반환
        
      - ```swift
        //----------예제 1 ----------------
        func isEven(num: Int) -> Bool {
          if num % 2 == 0 {
            return true
          }
          return false
          // return num % 2 == 0  으로 해도 동일
        }
        
        isEven(num: 1)  //false
        isEven(num: 2)  //ture
        //----------예제 2 ----------------
        func returnFunction() -> Int {
          var sum = 0
          
          for _ in 1...100 {
            sum += 20
            return sum						// return은 함수 자체를 즉시 종료
          }
          return 7
        }
        print(returnFunction())  // 20 출력
        ```
      
    - break
      
      - break가 포함된 해당 제어문의 흐름을 즉각 중단 (반복문, switch 문)
        
      - ```swift
        //----------예제 1 ----------------
        for i in 1...100 {
          print(i)
          break							// break가 포함된 for문 즉시 탈출
        }  // 1 출력
        //----------예제 2 ----------------
        for i in 0...3 {
          for j in 0...3 {
            if i > 1 {
              break
            }
            print("  inner \(j)")
          }
          print("outer \(i)")
        }
        //innor 0,1,2,3  outer 0
        //innor 0,1,2,3  outer 1
        //outer 2,3
        ```

