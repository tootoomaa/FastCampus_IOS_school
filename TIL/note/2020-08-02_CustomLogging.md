# CustomLogging

- 개발을 진행할때 Print 메소드를 통해서 값이 정상적인지 확인해야 할때가 있음 하지만 class를 출력할때 프로퍼티가 출력이 안되는 문제 발생

  - Struct 
    - 해당 Struct내에 있는 프로퍼티들의 값이 출력됨
  - Class 
    - 실제 해당 클래스 내에 있는 프로퍼티들의 값이 아닌 Class의 인스턴스 이름만 출력됨

  

### 일반 출력 print

- 소스코드

  - `Dog`클래스, `Cat` 구조체

  - ```swift
    // Data 정의 부분
    class Dog {
      let name = "Tory"
      let age = 5
      let feature: [String: String] = [
        "breed": "Poodle",
        "tail": "short"
      ]
    }
    
    struct Cat {
      let name = "Lilly"
      let age = 2
      let feature: [String: String] = [
        "breed": "Koshort",
        "tail": "short"
      ]
    }
    // ViewController 출력 화면
    @IBAction private func didTapPrint(_ sender: Any) {
      print("\n---------- [ print ] ----------\n")
      print("Hello, world!")
      print(1...10)
      print(dog)
      print(cat)
      print(self)
    }
    ```

- 출력 결과

  - ```swift
    //---------- [ print ] ----------
    
    Hello, world!
    1...10
    CustomLogExample.Dog // 클래스 인스턴스 명
    Cat(name: "Lilly", age: 2, feature: ["tail": "short", "breed": "Koshort"])
    <CustomLogExample.ViewController: 0x7ff933209e00>
    ```

### DebugPrint

주어진 아이탬에 최대한 디버깅에 적합하게 텍스트적 표현으로 standard output으로 나타내 줌

- 소스코드

  - ```swift
    @IBAction private func didTapDebugPrint(_ sender: Any) {
      print("\n---------- [ debugPrint ] ----------\n")
      debugPrint("Hello, world!")
      debugPrint(1...10)
      debugPrint(dog)
      debugPrint(cat)
      debugPrint(self)
    }
    ```

- 출력 결과

  - ```swift
    //---------- [ debugPrint ] ----------
    
    "Hello, world!"
    ClosedRange(1...10)
    CustomLogExample.Dog
    CustomLogExample.Cat(name: "Lilly", age: 2, feature: ["tail": "short", "breed": "Koshort"])
    <CustomLogExample.ViewController: 0x7ff933209e00>
    ```

### Dump

standard output을 통해서 해당 오브젝트의 내용을 모두 보여준다.

- 소스코드

  - ```swift
    @IBAction private func didTapDump(_ sender: Any) {
      print("\n---------- [ dump ] ----------\n")
      dump("Hello, world!")
      dump(1...10)
      dump(dog)
      dump(cat)
      dump(self)
    }
    ```

- 출력 결과

  - ```swift
    ---------- [ dump ] ----------
    
    - "Hello, world!"
    ▿ ClosedRange(1...10)
      - lowerBound: 1
      - upperBound: 10
    ▿ CustomLogExample.Dog #0
      - name: "Tory"
      - age: 5
      ▿ feature: 2 key/value pairs
        ▿ (2 elements)
          - key: "breed"
          - value: "Poodle"
        ▿ (2 elements)
          - key: "tail"
          - value: "short"
    ▿ CustomLogExample.Cat
      - name: "Lilly"
      - age: 2
      ▿ feature: 2 key/value pairs
        ▿ (2 elements)
          - key: "tail"
          - value: "short"
        ▿ (2 elements)
          - key: "breed"
          - value: "Koshort"
    ▿ <CustomLogExample.ViewController: 0x7ff933209e00> #0
      - super: UIViewController
        - super: UIResponder
          - super: NSObject
      ▿ dog: CustomLogExample.Dog #1
        - name: "Tory"
        - age: 5
        ▿ feature: 2 key/value pairs
          ▿ (2 elements)
            - key: "breed"
            - value: "Poodle"
          ▿ (2 elements)
            - key: "tail"
            - value: "short"
      ▿ cat: CustomLogExample.Cat
        - name: "Lilly"
        - age: 2
        ▿ feature: 2 key/value pairs
          ▿ (2 elements)
            - key: "tail"
            - value: "short"
          ▿ (2 elements)
            - key: "breed"
            - value: "Koshort"
    
    ```

    

