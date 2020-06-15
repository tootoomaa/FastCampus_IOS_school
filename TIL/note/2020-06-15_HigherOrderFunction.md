# Higher Order Function

- 정의

  - 고차함수란?
    - 하나 이상의 함수를 인자로 취하는 함수
    - 함수를 결과로 반환하는 함수
    - 고차 함수가 되기 위한 조건은 함수가 1급 객체여야 한다.
  - 1급 객체
    - 변수나 데이터에 할당할 수 있어야 한다.
    - 객체의 인자로 넘길 수 있어야 한다.
    - 객체의 리턴값으로 리턴할 수 있어야 한다.

  

- 예제 - 함수를 함수의 파라미터 전달

```swift
func firstClassCitizen() {
  print("function call")
}

// @escaping : 함수 밖에서도 사용한다는 것을 명시적으로 나타내기 위해 사용
func function(_ parameter: @escaping ()->()) -> (()->()) {
  return parameter
}

let returnValue = function(firstClassCitizen)
returnValue
returnValue() 

```



## forEach

- 정의

  - 컬랙션의 각 요소(Element)에 동일 연산을 적용하며, 반환값이 없는 형태

  - ```swift
    func forEach(_ body: (Int) throws -> Void) rethrows
    ```

- for 문과 forEach 차이점

  - 사용  문법 형태

    - ```swift
      let immutableArray = [1, 2, 3, 4]
      
      // 기존 for 문으로 작성
      for num in immutableArray {
        print(num, terminator: " ")
      }
      print() // 1 2 3 4 
      
      // forEach 로 작성
      immutableArray.forEach { num in
        print(num, terminator: " ")
      }
      print() // 1 2 3 4 
      ```

  - 흐름제어 방법 의 차이

    - for : break, continue 사용 가능
    - forEach : return 사용 가능

  -  연습문제

    - 1~10 까지의 숫자 중 짝수만 출력하다가 9가 되면 종료되도록  forEach 를 이용해 구현

    - ``` swift
      let tempArray = Array(1...10)
      
      // --- Answer 1 ----
      tempArray.forEach({
        if $0 > 9 { return }					// forEach 는 break 불가
        if $0.isMultiple(of: 2) {
          print($0, terminator: " ")
        }
      })
      // --- Answer 2 ----
      tempArray.forEach { (number) in
        if number < 9 {								// 내부에 조건문 설정 가능
          print(number, terminator: " ")
        }
      }
      ```

      

## Map

- 정의

  - 컬랙션의 각 요소(Element )에 동일 연산을 적용하여, 변형된 새 컬랙션 반환 ( 새로운 배열을 반환 )

  - ```swift
    func map<T>(_ transform: (Iterator.Element) throws -> T) rethrows -> [T] // 리턴값은 배열
    ```

- 사용 예제

  - ```swift
    // map을 통한 문자열 처리
    let names = ["Chris", "Alex", "Bob", "Barry"]
    names
      .map { $0 + "'s name" }
      .forEach { print($0) }
    
    /*  출력 값
    Chris's name
    Alex's name
    Bob's name
    Barry's name
    */
    
    // map을 통한 숫자 처리
    let intArr = Array<Int>(repeating: 2, count: 10) // [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
    
    var newArray = tempArray.map { (number) -> Int in 
      number * 2
    }
    
    print(newArray) // [4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
    ```

    

## Filter

- 정의

  - 컬렉션의 각 요소를 평가하여 조건을 만족하는 요소만을 새로운 컬랙션으로 반환

  - ```swift
    func filter(_ isIncluded: (String) throws -> Bool) rethrows -> [String]
    ```

- 사용 예제

  - ```swift
    let names = ["Chris", "Alex", "Bob", "Barry"]
    
    let containBNames = names
      .filter { (name) -> Bool in
        return name.contains("B") // B가 포함된 이름만 출력
      }
    print(containBNames) // ["Bob", "Barry"]
    
    names.filter { $0.contains("B") }
    ```

  - for문과 filter 비교

    - ```swift
      // for 문을 사용하는 경우
      var count = 0
      for name in anotherNames {
        if name == "Alex" {
          count += 1
        }
      }
      print(count) // 3
      
      let anotherNames = ["Alex", "Bob", "Alex", "Alex"]
      countAlexName = anotherNames.filter { $0 == "Alex" }.count
      print(countAlexName) // 3
      
      ```



##  Reduce

- 정의 

  - 컬랙션의 각 요소들을 결합하여 단 하나의 타입을 지난 값으로 변환

  - ```swift
    (1...100)
      .reduce(initialResult: Result, nextPartialResult: (Result, Int) throws -> Result)
     
    // Result Type - 결과로 얻고자하는 값의 타입
     
    // initialResult - 초기값
    // nextPartialResult - (이전 요소까지의 결과값, 컬렉션이 지닌 현재 요소)
    ```

- 사용 예제

  - ```swift
    let sum1to100 = (1...100).reduce(0) { (sum: Int, next: Int) in
      return sum + next
    }
    print(sum1to100)
    // 0 + 1 = 1
    // 1 + 2 = 3
    // 3 + 3 = 6
    // 6 + 4 = 10
    // ....
    
    print((1...100).reduce(0) { $0 + $1 })
    ```



## CompactMap

- 정의

  - 컬렉션의 각 요소 (Element)에 동일 연산을 적용하여 변형된 새 컬렉션 반환
  - 옵셔널 제거

