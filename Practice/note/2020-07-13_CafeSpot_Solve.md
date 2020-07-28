# CafeSpot Practice

## 메인 화면

### 화면 설명

- 성수동에 있는 카페 Json 데이터를 파싱하여 CollectionView로 구현
- 사용자가 하트 버튼을 누를 경우 색상을 변경해줌
- 사용자는 상단의 Search bar 를 통해서 이름으로 검색이 가능

![mainView](../image/200713_cafespot/mainView.gif)

### 주요 코드

- JSON Data 파싱 부분

  - ```swift
    func fetchData() {
        // 로컬 Json 데이터 불러오기
        guard let cafeDateUrl = Bundle.main.url(
          forResource: "CafeList",
          withExtension: "json"
          ) else { return }
        
        if let cafeData = try? Data(contentsOf: cafeDateUrl) {
          // 데이터 분석
          if let jsonObject = try? JSONDecoder().decode([CafeModel].self, from: cafeData) {
            self.cafeData = jsonObject
          }
        }
      }
    ```

  - ```swift
    // json 파싱을 위한 Decodable
    struct CafeModel {
      var title: String
      var description: String
      var isFavorite: Bool
      
      // location Detail Imformation
      var address: String
      var lat: Double
      var lng: Double
      
      enum CodingKeys: String, CodingKey {
        case title
        case description
        case isFavorite
        case location
      }
      
      enum AdditionalLocationKeys: String, CodingKey {
        case address
        case lat
        case lng
      }
    }
    
    extension CafeModel: Decodable {
      init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        title = try keyedContainer.decode(String.self, forKey: .title)
        description = try keyedContainer.decode(String.self, forKey: .description)
        isFavorite = try keyedContainer.decode(Bool.self, forKey: .isFavorite)
        
        let additionalInfo = try keyedContainer.nestedContainer(
          keyedBy: AdditionalLocationKeys.self,
          forKey: .location)
        address = try additionalInfo.decode(String.self, forKey: .address)
        lat = try additionalInfo.decode(Double.self, forKey: .lat)
        lng = try additionalInfo.decode(Double.self, forKey: .lng)
        
      }
    }
    ```

    

- CollectionView Cell 생성 부분

  - ```swift
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if fileredOn {
          // 카페 검색 필더 활성화 시
          return fileteredCafeData.count
        } else {
          // 전체 카페 리스트 전달
          return cafeData.count
        }
      }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.identifier, for: indexPath) as? HomeViewCell else { fatalError() }
        
        if fileredOn {
          // 카페 검색 필더 활성화 시
          cell.cafeData = fileteredCafeData[indexPath.item]
        } else {
          // 전체 카페 리스트 전달
          cell.cafeData = cafeData[indexPath.item]
          // 커스텀 셀에서 액션을 연결하기 위한 코드 ( 재사용 시 색상 유지를 위한 데이터 변경 )
          cell.heartCheckButton.addTarget(self, action: #selector(tabFavoritButton(_:)), for: .touchUpInside)
          cell.heartCheckButton.tag = indexPath.row
        }
    
        return cell
      }
    ```

    

- Search Bar 부분 

  - ```swift
    extension HomeVC: UISearchBarDelegate {
      
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fileteredCafeData = []
        fileredOn = true
        
        for cafe in cafeData where cafe.title.contains(searchText) {
          for selectCafe in fileteredCafeData {
            if selectCafe.title == cafe.title {
              return
            }
          }
          fileteredCafeData.append(cafe)
        }
        collectionView.reloadData()
      }
      
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fileredOn = false
        collectionView.reloadData()
      }
    }
    ```

- 카페 이미지 클릭시 해당 카페의 상세 정보로 이동 처리

  - ```swift
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
      guard let cell = collectionView.cellForItem(at: indexPath) as? HomeViewCell else { return }
    
      let detailCafeVC = DetailCafeVC()
      detailCafeVC.cafeData = cell.cafeData
      navigationController?.pushViewController(detailCafeVC, animated: true)
    
    }
    
    ```



## 카페 상세 뷰

### 화면 설명

- 사용자가 메인 페이지에서 선택한 카페의 상세 정보를 보여줌
- 상단의 스크롤 뷰를 통해 카페와 관련된 사진 10장 보여줌
- 지도상에서의 위치 표시
- 인스타그램 및 네이버 길 찾기를 통해서 외부 APP 호출

