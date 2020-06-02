//
//  ViewController.swift
//  imagePickPractice_200602
//
//  Created by 김광수 on 2020/06/02.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    //MARK: - Properties
    private let imagePicker = UIImagePickerController()
    var previewValue = UIImageView()
    
    @IBOutlet weak var leftPreview: UIImageView!
    @IBOutlet weak var rightPreview: UIImageView!
    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    var imageIndex:Int = 0
    var imageArray:[UIImage] = []
    
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            let interaction = UIContextMenuInteraction(delegate: self)
            imageView.addInteraction(interaction)
            imageView.isUserInteractionEnabled = true // 기본적으로 false로 되어있음
        }
    }
    
    @IBOutlet weak var imagePickbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        let interactionRight = UIContextMenuInteraction(delegate: self)
        rightButton.addInteraction(interactionRight)
        
        let interactionLeft = UIContextMenuInteraction(delegate: self)
        leftButton.addInteraction(interactionLeft)
        
        
        leftPreview.backgroundColor = .white
        view.addSubview(leftPreview)
        rightPreview.backgroundColor = .white
        view.addSubview(rightPreview)
        
    }
    
    @IBAction func tabimagePickButtonAction(_ sender: Any) {
        print("== tap ImagePickButton ==")
        imagePicker.sourceType = .savedPhotosAlbum // 차이점 확인하기
        imagePicker.mediaTypes = [kUTTypeImage as String] // 이미지 불러오기
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func tabLeftButton(_ sender: Any) {
        if imageIndex >= 1 {
            imageIndex -= 1
            imageView.image = imageArray[imageIndex]
        }
    }
    
    @IBAction func tabrightButton(_ sender: Any) {
        if imageIndex < imageArray.count-1 {
            imageIndex += 1
            imageView.image = imageArray[imageIndex]
        }
    }
}

extension ViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // handle Image Type
        let originalImage = info[.originalImage] as! UIImage    // 이미지를 가져옴
        imageView.image = originalImage                         // 이미지 셋팅
        imageArray.append(originalImage)                        // 이미지 배열에 추가
        imageIndex += 1                                         // 이미지 배열 인덱스 추가
        
        dismiss(animated: true, completion: nil)                // imagePicker 종료
    }
}

//MARK: - UIContextMenuInteraction
extension ViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        if interaction.location(in: view).x < 150 {
            if imageIndex - 1 >= 0 {
                leftPreview.image = imageArray[imageIndex-1]
                previewValue = leftPreview
                return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: nil)
            }
        } else {
            if imageIndex + 1 < imageArray.count {
                rightPreview.image = imageArray[imageIndex+1]
                previewValue = rightPreview
                return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: nil)
            }
        }
        //위 조건에 해당하지 않을 경우 사용 안함
        return nil
    }
    
    // 내가 원하는 뷰를 타겟 브리뷰로 지정
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        print("== previewForHighlightingMenuWithConfiguration ==")
        
        return UITargetedPreview(view: previewValue)
        //        return UITargetedPreview(view: self.view)
    }
    
    // interaction이 종료되기 전에 호출
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        print("== willEndFor ==")
        UIView.animate(withDuration: 2) {
            self.previewValue.image = nil
        }
    }
}