- 사용 예제 

  - ```swift
    let optionalStringArr = ["A", nil, "B", nil, "C"]
    print(optionalStringArr)		//[Optional("A"), nil, Optional("B"), nil, Optional("C")]
    print(optionalStringArr.compactMap { $0 }) // ["A", "B", "C"]
    
    
    let numbers = [-2, -1, 0, 1, 2]
    let positiveNumbers = numbers.compactMap { $0 >= 0 ? $0 : nil } // [0, 1, 2]
    print(positiveNumbers)		// [nil, nil, Optional(0), Optional(1), Optional(2)]
    ```

    

## FlatMap

- 정의 

  - 중첩된 컬랙션을 하나의 컬렉션으로 병합

- 사용예제

  - ```swift
    let nestedArr: [[Int]] = [[1, 2, 3], [9, 8, 7], [-1, 0, 1]]
    print(nestedArr)  							// [[1, 2, 3], [9, 8, 7], [-1, 0, 1]]
    print(nestedArr.flatMap { $0 }) // [1, 2, 3, 9, 8, 7, -1, 0, 1]
    
    
    let nestedArr2: [[[Int]]] = [[[1, 2], [3, 4], [5, 6]], [[7, 8], [9, 10]]]
    print(flattenNumbers1) // [[1, 2, 3], [9, 8, 7], [-1, 0, 1]]
    
    let flattenNumbers2 = flattenNumbers1.flatMap { $0 }
    print(flattenNumbers2) // [1, 2, 3, 9, 8, 7, -1, 0, 1]
    
    nestedArr2
      .flatMap { $0 }
      .flatMap { $0 } 
    // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    ```

    

## Practice 1

```swift
struct Pet {
  enum PetType {
    case dog, cat, snake, pig, bird
  }
  var type: PetType
  var age: Int
}

var myPet = [
  Pet(type: .dog, age: 13),
  Pet(type: .dog, age: 2),
  Pet(type: .dog, age: 7),
  Pet(type: .cat, age: 9),
  Pet(type: .snake, age: 4),
  Pet(type: .pig, age: 5),
]
```

**[ 1번 문제 ]**
 Pet 타입의 배열을 파라미터로 받아 그 배열에 포함된 Pet 중   강아지의 나이만을 합산한 결과를 반환하는 sumDogAge 함수 구현 func sumDogAge(pets: [Pet]) -> Int

```swift
func sumDogAge(pets: [Pet]) -> Int {
  return pets
    .filter({ $0.type == .dog})
    .reduce(0) { $0 + $1.age }
}

sumDogAge(pets: myPet)  // 22
```



**[ 2번 문제 ]**
 Pet 타입의 배열을 파라미터로 받아 모든 Pet이 나이를 1살씩 더 먹었을 때의 상태를 지닌 새로운 배열을 반환하는 oneYearOlder 함수 구현
 func oneYearOlder(of pets: [Pet]) -> [Pet]

```swift
func oneYearOlder(of pets: [Pet]) -> [Pet] {
  var temp = [Pet]()
  pets.map { (pet)  in
    temp.append(Pet(type: pet.type, age: pet.age+1))
  }
  return temp
}

oneYearOlder(of: myPet) 
```



## Practice 2

> immutableArray 배열의 각 인덱스와 해당 인덱스의 요소를 곱한 값 중 홀수는 제외하고 짝수에 대해서만 모든 값을 더하여 결과 출력
>
> 단, 아래 1 ~ 3번에 해당하는 함수를 각각 정의하고 이것들을 함께 조합하여 위 문제의 결과를 도출할 것 
>
> 1. 배열의 각 요소 * index 값을 반환하는 함수 
>
> 2. 짝수 여부를 판별하는 함수
>
> 3. 두 개의 숫자를 더하여 반환하는 함수

```swift
let immutableArray = Array(1...40)
```



1. 배열의 각 요소 *index 값을 반환하는 함수

   - ```swift
     func mulIndexNumber(_ index:Int,_ number:Int) -> Int {
       return index * number
     }
     ```

2. 짝수 여부를 판별하는 함수

   - ```swift
     func isMultipleTwo(_ number:Int) -> Bool {
       return number.isMultiple(of: 2)
     }
     ```

3. 두 개의 숫자를 더하여 반환하는 함수

   - ```swift
     func sumNumbers(_ left:Int, _ right:Int) {
       return left + right
     }
     ```

4. 위 함수들을 조합하여 결과 구하기

   - ``` swift
     immutableArray.enumerated()
       .map(mulIndexNumber(index:number:))
       .filter(isMultipleTwo(number:))
       .reduce(0, sumNumbers(left:right:))
     ```

5. 고차 함수를 이용한 풀이

   - ``` swift
     // 고차함수 축약 없이 쓰기
     immutableArray.enumerated()
       .map { (index, number) -> Int in
        return index * number
     }.filter { (number) -> Bool in
       return number.isMultiple(of: 2) ? true : false
     }.reduce(0) { (result, number) -> Int in
       return result + number
     }
     
     // 축약 1단계
     immutableArray.enumerated()
       .map { $0 * $1 }
       .filter { $0%2 == 0 ? true : false }
       .reduce(0){ $0 + $1 }
     
     // 축약 2단계
     immutableArray.enumerated()
       .map( * )
     	.filter { $0%2 == 0 ? true : false }
       .reduce( 0,+ )
     ```



## 강의 노트 :point_right: [링크](../LectureNore/High-order function)

