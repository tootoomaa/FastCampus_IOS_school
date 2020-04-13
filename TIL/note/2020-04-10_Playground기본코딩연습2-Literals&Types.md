# playgrond 를 통한 기본 문법 연습 2 - Literals & Types

### **Literals & Types**

- 리터럴
  - 소스코드에 고정된 값으로 표현되는 문자(데이터) 그 자체
  - 정수 / 실수 / 문자 / 문자열 / 불리언 리터럴 등
  - Numeric Literals

```swift
var signedInteger = 123					// 123
signedInteger = +123						// 123
signedInteger = -123						// -123
type(of: signedInteger)					// Int.Type

// 10진수
let decimalInteger = 17					// 17
// 2진수
let binaryInteger = 0b10001			// 17
type(of: binaryInteger)					// Int.Type

// 8진수
let octalInteger = 0o21					// 17
// 16진수
let hexadecimalInteger = 0x11		// 17

var bigNumber = 1_000_000_000		// 단위 확인을 위한 '_' 가능
bigNumber = 1_0000_0000_0000		// 1000000000000
bigNumber = 000_001_000_000_000 // 1000000000
bigNumber = 0b1000_1000_0000		// 2176
bigNumber = 0xAB_00_FF_00_FF		// 734456119551
```

- **Integer Types**

  - 8-bit : Int8, UInt8

     16-bit : Int16, UInt16

     32-bit : Int32, UInt32

     64-bit : Int64, UInt64

     Platform dependent : Int, UInt (64-bit on modern devices)

 ```swift
var integer = 123								// 123
integer = -123									// -123
type(of: integer)								// Int.Type

var unsignedInteger: UInt = 123 // 123
type(of: unsignedInteger)				// UInt.Type

MemoryLayout<Int8>.size					// 1
Int8.max												// 127 (2^7-1) 부호비트 1개 사용
Int8.min												// -128 (2^7) 

MemoryLayout<UInt8>.size				// 1
UInt8.max												// 255 (2^8 -1) 부호비트 1개 제거
UInt8.min												// 0

MemoryLayout<Int32>.size				// 8 
Int32.max												// 2^32-1 
Int32.min												// 2^32

let q1 = Int(Int32.max) + 1
Int32.max + 1										// 오버플로우 발생 
Int64.max + 1										// 오버플로우 발생
// 기기별 32비트, 64비트를 확인하여 주의
 ```

- ​	**Overflow Operators**

```swift
// 아래 각 연산의 결과는?

// Overflow addition
//var add: Int8 = Int8.max + 1
var add: Int8 = Int8.max &+ 1		// -128

Int8.max &+ 1				// -128
Int32.max &+ 1			// -2147483648
Int64.max &+ 1			

// 01111111 +1 = 10000000 (-128)
```

- **Boolean Literal**
  - 참(ture), 거짓(faluse)를 통해 참 거짓을 구분할수 있다.
  - 무조건 소문자의 'true', 'false' 로 정의

```swift
var isBool = true				// ture
type(of: isBool)				// Bool.Type

isBool = false					// false
//isBool = 1		(참) swift 사용 불가
//isBool = 0		(거짓)  swift 사용 불가
```

- **Character Literal** && **String Literal**
  - 문자 형식과 문자열 형식 비교

```swift
## Character
var nonCharacter = "C"						// "C"
type(of: nonCharacter)						// String.Type

var character: Character = "C"		// "C"
type(of: character)								// Character.Type

MemoryLayout<String>.size					// 16
MemoryLayout<Character>.size			// 16
//character = "string"						// Error (스트링입력 불가)
//character = ' '									// Error ("" 사용 필수)
//character = ""									// Error (빈값 불가)
//character = " "									// 사용 가능 (빈칸도 문자 중 하나)

## String
let str = "Hello, world!"					// "Hello, world"
type(of: str)											// String.Type

let str1 = ""											// ""
type(of: str1)										// String.Type

var language: String = "Swift"		// "Swift"
```

- **Typealias**
  - 문맥상 더 적절한 이름으로 기존 타입의 이름을 참조하여 사용하고 싶을 경우 사용

```swift
// typealias <#type name#> = <#type expression#>

typealias Name = String						

let name: Name = "Tory"						// "Tory"
let nameString: String = "Tory"		// "Tory"

type(of: name)										// String.Type
type(of: nameString)							// String.Type
```

- **Type Conversion**
  - 타입을 변경하기 위한 문법

```swift
let height = Int8(5)					// Int8 으로 정의됨
let width = 10								// Int 로 정의 됨
//let area = height * width		// Error Int8 * Int 연산 불가

let h = Int8(12)
//let x = 10 * h							// 정상 Int8(타입추론) * Int8 연산 가능

let num = 10
let floatNum = Float(num)			// Int -> float 변경
type(of: floatNum)						// Float.Type

let signedInteger = Int(floatNum)	// 10
type(of: signedInteger)						// Int.Type

let str = String(num)							// Int -> String 으로 변경 "10" 
type(of: str)											// String.Type
```
