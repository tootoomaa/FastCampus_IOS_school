# playgrond 를 통한 기본 문법 연습 9 - Array

## collection


- 특징 

  - 앱에서 데이터를 처리하기 위한 데이터 모음 방식 
  - 대표적인 3가지 방법
  - ![collection](../image/collection.png)
    - Array : ordered collections of values
    - Dictionary : unordered collections of key-value associations
    - Set : unordered collections of unique values

---

### Array

- 특징
  
  - 순차적인 모음
  - 0 기반 index 사용
  
- 배열 선언 방법
    
  - ```swift
    // 선언 방법
    var alphabetArray: Array<String> = []
    var alphabetArray: [String] = []
    var alphabetArray = [String]()
    //
    var arrayFromLiteral = [1, 2, 3]	// [1,2,3]
    arrayFromLiteral = []							// []
    type(of: arrayFromLiteral)				// Array<Int>.type
    ```
  
- 배열 초기화 방법
    
  - ```swift
    // Type Annotation
    let strArray1: Array<String> = ["apple", "orange", "melon"]
    let strArray2: [String] = ["apple", "orange", "melon"]
    
    // Type Inference
    let strArray3 = ["apple", "orange", "melon"]
    let strArray4 = Array<String>(repeating: "IOS", count: 5)
    // ["IOS","IOS","IOS","IOS","IOS"]
    
    // Error
    let strArray5 = ["apple", 3.14, 1] // Error <Any> 타입 필요
    ```
  
- 배열 갯수 구하기기

  - ```swift
    // 배열의 갯수 구하는 방법
    let fruits = ["Apple", "Orange", "Banana"]
    let countOfFruits = fruits.count  // 배열의 갯수 확인
    countOfFruits											// 3
      
    // 배열이 비어있는지 확인
    if !fruits.isEmpty {							// 비어 있는지 확인
      print("\(countOfFruits) element(s)")	//"3 element(s)"
    } else {
      print("empty array")
    }    
    ```
    

- 배열 내 인자 추출하기

  - ```swift
    //              0        1         2          3
    // fruits = ["Apple", "Orange", "Banana", endIndex]
    
    fruits[0]
    fruits[2]
    //fruits[123]	// 런타임 오류
    
    fruits.startIndex
    fruits.endIndex
    type(of: fruits.endIndex)
    
    fruits[fruits.startIndex]
    //fruits[fruits.endIndex] // 마지막 데이터는 갯수 -1 필요 
    fruits[fruits.endIndex - 1]
    
    fruits.startIndex == 0
    fruits.endIndex - 1 == 2 
    ```

- 배열 내 값 찾기

  - ```swift
    let alphabet = ["A", "B", "C", "D", "E"]
    // "A" 포함 유무 확인
    if alphabet.contains("A") {	// "A"를 포함한다면
      print("contains A")
    }
    
    if alphabet.contains(where: { str -> Bool in
      // code...
      return str == "A"
    }) {
      print("contains A")
    }
    // 특정 값의 index값을 추츨
    if let index = alphabet.firstIndex(of: "Q") {
      print("index of D: \(index)")			// D인 경우 index of D:3
    } else {
      print("No index")									// 데이터가 없을 경우
    }
    ```

- 배열 값 추가 

  - ```swift
    var alphabetArray = ["A"]			// ["A"]
    alphabetArray.append("B")			// ["A","B"]
    alphabetArray += ["C"]				// ["A","B","C"]
    
    ar alphabetArray2 = ["Q", "W", "E"]
    alphabetArray + alphabetArray2
    
    //alphabetArray.append(5.0)		//Error 배열의 값을 맞춰줘야함
    //alphabetArray + 1						//Error 배열의 값을 맞춰줘야함
    
    alphabetArray.insert("S", at: 0) // ["S", "A", "B", "C"]
    alphabetArray.insert("F", at: 3) // ["S", "A", "B", "F", "C"]
    ```

- 배열 값 변경

  - ```swift
    alphabetArray = ["A", "B", "C"]
    alphabetArray[0] = "Z"
    alphabetArray // ["Z", "B", "C"]
    
    alphabetArray = ["A", "B", "C", "D", "E", "F"]
    alphabetArray[2...]										//["C", "D", "E", "F"]
    alphabetArray[2...] = ["Q", "W", "E"] //["A", "B", "Q", "W", "E"]
    ```

- 배열 값 제거

  - ```swift
  alphabetArray = ["A", "B", "C", "D", "E"]
    
    let removed = alphabetArray.remove(at: 0)		// "A"
    alphabetArray																// ["A", "B", "C", "D", "E"]
    
    alphabetArray.removeAll()										// []  전체 삭제
    
    
    // index 찾아 지우기
    alphabetArray = ["A", "B", "C", "D", "E"]
    
    if let indexC = alphabetArray.firstIndex(of: "C") {
      alphabetArray.remove(at: indexC)
    }
    alphabetArray
    ```


- 배열 값 정렬

  - ```swift
  alphabetArray = ["A", "B", "C", "D", "E"]
    alphabetArray.shuffle()		// ["C", "D", "E", "B", "A"] 섞기
    alphabetArray.sort()			// ["A", "B", "C", "D", "E"] 정렬됨
    
    //shuffle , shuffled 차이점
    alphabetArray.shuffle()		// 자기 자신을 변경시킴 
    alphabetArray.shuffled()  // 변경된 String[]을 반환
    
    // 클로저 오름차순 정렬 ["E", "D", "C", "B", "A"]
    sortedArray = alphabetArray.sorted { $0 > $1 }
    alphabetArray.sorted(by: >= )
    ```
    
  
- 배열 enumerating 적용

  - ```swift
    let array = ["Apple", "Orange", "Melon"]
    
    for value in array {
      if let index = array.firstIndex(of: value) {
        print("\(index) - \(value)")
      }
    }
    print("----------")
    for tuple in array.enumerated() {
      print("\(tuple.0) - \(tuple.1)")
    //  print("\(tuple.offset) - \(tuple.element)")
    }
    print("----------")
    for (index, element) in array.enumerated() {    // 디컴포지션
      print("\(index) - \(element)")
    }
    
    print("----------")
    for (index, element) in array.reversed().enumerated() {
      print("\(index) - \(element)")
    } 	// reversed()로 배열 순서 변경
    //0 - Melon
    //1 - Orange
    //2 - Apple
    ```
