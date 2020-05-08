# Navigation Controller, TabBar Controller, UserDefauts



## Navigation Controller 





### TabBarController





### UserDefaults

#### 사용 방법

- iOS에서 데이터를 파일에 저장하기 위해 사용하는 대표적인 클래스 중 하나
- 간단한 정보를 저장하고 불러올 때 사용하며 내부적으로 pList 파일로 저장

```swift
// 기본적인 저장 방법
UserDefaults.standard.set(10, forKey: "Ten")	
UserDefaults.standard.integer(forKey: "Ten")	// 10

//Double 타입 변수 저장
UserDefaults.standard.set(Double.pi, forKey: "Double Pi")
UserDefaults.standard.double(forKey: "Double Pi")

// Bool 타입 변수 저장
UserDefaults.standard.set(true, forKey: "True")
UserDefaults.standard.bool(forKey: "True")

// object로 가져올 때는 Any 타입이므로 타입 캐스팅 필요
// 오류 방지를 위한 타입 케스팅, as 사용
if let someType = UserDefaults.standard.object(forKey: "Date") as? Date {
  someType
}
```

#### 오류 처리

- 저장히자 않은 키를 통해 값을 불러올때 다음과 같이 오류 값이 발생됨

```swift
UserDefaults.standard.integer(forKey: "WrongKey") // 0
UserDefaults.standard.bool(forKey: "WrongKey")    // false
UserDefaults.standard.object(forKey: "WrongKey")  // nil
```

#### Key, value 출력 방볍

```swift
// Key 값만 출력
print(Array(UserDefaults.standard.dictionaryRepresentation().keys))

// value 값만 출력
print(Array(UserDefaults.standard.dictionaryRepresentation().values))
```