## Custom Logging

로그를 찍을때 dump는 내용이 너무 많고, debugPrint는 내용이 적다고 생각 될때 사용자가 원하는 형태로 로그를 출력할 수 있도록 수정이 가능하다.



### CustomStringConvertable

CusdomStringConvertable 프로토콜을 체택하여 `description` 을 설정해 주면 해당 오브젝트를 출력할 때의 내용이 변경된다

- 소스코드

  - ```swift
    class Dog: CustomStringConvertible {
      
      let name = "Tory"
      let age = 5
      let feature: [String: String] = [
        "breed": "Poodle",
        "tail": "short"
      ]
      
      var description: String { // 일반 print 출력 문자열
        "Dog's name: \(name), age: \(age)"
      }
    }
    ```

- 출력 내용

  - ```swift
    //---------- [ print ] ----------
    Hello, world!
    1...10
    Dog's name: Tory, age: 5 // <- 변경된 출력 부분
    Cat(name: "Lilly", age: 2, feature: ["tail": "short", "breed": "Koshort"])
    <CustomLogExample.ViewController: 0x7f81fd50b730>
    ```

    - class와 관련된 출력이 변경되었다.



### CustomDebugStringConvertable

CustomDebugStringConvertible 프로토콜을 체택하여 DebugPrint를 통해 출력하는 내용을 변경할 수 있음

- 소스코드

  - ```swift
    class Dog: CustomStringConvertible, CustomDebugStringConvertible {
      
      let name = "Tory"
      let age = 5
      let feature: [String: String] = [
        "breed": "Poodle",
        "tail": "short"
      ]
      
      var description: String { // 일반 print 출력 문자열
        "Dog's name: \(name), age: \(age)"
      }
      
      var debugDescription: String { // 디버그 출력 문자열 
        "Dog's name: \(name), age: \(age), feature: \(feature)"
      }
    }
    ```

- 출력 내용

  - ```swift
    ---------- [ debugPrint ] ----------
    
    "Hello, world!"
    ClosedRange(1...10)
    Dog's name: Tory, age: 5, feature: ["breed": "Poodle", "tail": "short"]
    CustomLogExample.Cat(name: "Lilly", age: 2, feature: ["tail": "short", "breed": "Koshort"])
    <CustomLogExample.ViewController: 0x7fa0ae005eb0>
    
    ```



### ViewController의 로그 출력

ViewController 를 상속받은 경우 뷰 컨트롤러 출력시 로그도 수정할 수 있다.

- 소스코드

  - ```swift
    override var description: String {
      return "ViewController!!!"
    }
    
    override var debugDescription: String {
      return "debug in ViewController!!!"
    }
    ```

- 출력 결과

  - ```swift
    //---------- [ print ] ----------
    ViewController!!!
    //---------- [ debugPrint ] ----------
    debug in ViewController!!!
    ```



### NSLog

print할때 시간까지 확인하고 싶은 경우 사용

- 소스코드

  - `Dog`Class 수정 사항

    1. NSLog를 통해 사용자가 생성한 class를 출력해야 할 경우 NSObject를 상속받는다
    2. NSObject를 상속받는 경우 CustomStringConvertable, CustomDebugStringConvertable는 이미 존재함으로 `override` 로 변경

  - `Cat`Struct 수정 사항

    1. Struct의 경우에는 NSObject를 상속받을 수 없음
    2. 대신 CustomStringConvertable를 상속 받은 후 description을 작성한뒤 `cat.description` 을 통해 출력 가능

  - ```swift
    class Dog: NSObject { 
      let name = "Tory"
      let age = 5
      let feature: [String: String] = [
        "breed": "Poodle",
        "tail": "short"
      ]
    
      override var description: String {
        "Dog's name: \(name), age: \(age)"
      }
    
      override var debugDescription: String {
        "Dog's name: \(name), age: \(age), feature: \(feature)"
      }
    }
    
    struct Cat: CustomStringConvertible {
      let name = "Lilly"
      let age = 2
      let feature: [String: String] = [
        "breed": "Koshort",
        "tail": "short"
      ]
      
      var description: String { // 추가된 부분
        "Cat's name: \(name), age: \(age)"
      }
    }
    
    // == View Controller == 
    @IBAction private func didTapNSLog(_ sender: Any) {
      print("\n---------- [ NSLog ] ----------\n")
      NSLog("Hello, world!")
      NSLog("%@", self)
      NSLog("%@", dog)
      NSLog("%@", cat.description)
    }
    ```

