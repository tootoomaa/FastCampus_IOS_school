# playgrond 를 통한 기본 문법 연습 3 - Operation

### **Basic Operators**

- Terminology

```swift
let a = 123
let b = 456
let c: Int? = 789

// Unary Operator (단항 연산자)
-a

// Prefix (전위 표기법)
-a

// Postfix (후위 표기법)
c!

// Binary Operator (이항 연산자)
a + b

// Infix (중위 표기법)
a + b

// Ternary Operator (삼항 연산자)
// Swift 에서 삼항 연산자는 단 하나
a > 0 ? "positive" : "zero or negative"  //아래 if else 문과 동일
//if a > 0 {
//  "positive"
//} else {
//  "negative"
//}
```

- **Assignment Operators**
  - 변수 계산 방법 (+,-,%,/,*)

 ```swift
var value = 0													// 0
value = value + 10										// 10
value = value - 5											// 5
value = value * 2											// 10
value = value / 2											// 5
value = value % 2											// 1  값을 2로 나눈 나머지

// Compound assignment Operators
value += 10
value -= 5
value *= 2
value /= 2
value %= 2

// 미지원 : value++ , value-- | 연산자의 위치에 따라서 오류 발생 가능성을 사전에 차단 
// value++												
// value += 1
// value = value + 1

var (x, y) = (1, 2)									// 튜플
print(x, y)													// x = 1 , y = 2
 ```

- ​	**Comparison Operators**
  - 비교연산자로써 2가지 값을 비교하여 bool 값 리턴

```swift
// Equal to operator
a == b

// Not equal to operator
a != b

// Greater than operator
a > b

// Greater than or equal to operator
a >= b

// Less than operator
a < b

// Less than or equal to operator
a <= b
```

- **Logical Operators**
  - 참(ture), 거짓(faluse)의 조합을 통해 Bool 값 리턴

```swift
// Logical AND Operator
true && true
true && false
false && true
false && false

// Logical OR Operator
true || true
true || false
false || true
false || false

// Logical Negation Operator
!true																// ture -> false
!false															// false -> true

// Combining Logical Operators
let enteredDoorCode = true
let passedRetinaScan = false
let hasDoorKey = false
let knowsOverridePassword = true

// 다음 논리식에서 어떤 상황일 때 "Open the door"가 출력될까요?
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
  print("Open the door")				// 실행됨
} else {
  print("Can't open the door")
}

// Explicit Parentheses
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
  // ...
} else {
  // ...
}

////Quiz

func returnTrue() -> Bool {
  print("function called")
  return true
}

// 아래 3개의 케이스에서 returnTrue 메서드는 각각 몇 번씩 호출될까?
// 우선순위 : && > ||

print("\n---------- [ Case 1 ] ----------\n")			// 3번 출력
returnTrue() && returnTrue() && false || true && returnTrue()

print("\n---------- [ Case 2 ] ----------\n")			// 2번 출력
returnTrue() && false && returnTrue() || returnTrue()

print("\n---------- [ Case 3 ] ----------\n")			// 1번 출력
returnTrue() || returnTrue() && returnTrue() || false && returnTrue()
//   ture   ||  ture/false  관계 없이 맨 앞 true리턴 후 즉시 종료
```

- **Range Operators**
  - 변수 지정 시 일정 범위로 지정

```swift
print("\n---------- [ Range Operators ] ----------\n")
// Closed Range Operator
0...100

for index in 1...5 {
  print("\(index) times 5 is \(index * 5)")
}

// Half-Open Range Operator
0..<100

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {   // 0, 1, 2, 3
  print("Person \(i + 1) is called \(names[i])")
}

// One-Sided Ranges
1...					// 1 이상의 모든 숫자
...100				// 100 이하의 모든 숫자
..<100				// 99 이하의 모든 숫자

//               0       1        2       3
//let names = ["Anna", "Alex", "Brian", "Jack"]
names[2...] 		// ["Brian", "Jack"]
names[...2]			// ["Anna",Brian", "Jack"]
names[..<2]			// ["Anna","Alex"]


//  순서를 반대로 적용하는 방법
for index in (1...5) {
  print("\(index) times 5 is \(index * 5)")
}

// 1) reversed
for index in (1...5).reversed() {
  print("\(index) times 5 is \(index * 5)")
}
print()

// 2) stride
for index in stride(from: 5, through: 1, by: -1) {
  print("\(index) times 5 is \(index * 5)")
}
print()
```

