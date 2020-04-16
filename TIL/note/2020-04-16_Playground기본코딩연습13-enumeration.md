# playgrond 를 통한 기본 문법 연습 13 - Enumerations

## Enumerations(열거형)

- 특징
  
  - 연관된 값의 그룹에 대한 공통 타입을 정의한 뒤 type-safe하게 해당 값들을 사용 가능
  - case 키워드를 사용하여 선언하고 각각의 케이스는 소문자로 시작
  - 
  
- 선언 및 초기화 방법

  - ```swift
    let north = "north"
    let south = "south"
    let east = "east"
    let west = "west"
    
    
    enum CompassPoint {  // 동일한, 연관된 값들을 묶어서 사용
      case north
      case south
      case east
      case west
    }
    
    // 열거형 타입의 이름은 Pascal Case
    // 각각의 case는 Camel Case
    
    // 데이터 접근 방법 "." 사용
    var directionToHead1 = CompassPoint.west
    directionToHead1 = .east
    
    var directionToHead2: CompassPoint = .north
    ```


- Associated Value

  
  - 연관된 값을 받기 위해서 (값형태) 로 붙임
  
  - ```swift
    /// 예제 1
    enum OddOrEven {
      case odd(Int)				// case 뒤에 받아올 변수 정의
      case even(Int)
    }
    
    var number = OddOrEven.even(20)	// even(20)
    number = OddOrEven.odd(13)			// odd(13) 등
    
    number						// odd(13)
    type(of: number)	// __lldb_expr_409.OddOrEven.Type
    
    
    switch number {
    case .odd(let x): print("홀수 :", x)	//odd case 호출시 변수 x를 받고, : 뒤에 명령문에 해당 값 사용
    case .even(let x): print("짝수 :", x)
    }
    
    switch number {
    case let .odd(x): print("홀수 :", x)
    case let .even(x): print("짝수 :", x)
    }
    
    //예제 2
    enum Barcode {
      case upc(Int, Int, Int, Int)
      case qrCode(String)
    }
    
    var productBarcode = Barcode.upc(8, 85909, 51226, 3)
    productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
    
    productBarcode							// qrCode("ABCDEFGHIJKLMNOP")
    type(of: productBarcode)		// __lldb_expr_249.Barcode.Type (barcode enum 타입)
    
    switch productBarcode {
    case let .upc(numberSystem, manufacturer, product, check):
      print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case let .qrCode(productCode):
      print("QR code: \(productCode).")
    }
    
    ```
  
- Raw Value

  
  - Strings, Characters, or any of the Integer or Floating-point number types
  
  - raw value 는 해당 Enumeration 내에서 반드시 고유한 값이어야 함.
  
  - ```swift
    enum CompassPoint {  // 동일한, 연관된 값들을 묶어서 사용
      case north
      case south
      case east
      case west
    }
    
    CompassPoint.north					// "north"
    CompassPoint.north.rawValue // Error 
    
    
    enum Weekday: Int { // :Int로 인한 rawValue 설정됨
      case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    }
    
    Weekday.wednesday							// "wednesday"
    Weekday.wednesday.rawValue		// 3 
    
    
    enum Gender: String {	// :String 적용 후 값 직접 입력
      case male = "남자", female = "여자", other = "기타"
    }
    
    Gender.male									// "male"
    Gender.male.rawValue				// "남자"
    
    ```
  
- **Raw Values **


  - case에 매핑되는 raw값을 자동으로, 순차적으로  넣어주는 기능

  - ```swift
    enum WeekdayAgain: Int {
      case sunday = 5, monday, tuesday, wednesday, thursday, friday, saturday
    //  case sunday, monday = 100, tuesday = 101, wednesday, thursday, friday, saturday
    // 			 0																			102        103      104      105
    //  case sunday = 1, monday = 1, tuesday = 2, wednesday, thursday, friday, saturday
    //  Error , rawValue는 고유해야 한다.
    }
    WeekdayAgain.sunday						// sunday
    WeekdayAgain.sunday.rawValue	// 5
    
    WeekdayAgain.wednesday					// wednesday
    WeekdayAgain.wednesday.rawValue	// 8
    ```

  - rawValue를 이용한 초기화 

  - ```swift
    enum PlanetIntRaw: Int {
      case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto
    }
    
    PlanetIntRaw.venus					// venus
    PlanetIntRaw.venus.rawValue	// 2
    
    PlanetIntRaw(rawValue: 5)		// jupiter
    PlanetIntRaw(rawValue: 7)		// uranus
    
    PlanetIntRaw(rawValue: 0)		// nil
    PlanetIntRaw(rawValue: 15)	// nil
    ```

-  **enum 중첩 사용** ( 참고 )

  - ```swift
    enum Wearable {
      enum Weight: Int {
        case light = 1
        case heavy = 3
      }
      
      case helmet(weight: Weight)
      case boots
      
      func info() -> Int {
        switch self {
        case .helmet(let weight):
          return weight.rawValue * 2
        case .boots:
          return 3
        }
      }
    }
    
    
    let boots = Wearable.boots
    boots.info()
    
    var woodenHelmet = Wearable.helmet(weight: .light)
    woodenHelmet.info()
    
    var ironHelmet = Wearable.helmet(weight: .heavy)
    ironHelmet.info()
    ```


-  **enum 변경 (Mutating)**

  
  -  enum 타입 내부 함수에서 자기 자신의 값을 변경해야 할 경우 mutating 키워드 필요
  
  - ```swift
    enum Location {
      case seoul, tokyo, london, newyork
      
      func travelToLondon() {		// Error "Cannot agssign to value: 'self' is immutable"
        self = .london
      }
      
      mutating func travelToTokyo() {
        self = .tokyo
      }
        mutating func travel(to location: Location) {
        self = location
      }
      
      mutating func travelToNextCity() {
        switch self {
        case .seoul: self = .tokyo
        case .tokyo: self = .newyork
        case .newyork: self = .london
        case .london: self = .seoul
        }
      }
    }
    
    var location = Location.seoul				// Seoul
    location.travelToTokyo()						// tokyo
    location.travel(to: .newyork)				// newyork  self로 가진 값 선태 가능 (.seoul, .newyork)
    
    var location = Location.seoul				// Seoul
    location.travelToNextCity()					
    location.travelToNextCity()					
    location.travelToNextCity()					
    location
    ```


