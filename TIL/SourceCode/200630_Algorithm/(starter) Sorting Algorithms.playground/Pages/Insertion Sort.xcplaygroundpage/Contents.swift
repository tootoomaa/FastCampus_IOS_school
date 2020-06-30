//: [Previous](@previous)
/*:
 ---
 # Insertion Sort (삽입 정렬)
 ---
 */

var inputCases = [
  [],
  [1],                            //
  [1, 2, 3, 5, 6, 7, 9, 10, 14],  // 완료
  [1, 1, 2, 2, 3, 3, 1, 2, 3],    // 완료
  [14, 10, 9, 7, 6, 5, 3, 2, 1],  // 완료
  [5, 6, 1, 3, 10, 2, 7, 14, 9],
  Array(1...10).map { _ in Int.random(in: 1...999) },
]

/*:
---
### 정렬 함수 구현
---
*/

func insertionSort(input: inout [Int]) {
  guard input != [] else { return }
  
  for index in 0..<input.count - 1 {
    guard input[index] > input[index+1] else { continue }
    let tempValue = input[index+1]
    input.remove(at: index+1)
    
    if index == 0 {
      input.insert(tempValue, at: 0)
    } else {
      for i in 0..<index {
        if tempValue < input[i] {
          // 현재 기준값 이전 숫자들과 비교
          input.insert(tempValue, at: i)
          break
        }
        if i == index-1 {
          // 현재 기준값 이전의 모든 숫자들과 비교 후에도 제일 큰 숫자 처리
          input.insert(tempValue, at: index)
        }
      }
    }
  }
}

var array = [5, 6, 1, 3, 10, 2, 7, 14, 9]
insertionSort(input: &array)


/*:
---
### 결과 확인
---
*/

// 정답지 - 기본 정렬 함수
let sorted = inputCases.map { $0.sorted() }

// 직접 만든 정렬 함수 적용
for idx in inputCases.indices {
  insertionSort(input: &inputCases[idx])
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
