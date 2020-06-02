# ImagePicker 

- 사용자의 사진(사진 라이브러리)에서 사진을 선택하여 가져오기 위한 사용 방법



## 1. pickImage

- 

```swift
@IBOutlet private weak var imageView: UIImageView!

// imagePicker를 적용하기 위한 방법 1
private let imagePicker = UIImagePickerController()

// imagePicker를 적용하기 위한 방법 2

//    private lazy var imagePicker: UIImagePickerController = {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self // lazy가 없으면 self를 못넣음
//        return imagePicker
//    }()

override func viewDidLoad() {
  super.viewDidLoad()

  imagePicker.delegate = self // delegate 적용
}
```

- UIImagePickerControllerDelegate 정의 하기 위해서는 2가지 Delegate를 적용해야 함
  1. UIImagePickerControllerDelegate
  2. UINavigationControllerDelegate

![200602_ImagePickerDelegate1](../image/200602/200602_ImagePickerDelegate1.png)

![200602_ImagePickerDelegate22](../image/200602/200602_ImagePickerDelegate22.png)

- 

```swift
@IBAction private func pickImage(_ sender: Any) {
  print("\n---------- [ pickImage ] ----------\n")
  imagePicker.sourceType = .savedPhotosAlbum // 차이점 확인하기

  /*
  photoLibray - 앨범을 선택하는 화면을 표시 후, 선택한 앨범에서 사진 선택
  camera - 새로운 사진 촬영
  savedPhotosAlbum - 최근에 찍은 사진들을 나열
  */
	//	imagePicker 띄어주기
  present(imagePicker, animated: true, completion: nil)
}
```



- ImagePicker 딜리게이트 적용

```swift
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    //        print("===UIImagePickerController==")
    //
    //        /*
    //            cancel 메서드에서 할 작업이 없으면 생략
    //         */
    ////        picker.presentingViewController?.dismiss(animated: true, completion: nil) // 정확한 방식
    ////        dismiss(animated: true, completion: nil)                                  // 간단한 방식
    //    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        print("-- didFinishPickingMediaWithInfo --")
        
        print(info)
        let originalImage = info[.originalImage] as! UIImage // 이미지를 가져옴
        imageView.image = originalImage
        
        dismiss(animated: true, completion: nil)
    }
}
```

## 2. Camera

- Button Action

```swift
@IBAction private func takePicture(_ sender: Any) {
  print("\n---------- [ takePicture ] ----------\n")

  imagePicker.sourceType = .camera
  present(imagePicker, animated: true, completion: nil)
}
```

- Error 발생

![200602_AccessFailToCamera](/Users/kimkwangsoo/Document/dev/FastCampus_IOS_school/TIL/image/200602/200602_AccessFailToCamera.png)

- Button Action 수정

```swift
@IBAction private func takePicture(_ sender: Any) {
  print("\n---------- [ takePicture ] ----------\n")
	guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
  // Camera가 사용 가능한지 확인하는 절차 필요
  imagePicker.sourceType = .camera
  present(imagePicker, animated: true, completion: nil)
}
```

- 

![200602_AddPrivacyDescriptionWithplist](/Users/kimkwangsoo/Document/dev/FastCampus_IOS_school/TIL/image/200602/200602_AddPrivacyDescriptionWithplist.png)





### info data

```s
== didFinishPickingMediaWithInfo
[__C.UIImagePickerControllerInfoKey
 (_rawValue: UIImagePickerControllerImageURL): file:///private/var/mobile/Containers/Data/Application/FC3C219C-0662-4985-821D-8BA0235080A1/tmp/857C5435-C1D8-4CF3-B73C-3D14AF54FC20.jpeg, 
 
 __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerReferenceURL): assets-library://asset/asset.JPG?id=8153A2BF-D483-4BEF-86A9-A943A34BF84D&ext=JPG, 
 
 
 __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerMediaType): public.image, 
 
 
 __C.UIImagePickerControllerInfoKey(_rawValue: UIImagePickerControllerOriginalImage): <UIImage:0x281d329a0 anonymous {3024, 4032}>]
```

