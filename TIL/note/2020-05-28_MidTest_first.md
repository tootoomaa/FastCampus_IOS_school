# 2차 필기 시험 정리

## 오답정리

### 1. enum을 통한 로그인 출력 문제

#### **문제 설명**

 구글(google), 카카오(kakao), 네이버(naver) 로그인을 위해 Site라는 이름의 Enum 타입을 만들고자 합니다.
 각 case는 사용자의 아이디(String)와 비밀번호(String)를 위한 연관 값(associated value)을  가집니다.
 그리고 Site 타입 내부에는 signIn()이라는 이름의 메서드를 만들어 다음과 같이 문자열을 출력하는 기능을 구현해보세요.

 **e.g.**
 enum Site {}

**Input**
 let google = Site.google("google@gmail.com", "0000")
 google.signIn()

**Output**
 구글에 로그인하였습니다. (아이디 - google@gmail.com, 비밀번호 - 0000)

#### **정답**

```swift

enum Site {
    case google(String,String)
    case kakao(String,String)
    case naver(String,String)
    
    func signIn() {
        switch self {
        case let .google(id,pw):
            print("구글에 로그인 되었습니다. \(id), 비밀번호 - \(pw)")
        case let .kakao(id,pw):
            print("카카오에 로그인 되었습니다. \(id), 비밀번호 - \(pw)")
        case let .naver(id,pw):
            print("네이버에 로그인 되었습니다. \(id), 비밀번호 - \(pw)")
        }
    }
}
let google = Site.google("google@gmail.com", "0000")
let kakao = Site.kakao("google@gmail.com", "0000")
let naver = Site.naver("google@gmail.com", "0000")
google.signIn()
kakao.signIn()
naver.signIn()
```



### 2.  closure 단축

#### 문제

> 다음의 클로져를 FullSyntax 로부터 Optimized Syntax 로 차근차근 줄여보세요.
>  (최종 답만 적지 말고 하나씩 줄여갈 것)

```swift
func performClosure(param: (String) -> Int) {
  param("Swift")
}
```

#### 문제 풀이

```swift
func performClosure(param: (String) -> Int) {
  param("Swift")
}

performClosure(param: { (str: String) -> Int in // 클로저 표준화
  return str.count
})

performClosure(param: { (str: String) in  // 리턴 값 반환 축약
  return str.count
})

performClosure(param: { str in // 파라미터의 속성 정의 값 축약
  return str.count
})

performClosure(param: {	// 파라미터 제거 -> $0 사용
  return $0.count
})

performClosure(param: { // 'return' 제거
  $0.count
})

performClosure(param: ) { 
  $0.count
}

performClosure() {
  $0.count
}

performClosure { $0.count }
```



### 3.  업케스팅과 다운케스팅

#### 문제 

> 1) 업캐스팅과 다운캐스팅에 대하여 설명하고,
> 2) 업캐스팅과 다운캐스팅을 시도할 때 사용하는 키워드에 대해 각각 설명

#### 정답

```swift
 1)
 업 캐스팅
 - 상속 관계에 있는 자식 클래스가 부모 클래스로 형 변환하는 것
 - 업캐스팅은 항상 성공하며 as 키워드를 사용
   (자기 자신에 대한 타입 캐스팅도 항상 성공하므로 as 키워드 사용)
 
 다운 캐스팅
 - 형제 클래스나 다른 서브 클래스 등 수퍼 클래스에서 파생된 각종 서브 클래스로의 타입 변환 의미
 - 반드시 성공한다는 보장이 없으므로 옵셔널. as? 또는 as! 를 사용
 
 2)
 - as  : 타입 변환이 확실하게 가능한 경우(업캐스팅, 자기 자신 등) 에만 사용 가능. 그 외에는 컴파일 에러
 - as? : 강제 타입 변환 시도. 변환이 성공하면 Optional 값을 가지며, 실패 시에는 nil 반환
 - as! : 강제 타입 변환 시도. 성공 시 언래핑 된 값을 가지며, 실패 시 런타임 에러 발생
```



### 4. TableView 관련 문제

#### 문제

>  TableView에서 셀을 재사용할 때 사용되는 아래의 두 메서드가 각각
>  1) 언제 사용되고 2) 차이점은 무엇인지에 대하여 작성
>    \- dequeueReusableCell(withIdentifier:)
>    \- dequeueReusableCell(withIdentifier:for:)

#### 정답

1.  메서드 사용 시점
   - register메서드를 통해 사용할 셀을 등록했거나 스토리보드에서 셀을 만들었을 때dequeueReusableCell(withIdentifier:for:) 사용,  그 외의 경우는 dequeueReusableCell(withIdentifier:) 사용
2. 차이점
   - dequeueReusableCell(withIdentifier:)메서드
     -  반환 타입이 옵셔널이기에 입력한 ID가 틀리거나 없어도 nil을 반환할 뿐 오류가 발생하지 않음
   - dequeueReusableCell(withIdentifier:for:)메서드
     -  미리 등록한 ID를 찾지 못하면 반드시 런타임 에러가 발생



### 5.  Layout 관련 문제

#### 문제

> safeAreaInsets / safeAreaLayoutGuide의 차이점에 대해 작성

#### 정답

1. safeAreaInsets
   - View와 SafeArea 영역 간의 간격 정보
   - Frame 기반으로 레이아웃을 잡을 때 사용
2. safeAreaLayoutGuide
   - SafeArea 영역의 경계선 부분
   - AutoLayout 기반으로 레이아웃을 잡을 때 사용



### 6. 참조 관련 문제

#### 문제

> Strong, Unowned, Weak에 대해서 설명하시오

1. **Strong**
   - 강한 참조
   - 기본값
   - 인스턴스 참조 시  RC(Reference Count) 1 증가 
2.  **Unowned**
   - 미소유 참조
   - RC 미증가
   - 참조하는 인스턴스 해제 시에도 기존 포이터 주소 유지
3. **Weak**
   - 약한 참조
   - RC 미증가
   - 참조하던 인스턴스 해제 시 nil 값으로 변경



### 7. 스토리보드를 이용하지 않을 때 window를 생성하고 초기 ViewController를 전달하는 코드 작성 

```swift
class ViewController: UIViewController {}
// 1. iOS 13 이상 - SceneDelegate.swift 일 때

class SceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    window = UIWindow(windowScene: windowScene)
    window?.backgroundColor = .systemBackground
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
  }
}

// 2번 iOS 12 이하 - AppDelegate.swift 일 때
class AppDelegate {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .systemBackground
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
    return true
  }
}
```