![detailCafeView](../image/200713_cafespot/detailCafeView.gif)



### 주요 소스코드

- 메인 화면에서 선택한 카페의 정보를 받아와서 처리하는 부분

  - ```swift
    var cafeData: CafeModel? = nil {
      didSet {
        navigationItem.title = cafeData?.title
    
        guard let cafeData = cafeData else { return }
        cafeName.text = "   \(cafeData.title)"
        cafeDiscription.text  = "     \(cafeData.description)"
    
        // annotation 설정 ( map 위의 위치를 표시해주는 핀 )
        let annotation = MKPointAnnotation()
        annotation.title = cafeData.title
        annotation.coordinate = CLLocationCoordinate2DMake(cafeData.lat, cafeData.lng)
        cafeLocationMap.addAnnotation(annotation)
        
        let camera = MKMapCamera()
        camera.centerCoordinate = CLLocationCoordinate2DMake(cafeData.lat, cafeData.lng)
        camera.centerCoordinateDistance = 200  // 고도
        camera.pitch = 0 // 카메라 각도 (0일 때 수직으로 내려다보는 형태)
        camera.heading = 0   // heading: 카메라 방향 0 ~ 360 (맵을 바라보는 방향)
        cafeLocationMap.setCamera(camera, animated: true)
    
      }
    }
    ```

- 상단의 카페 이미지 뷰 설정

  - 이미지의 갯수에 따라서 유동적으로 스크롤뷰의 크기가 적용되도록 설정

  - ```swift
    private func configureScrollView() {
      let viewWidth = UIScreen.main.bounds.width
      
      // horizion ScrollView Setting
      horizionScrollView.isScrollEnabled = true
      horizionScrollView.isPagingEnabled = true
      horizionScrollView.delegate = self
    
      // 이미지 배열을 통한 이미지 뷰 생성
      for i in 0..<currentCafeImage.count{
    
        let imageView = UIImageView()
        imageView.image = currentCafeImage[i]
        imageView.contentMode = .scaleToFill //scaleAspectFit //  사진의 비율을 맞춤.
    
        let xPosition = viewWidth * CGFloat(i)
        // 각각의 이미지 별로 위치를 지정 해줌
        imageView.frame = CGRect(x: xPosition, y: 0,
                                 width: viewWidth,
                                 height: viewWidth*1.1)
    
        horizionScrollView.contentSize.width = viewWidth * CGFloat(1+i)
        horizionScrollView.addSubview(imageView)
      }
    }
    ```

- 위치 관련 함수

  - 네이버 지도를 통해 현재위치에서 해당 카페까지의 길찾기 기능 지원을 위한 위치정보 업데이트 요청

  - ```swift
    // MARK: - Location Controller
    
    private func configureLocation() {
      // 사용자에게 실제로 권한을 요청 하는 부분 ( 팝업 )
      self.locationManager.requestAlwaysAuthorization()
      self.locationManager.requestWhenInUseAuthorization()
    
      if CLLocationManager.locationServicesEnabled() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters // 위치정보 정확도
        locationManager.startUpdatingLocation()
      }
    }
    
    private func checkAuthorizationStatus() {
      // 사용자가 승인한 권한에 따라 위치 정보 접근
      switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied: break
        case .authorizedWhenInUse:
        fallthrough
        case .authorizedAlways:
        startUpdatingLocation()
        @unknown default: fatalError()
      }
    }
    
    private func startUpdatingLocation() {
      // 사용자가 승인한 권한 확인
      let status = CLLocationManager.authorizationStatus()
      // 권한이 올바른 경우에만 위치 정보 업데이트 시작 가능
      guard status == .authorizedAlways || status == .authorizedWhenInUse,
      CLLocationManager.locationServicesEnabled()
      else { return }
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.distanceFilter = 10.0
      // 위치 정보 업데이트 시작
      locationManager.startUpdatingLocation()
    }
    
    extension DetailCafeVC: CLLocationManagerDelegate {
      
      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
          print("Authorized")
        default:
          print("Unauthorized")
        }
      }
    }
    ```

