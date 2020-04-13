# playgrond 를 통한 기본 문법 연습 6 - Tuples,Dictionary Enumeration

## Tuples


- 특징 

  - 특정 값, 서로 다른 타입을 묶어서 나타내주는 데이터 정의 방식


  - 유형

    - Unnamed Tuple
      
      - ```swift
        let number: Int = 10
        
        let threeNumbers: (Int, Int, Int) = (1, 2, 5)
        type(of: threeNumbers)
        
        threeNumbers				// 0.1. 1.2. 2.5
        
        threeNumbers.0			// 1
        threeNumbers.1			// 2
        threeNumbers.2			// 5
        
        
        var threeValues: (Int, Double, String) = (10,  100.0,  "이름")
        type(of: threeValues)
        
        threeValues							// 0.10, 1.100, 2."이름"
        
        threeValues.0 = 5				// .0 에 해당하는 값만 변경
        threeValues							// 0.5, 1.100, 2."이름"
        ```
      
    - Named Tuple
      
      - ```swift
        let iOS = (language: "Swift", version: "5") // loaguage, version 이름 부여
        
        iOS.0 					// swift
        iOS.1						// 5
        
        iOS.language		// swift  == iOS.0
        iOS.version			// 5			== iOS.1
        
        // 반환 타입도 tuple
        func 튜플(a: Int, b: (Int, Int)) -> (first: Int, second: Int) {
          return (a + b.0,  a + b.1)
        }
        
        let result = 튜플(a: 10, b: (20, 30))
        result.first		// 10 + 20 = 30    	다른 표현 : result.0
        result.second		// 10 + 30 = 40			같은 표현 : restul.1
        ```
      
    - Comparison Operators
      
      - tuple은 7개 미만의 요소에 대한 비교 연산자가 포함되어 있음
        
      - 7개 이상의 요소를 비교하기 위해서는 비교 연산자를 직접 구현해야 함
        
      - ```swift
        var something1: (Int, Int, Int, Int, Int, Int) = (1,2,3,4,5,6)
        var something2: (Int, Int, Int, Int, Int, Int) = (1,2,3,4,5,6)
        something1 == something2			//true
        
        var something3: (Int, Int, Int, Int, Int, Int, Int) = (1,2,3,4,5,6,7)
        var something4: (Int, Int, Int, Int, Int, Int, Int) = (1,2,3,4,5,6,7)
        something3 == something4			// Error 갯수 6개 초과
        ```
      
    - Tuple 비교 연산 
      - ```swift
        (1, "zebra") < (2, "apple")			// false
        (3, "apple") > (3, "bird")			// true  3비교후 a,b 비교
        ("blue", 1) > ("bluesky", -1)		// false bluesky가 더큼
        ("일", 1) > ("이", 2.0)					 // ture  "o" + "l" + "ㄹ" 계산으로 "ㅇ" + "ㅣ" 보다 큼
        ```

    	- **아래 상황 고려해보기**

    	  - if ~ else if  / if 문을 2개 하는 것과 차이점?
        		- ```swift
            (1, "zebra") < ("2", "apple")				//Error int형 1과 string형 "2"는 비교 불가
            ("blue", false) < ("purple", true)	//Error Bool값(ture,false)은 비교할 수가 없다
            ```
      
      - **Tuple Matching**
      
        - 튜플 매칭할때 순서에 주의

  ```swift
let somePoint = (1, 0)

switch somePoint {
case (_, 0):																// (_, 0) 일 경우 
  print("\(somePoint) is on the x-axis")		// (0, 0) 은 절대 실행이 안됨
case (0, 0):
  print("\(somePoint) is at the origin")
case (0, _):
  print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
  print("\(somePoint) is inside the box")
default:
  print("\(somePoint) is outside of the box")
}
  ```
------

## Dictionary Enumeration

- **특징**
  - ["key" : "value"] 값의 형태로 저장되어 있는 구조 (튜플과 유사)

 ```swift
let fruits = ["A": "Apple", "B": "Banana", "C": "Cherry"]

for (key, value) in fruits {
  print(key, value)
}
print() // ["c":"Cherry","A":"Apple","B":"Banana"] 튜플은 순서가 없어서 그냥 출력됨
 ```

  	- **튜플 형태로 출력**

```swift
let fruits = ["A": "Apple", "B": "Banana", "C": "Cherry"]
// 어떤 식으로 출력해야 할까요?
for element in fruits { // element는 튜플의 형태로 저장되어 있음
    print("\(element.0),\(element.1)")
}	
```
