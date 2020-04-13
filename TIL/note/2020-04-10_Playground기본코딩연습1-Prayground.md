# playgrond 를 통한 기본 문법 연습 1 - Prayground

### Playground 기본 사용법

- 링크(파란 문자)를 클릭하여 원하는 곳으로 이동 가능
- 원하는 지점까지 실행하기 : shift + enter
- 전체 실행하기 : cmd + enter

### 기본 문법

- **print 문**

  - 화면에 출력하기 위한 문법

  ```swift
  print(3.14)										//3.14
  
  var num = 1
  print(num)										//1
  
  print("숫자 num")							 //숫자 num
  print("숫자 \(num)")					 //숫자 1   
  
  print("숫자", num)					   //숫자 1
  print("숫자 " + String(num))	 //숫자 1
  ```

- **comment**

  - 처리 방법

     \- // : 한 줄 주석 , Command + /

     \- /// : 한 줄 주석 + Quick Help Markup , Command + Option + /

     \- /* */ : 멀티 라인 주석

  - 주석의 목적

    - 1. 빠르게 특정 부분의 코드를 비활성화
      2. 협업 또는 인계 시 이해를 돕기 위해
      3. 자기 자신이 알아보기 위해 혹은 문서화
    - __But, 주석이 없어도 쉽게 이해할 수 있을 만한 코드를 짜는 것이 선행 과제__

- **Semicolon(;)**

  - 각 라인의 마지막에 붙는 세미콜론은 옵션
  - C, java와 달리 꼭 안적어도됨
  - 단, 한 라인에 여러 구문(다중 명령)을 사용하고 싶은 경우 세미콜론 필수
 ```swift
print(1); print(2); print(3);
//print(1);
//print(2);
//print(3);
 ```

- **Constants and Variables**
  - 상수와 변수는 현재 어떤 데이터에 대한 상태값, 속성 정보 등을 담고 있는 컨테이너
    - 상수(Constants) : 한 번 설정되면 값 변경 불가
    - 변수(Variables) : 설정한 값을 변경 가능

```swift
let maximumNumberOfLoginAttempts = 10 // 로그인 시도 횟수는 고정 값 필요
// maximumNumberOfLoginAttempts = 20  에러 발생

//currentLoginAttempt = 1 	  // 변수가 정의된 라인 위에서는 사용 불가
var currentLoginAttempt = 0
currentLoginAttempt = 1				// 변경가능
```

- **Namming**
  - 영어 외에도 유니코드 문자를 포함한 대부분의 문자를 사용해 네이밍 가능

```swift
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
let 한글 = "세종대왕"
let `let` = 1   // Swift 에서 사용되는 키워드일 경우 backquote(`) 를 이용해 사용 가능	
```

- **Type Annotation**
  - 변수 선언 시 사용될 자료의 타입을 명확하게 지정하는 것

```swift
let year: Int = 2019					//Int 타입 및 값 부여

let language: String					// String 타입으로 정의	
language = "Swift"						// 값 별도 부여

var red, green, blue: Double  // 동시 선언 가능
red = 255.0										// 선언 후 값 부여 가능
green = 150.123
blue = 75
```

- **Type Inference**
  - 변수 선언 시 초기화로 사용되는 값의 타입을 통해 변수의 타입을 추론하여 적용하는 것
  - Swift는 Type Safty 지향 언어, 컴파일 과정에서 해당 오류를 수정하도록 워닝 알려줌

```swift
let name: String = "Tory"		// Tory 대입시 자동으로 String 추론
type(of: name)							// String.Type

let age: Int = 4						// 4 대입시 자동으로 Int 추론
type(of: age)								// Int.Type

var weight = 6.4						// 6.4 대입시 자동으로 Double 추론
type(of: weight)						//Double.Type 

var isDog = true						//ture 대입시 자동으로 bool 추론
type(of: isDog)							//Bool.Type
```