- URL Sheme을 통해 외부 앱 오픈 요청

  - ```swift
    //URL 생성 및 외부 앱 오픈 요청
    
    @objc func tabLinkButton(_ sender: UIButton) {
        guard let cafeData = cafeData else { return }
      
        // 인스타그램 오픈을 위한 URL을 미리 저장해둠
        var searchString = "instagram://tag?name=\(cafeData.title)"
        var searchAppName:String = "instagram"
        
        if sender == naverButton {
          // 사용자가 네이버 버튼을 누른 경우 searchString 변경
          guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
          searchAppName = "nmap"
          searchString = "nmap://route/walk?slat=\(locValue.latitude)&slng=\(locValue.longitude)&sname=\("내 위치")&dlat=\(cafeData.lat)&dlng=\(cafeData.lng)&dname=\(cafeData.title)&appname=\("com.kr.tootoomaa")"
        }
    
        // URL에 한글이 포함된 경우 인코딩을 통해서 변환해주어야 정상적으로 URL생성 가능
        if let encoded  = searchString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
          let myURL = URL(string: encoded){
          if UIApplication.shared.canOpenURL(myURL) {
            UIApplication.shared.open(myURL, options: [:], completionHandler: nil)
          } else {
            UIApplication.shared.open(URL(string: "itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software&term=\(searchAppName)")!, options: [:], completionHandler: nil)
          }
        }
      }
    ```

    

## 지도 검색 화면

### 구현 화면

- 지도 위에 카페들의 위치를 표시
- 하단의 화면내 카페들의 정보를 표시
- 지도에서 특정 카페의 핀을 터치하는 경우 하단의 해당 카페만 보여지도록

![mapView](../image/200713_cafespot/mapView.gif)



### 주요 소스 코드

- 맵 뷰 관련코드

  - ```swift
    // MARK: - MKMapViewDelegate
    extension MapFindVC: MKMapViewDelegate {
    
      // 화면 이동에 따른 annotation 변경 사항 업데이트
      func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        var tempVisibleAnnotraion: [MyAnnotation] = []
        for myAnnotaion in cafeLocationMap.annotations(in: cafeLocationMap.visibleMapRect) {
          if let annotation = myAnnotaion as? MyAnnotation {
            tempVisibleAnnotraion.append(annotation)
          }
        }
        if visibleAnnotraion.count != tempVisibleAnnotraion.count {
          visibleAnnotraion = tempVisibleAnnotraion
        }
        collectionView.reloadData()
      }
    
      // 첫 시작시 annotation 리스트 생성
      func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        visibleAnnotraion = []
        for myAnnotaion in cafeLocationMap.annotations(in: cafeLocationMap.visibleMapRect) {
          if let annotation = myAnnotaion as? MyAnnotation {
            visibleAnnotraion.append(annotation)
          }
        }
        collectionView.reloadData()
      }
    
      // 특정 Annotation 선택시 해당 카페의 상세 정보 보여줌
      func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let myAnnotation = view.annotation as? MyAnnotation else { return }
        visibleAnnotraion = []
        visibleAnnotraion.append(myAnnotation)
        collectionView.reloadData()
      }
    
    
      func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    
      }
    
      func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
    
        let identifier = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
    
        annotationView.clusteringIdentifier = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
    
        return annotationView
      }
    
    }
    ```

- 하단의 카페 목록 숨기는 코드

  - ```swift
    @objc func tabHideCollectionViewButton() {
      if collectionViewHideOption == false {
        // 표시 -> 숨김
        UIView.animate(withDuration: 0.5) {
          self.collectionView.center.y += 200
          self.hideCollectionViewButton.center.y += 200
        }
      } else {
        // 숨김 -> 표시
        UIView.animate(withDuration: 0.5) {
          self.collectionView.center.y -= 200
          self.hideCollectionViewButton.center.y -= 200
        }
      }
      collectionViewHideOption.toggle()
      loadViewIfNeeded()
    }
    ```

- 하단의 카페 리스트에서 특정 카페를 누를 때 해당 핀으로 이동하는 코드

  - ```swift
    // 카페 정보창 선택시 해당 Annotation의 위치로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
      UIView.animate(withDuration: 0.5) {
        // 카메라 설정
        let camera = MKMapCamera()
        // 현재 맵뷰에 보이는 핀들의 목록에서
        let annotationCoordinate = self.visibleAnnotraion[indexPath.item].coordinate
        self.cameraView.centerCoordinate = CLLocationCoordinate2DMake(annotationCoordinate.latitude,annotationCoordinate.longitude)
        self.cafeLocationMap.setCamera(self.cameraView, animated: true)
    
        self.cafeLocationMap.centerCoordinate = self.visibleAnnotraion[indexPath.item].coordinate
      }
    }
    ```

    