# UICollectionView Practice

## Practice 1. Basic Code

### 구현 화면

![200616_CollectionVeiw_BasicCode](../image/200616/200616_CollectionVeiw_BasicCode.gif)

### 주요 소스 코드

- 슬라이더 셋업 부분

  - ```swift
    func setupSliders() {
        // 셀 크기
        let sizeSlider = UISlider()
        sizeSlider.minimumValue = 10
        sizeSlider.maximumValue = 200
        sizeSlider.value = 50
        
        // 셀 간격
        let spacingSlider = UISlider()
        spacingSlider.minimumValue = 0
        spacingSlider.maximumValue = 50
        spacingSlider.value = 10
        spacingSlider.tag = 1
        
        // 셀 외부여백
        let edgeSlider = UISlider()
        edgeSlider.minimumValue = 0
        edgeSlider.maximumValue = 50
        edgeSlider.value = 10
        edgeSlider.tag = 2
        
        let sliders = [sizeSlider, spacingSlider, edgeSlider]
        sliders.forEach {
          // 각각의 slider에 valueChange시 처리할 Action 추가
          $0.addTarget(self, action: #selector(editLayout), for: .valueChanged)
        }
        
        // Slider를 담은 StackView 생성
        let stackView = UIStackView(arrangedSubviews: sliders)
        view.addSubview(stackView)
        
        stackView.axis = .vertical  // 수직으로 정렬
        stackView.alignment = .fill	// 가능한 공간 꽉 채우기
        stackView.spacing = 10			// 스택뷰 내의 객체들 사이 공간 지정
      
      	// 오토 레이아웃 설정
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
          stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
        controllerStackView = stackView
      }
    ```

- 슬라이더 변경 시  action 부분

  - ``` swift
    @objc private func editLayout(_ sender: UISlider) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        if sender.tag == 0 {  // 셀 크기
          let size = CGFloat(sender.value)
          layout.itemSize = CGSize(width: size, height: size)
        } else if sender.tag == 1 {  // 셀 간격
          layout.minimumLineSpacing = CGFloat(sender.value)
          layout.minimumInteritemSpacing = CGFloat(sender.value)
        } else {  // 외부 여백
          let v = CGFloat(sender.value)
          let inset = UIEdgeInsets(top: v, left: v, bottom: v, right: v)
          layout.sectionInset = inset
        }
    }
    ```

- 가로, 세로 변경 버튼

  - ``` swift
    @objc private func changeCollectionViewDirection(_ sender: Any) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let current = layout.scrollDirection
        // 현제값과 반대값으로 변경해줌 ( 세로 -> 가로 , 가로 -> 세로 )
        layout.scrollDirection = current == .horizontal ? .vertical : .horizontal
      }
    ```

- 셀 생성부분

  - ``` swift
    extension BasicCodeViewController: UICollectionViewDataSource {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
      }
    
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // 셀의 배경색을 랜덤하게 설정
        cell.backgroundColor = [.red, .green, .blue, .magenta, .gray, .cyan, .orange].randomElement()
        return cell
      }
    ```

  

## Practice 2. CustomCell View Controller

### 구현 화면

![200616_CollectionView_CustomCell](../image/200616/200616_CollectionView_CustomCell.gif)

### 주요 소스 코드

- CollectionVeiwDataSource

  - ```swift
    extension CustomCellViewController: UICollectionViewDataSource {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if showImage {
          // 원이 아닌 이미지를 보여주는 화면일 경우 cell 생성, CustomCell 사용
          let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
          
          // Configure Cell
          let item = indexPath.item % parkImages.count
          customCell.configure(image: UIImage(named: parkImages[item]),
                               title: parkImages[item])
          
          cell = customCell
        } else {
          // 이미지가 아닌 원를 보여주는 화면일 경우 cell 생성 
          cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCircle", for: indexPath)
          cell.layer.cornerRadius = cell.frame.width / 2
        }
        
        cell.backgroundColor = getColor(at: indexPath) // getColor 함수를 통해서 색을 생성
        return cell
      }
      
      func getColor(at indexPath: IndexPath) -> UIColor {
        let max = itemCount
        let currentIndex = CGFloat(indexPath.item)
        let factor = 0.1 + (currentIndex / CGFloat(max)) * 0.8
        
        if showImage {     // 색상(hue), 채도(saturation), 명도(brightness)
          return .init(hue: factor, saturation: 1, brightness: 1, alpha: 1)
        } else {
          return .init(hue: factor, saturation: factor, brightness: 1, alpha: 1)
        }
    
      }
    }
    ```

  - UICollectionViewDelegateFlowLayout

    - ```swift
      extension CustomCellViewController: UICollectionViewDelegateFlowLayout {
        // willDisplay 컬렉션뷰 내의 item들이 표현되기 전에  animation을 위한 선처리
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          cell.alpha = 0															// 안보이도록 설정
          cell.transform = .init(scaleX: 0.3, y: 0.3) // 크기를 30%정도로 줄임
          
          UIView.animate(withDuration: 0.3) { // 에니메이션 실행
            cell.alpha = 1									// 에니메이션이 실행되면서 원래 크기로 변경
            cell.transform = .identity	// 원래 크기로 조절
          }
        }
        
        func collectionView(
          _ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
          let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
          
          // 특정 순서의 원을 2배로 만들기위한 함수
          if indexPath.item % 5 == 2 {
            // 3번재 원은 크기를 2배로 지정, 이미지일 경우 3번째 이미지 2배 크기
            return flowLayout.itemSize.applying(CGAffineTransform(scaleX: 2, y: 2))
          } else {
            return flowLayout.itemSize
          }
        }
      }
      ```



