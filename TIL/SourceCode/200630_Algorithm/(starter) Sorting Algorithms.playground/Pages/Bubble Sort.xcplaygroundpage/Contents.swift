//: [Previous](@previous)
/*:
 ---
 # Bubble Sort (버블 정렬)
 ---
 */

var inputCases = [
  [],
  [1],
  [1, 2, 3, 5, 6, 7, 9, 10, 14],
  [1, 1, 2, 2, 3, 3, 3, 3, 1, 1, 2, 2],
  [14, 10, 9, 7, 6, 5, 3, 2, 1],
  [5, 6, 1, 3, 10, 2, 7, 14, 9],
  Array(1...10).map { _ in Int.random(in: 1...999) },
]

/*:
---
### 정렬 함수 구현
---
*/

func bubbleSort(input: inout [Int]) {
  if input.isEmpty { return }
  
  for i in 1..<input.count {
    var isSorted = true
    
    for idx in 0..<input.count - i {
      guard input[idx] > input[idx + 1] else { continue }
      input.swapAt(idx, idx + 1)
      isSorted = false
    }
    guard !isSorted else {break}
  }
  
//  for reverseCount in 1..<input.count {
//    for index in 0..<input.count-1-reverseCount {
//      if input[index] > input[index+1] {
//        let temp = input[index]
//        input[index] = input[index+1]
//        input[index+1] = temp
//      }
//    }
//  }
//  print(input) // 정렬 확인 코드
}


/*:
---
### 결과 확인
---
*/

// 정답지 - 기본 정렬 함수
let sorted = inputCases.map { $0.sorted() }

// 직접 만든 정렬 함수 적용
for idx in inputCases.indices {
  bubbleSort(input: &inputCases[idx])
}

// 결과 비교. 정렬 완료가 나오면 성공
func testCases() {
  inputCases.enumerated().forEach { idx, arr in
    guard sorted[idx] != arr else { return }
    print("케이스 \(idx + 1) 정렬 실패 - \(inputCases[idx])")
  }
}
let isSuccess = sorted == inputCases
isSuccess ? print("정렬 완료") : testCases()



//: [Next](@next)
