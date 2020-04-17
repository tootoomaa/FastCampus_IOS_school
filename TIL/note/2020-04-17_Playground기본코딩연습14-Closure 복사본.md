# playgrond 를 통한 기본 문법 연습 14 - Closure

## Closure

- 특징
  
  - 코드에서 사용하거나 전달할 수 있는 독릭적인 기능을 가진 블럭
  - 함수도 클로저의 일종
  
- 종류

  - 글로벌 함수 ( Global Function)
  
  - ```swift
    
    ```


- Associated Value

  
  - 연관된 값을 받기 위해서 (값형태) 로 붙임
  
  - ```swift
    
    ```
  
- Raw Value

  
  - Strings, Characters, or any of the Integer or Floating-point number types
  
  - raw value 는 해당 Enumeration 내에서 반드시 고유한 값이어야 함.
  
  - ```swift
    
    ```
  
- **Raw Values **


  - case에 매핑되는 raw값을 자동으로, 순차적으로  넣어주는 기능

  - ```swift
    
    ```
    
  - rawValue를 이용한 초기화 

  - ```swift
    
    ```
    
-  **enum 중첩 사용** ( 참고 )

  - ```swift
    
    ```


-  **enum 변경 (Mutating)**


  -  enum 타입 내부 함수에서 자기 자신의 값을 변경해야 할 경우 mutating 키워드 필요
  
  - ```swift
    
    ```