## Practice 3. Section ViewController

### 구현 화면

![200616_CollectionView_Section](../image/200616/200616_CollectionView_Section.gif)

### 주요 소스 코드

- Layout 설정 상세 내용

  - ```swift
    // collectionVeiw 인스턴스 생성
    lazy var collectionView = UICollectionView(
      frame: view.frame,
      collectionViewLayout: layout
    )
    
    // leyout 설정
    let layout: UICollectionViewFlowLayout = {
      let layout = UICollectionViewFlowLayout()
      layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
      layout.minimumLineSpacing = 15
      layout.minimumInteritemSpacing = 15
      layout.itemSize = .init(width: 150, height: 150)
    
      // width 값은 가로 스크롤 될 경우 적용됨
      layout.headerReferenceSize = CGSize(width: 60, height: 60)
      layout.footerReferenceSize = CGSize(width: 50, height: 50)
    
      layout.sectionHeadersPinToVisibleBounds = true // 스크롤시 헤더 고정
      layout.sectionFootersPinToVisibleBounds = true // 스크롤시 푸터 고정
      return layout
    }()
    ```

- Re-use Cel

  - ```swift
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //각 section에 알맞는 item 숫자 리턴
      let parks = parkList.filter{$0.location.rawValue == states[section] }
      return parks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCell.identifier, for: indexPath) as! SectionCell
    
      let parks = parkList.filter{$0.location.rawValue == states[indexPath.section] }
      let parkName = parks[indexPath.item].name
      cell.configure(image: UIImage(named: parkName), title: parkName)
      return cell
    }
    ```

- Re-use Supplement (headerview, footerView)

  - ```swift
    // section 갯수 구하기
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return states.count
    }
    
    // SupplementaryElement 재쟁성 함수
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      // collectionViewController dptj 
    
      if kind == UICollectionView.elementKindSectionHeader {
        // header 생성 부분
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
    
        let state = states[indexPath.section] // 각 섹션(나라)의 이름
    
        header.configure(image: UIImage(named: state), title: state)
    
        return header
      } else {
        // footer 생성 부분
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionFooterView.identifier, for: indexPath) as! SectionFooterView
    
        let count = parkList
        .filter({ $0.location.rawValue == states[indexPath.section]})
        .count
        let title = "총 \(count) 개 이미지"
        footer.configure(title: title)
    
        return footer
      }
    }
    ```





## Practice 4. Reordering ViewC ontroller

### 구현 화면

![200616_CollectionView_ReorderViewController](../image/200616/200616_CollectionView_ReorderViewController.gif)

### 주요 소스 코드

- CollectionView DataSource

  - ```swift
    extension ReorderingViewController: UICollectionViewDataSource {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkImages.count
      }
    
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: CustomCell.identifier, for: indexPath
          ) as! CustomCell
        
        let item = indexPath.item
        cell.configure(image: UIImage(named: parkImages[item]), title: parkImages[item])
        cell.backgroundColor = .black
        return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath else { print("Erro"); return }
        
        let destination = destinationIndexPath.item
        let source = sourceIndexPath.item
        
        print("source \(source), dest :\(destination)")
        
        // 기존 경로 삭제 후 추가
        let elemnet = parkImages.remove(at: source)
        parkImages.insert(elemnet, at: destination)
      }
    }	
    ```

  - gesture 추가

    - ```swift
      // MARK: Setup Gesture
      func setupLongPressGestureRecognizer() {
      	// guesture 생성
        let gesture = UILongPressGestureRecognizer(
          target: self,
          action: #selector(reorderCollectionViewItem(_:))
        ) // action 연결
      
        collectionView.addGestureRecognizer(gesture) // gesture 추가
      }
      ```

  - gesture Action  부분

    - ```swift
      @objc private func reorderCollectionViewItem(_ sender: UILongPressGestureRecognizer) {
          let location = sender.location(in: collectionView)
        // gesture의 상태를 통해 이동시작, 이동중, 이동종료 확인
          switch sender.state {
          case .began:
            guard let indexPath = collectionView.indexPathForItem(at: location) else {break}
            collectionView.beginInteractiveMovementForItem(at: indexPath)
          case .changed:
            collectionView.updateInteractiveMovementTargetPosition(location)
          case .ended:
            collectionView.endInteractiveMovement()
          case .cancelled:
            collectionView.cancelInteractiveMovement()
          default: break
          }
        }
      ```

  - Layout 설정

    - ```swift
      func setupFlowLayout() {
        let itemsInLine: CGFloat = 5
        let spacing: CGFloat = 10.0
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let contentSize = collectionView.bounds.width
        let itemSize = (contentSize/itemsInLine).rounded(.down)
      
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = insets
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
      }
      ```

      

### 소스코드 :point_right: [링크](../SourceCode/"200616_CollectionViewExample (starter"))