- 출력 결과

  - ```swift
    //---------- [ NSLog ] ----------
    
    2020-08-02 22:37:54.484750+0900 CustomLogExample[53115:3791684] Hello, world!
    2020-08-02 22:37:54.484945+0900 CustomLogExample[53115:3791684] ViewController!!!
    2020-08-02 22:37:54.485116+0900 
    // Dog 출력 부분
    CustomLogExample[53115:3791684] Dog's name: Tory, age: 5
    
    // Cat 출력 부분
    2020-08-02 22:41:57.823374+0900 CustomLogExample[53168:3797887] Cat's name: Lilly, age: 2
    ```



### Special Literals

디버깅시 프로젝트 파일 내의 특정한 위치(라인, 띄어쓰기 등)을 통한 출력 위치를 확인하기 쉽도록 도와주는 로깅방식

- 소스코드

  - ```swift
    @IBAction private func didTapSpecialLiterals(_ sender: Any) {
      print("\n---------- [ didTapSpecialLiterals ] ----------\n")
      /*
      #file : (String) 파일 이름
      #function : (String) 함수 이름
      #line : (Int) 라인 넘버
      #culumn : (Int) 컬럼 넘버
      */
      print("file :", #file)
      print("function: ", #function)
      print("line: ", #line)
      print("column: ", #column)
      
      print("\n --------- [ print Info ] --------------\n") // 사용 예시
      print("< \(#function) [\(#line)] > \(cat) ")
    }
    ```

- 출력 정보

  - ```swift
    //---------- [ didTapSpecialLiterals ] ----------
    
    file : /Users/kimkwangsoo/Documents/fastcampus/0802_CustomLog/CustomLogExample (starter)/CustomLogExample/ViewController.swift
    function:  didTapSpecialLiterals(_:)
    line:  68
    column:  23
    
     --------- [ print Info ] --------------
    
    < didTapSpecialLiterals(_:) [72] > Cat's name: Lilly, age: 2 
    ```

    

### Custom Loggin

사용자가 원하는 형태의 로그를 생성하여 출력할 수 있다

- 소스코드 

  - ```swift
    
    class Formatter { // 날자 변환을 위한 클래스
      static let date: DateFormatter = {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "HH:mm:ss:SSS"
        return dateFomatter
      }()
    }
    
    func logger(  // 로그를 생성하는 부분
      _ contents: Any...,
      header: String = "",
      _ file: String = #file,
      _ function: String = #function,
      _ line: Int = #line
    ) {
      let emoji = "!!"
      let timestamp = Formatter.date.string(from: Date())
    
      let fileUrl = URL(fileURLWithPath: file)
      let filename = fileUrl.deletingPathExtension().lastPathComponent
    
      let header = header.isEmpty ? "" : " [ \(header) ] -"
      let content = contents.reduce("") { $0 + " " + String(describing: $1) }
    
      let combineStr = """
      \(emoji) \(timestamp) / \
      \(filename) \(function) (\(line)) \(emoji)\
      \(header) \(content)
      """
      print(combineStr)
    }
    
    // === ViewController
    @IBAction private func didTapCustomLog(_ sender: Any) {
      print("\n---------- [ Custom Log ] ----------\n")
    
      logger("Hello, world!", header: "String")
      logger(dog, header: "Dog")
      logger(cat, header: "Cat")
      logger(self, header: "ViewController")
    }
    ```

- 출력 결과

  - ```swift
    ---------- [ Custom Log ] ----------
    
    !! 23:02:07:456 / ViewController didTapCustomLog(_:) (79) !! [ String ] -  Hello, world!
    !! 23:02:07:458 / ViewController didTapCustomLog(_:) (80) !! [ Dog ] -  Dog's name: Tory, age: 5
    !! 23:02:07:458 / ViewController didTapCustomLog(_:) (81) !! [ Cat ] -  Cat's name: Lilly, age: 2
    !! 23:02:07:458 / ViewController didTapCustomLog(_:) (82) !! [ ViewController ] -  ViewController!!!
    
    ```



### 소스코드 :point_right: [링크](../SourceCode/200802_CustomLogging)