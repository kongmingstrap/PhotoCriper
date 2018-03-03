//
//  PhotoCripViewController.swift
//  PhotoCriper
//
//  Created by tanaka.takaaki on 2017/03/07.
//  Copyright © 2017年 tanaka.takaaki. All rights reserved.
//

import UIKit

class MaskView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
}

class PhotoCripViewController: UIViewController {

    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var maskView: MaskView!
    
    var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maskView.alpha = 0.5
        //maskView.isUserInteractionEnabled = false
        
        let path = UIBezierPath(rect: CGRect(x: view.center.x - 100.0, y: view.center.y - 100.0, width: 200.0, height: 200.0))
        
        let maskLayer = CAShapeLayer()
        path.append(UIBezierPath(rect: maskView.bounds))
        maskLayer.fillRule = kCAFillRuleEvenOdd
        maskLayer.path = path.cgPath
        maskView.layer.mask = maskLayer
        
        maskView.backgroundColor = UIColor.gray
        //maskView.isHidden = true

        // Do any additional setup after loading the view.
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1.0
        
        photoImageView = UIImageView(image: UIImage(named: "Background")!)
        scrollView.addSubview(photoImageView)
        //photoImageView.frame = view.bounds
        
    //    imageView = UIImageView(image: UIImage(named: "test.png"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSelectPhotoButton(_ sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        //imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func didTapDismissButton(_ sender: AnyObject) {
        print(photoImageView.frame)
        print(scrollView.zoomScale)
        print(scrollView)
    }
}

// MARK: - Private
fileprivate extension PhotoCripViewController {
    fileprivate func updateImage(size: CGSize) {
        //if let size = imageView.image?.size {
            // imageViewのサイズがscrollView内に収まるように調整
            let wrate = scrollView.frame.width / size.width
            let hrate = scrollView.frame.height / size.height
            let rate = min(wrate, hrate, 1)
        
        photoImageView.frame.size = CGSize(width: size.width * rate, height: size.height * rate)
            
            // contentSizeを画像サイズに設定
            scrollView.contentSize = photoImageView.frame.size
            // 初期表示のためcontentInsetを更新
            updateScrollInset()
        //}
    }
    
    fileprivate func updateScrollInset() {
        scrollView.contentInset = UIEdgeInsetsMake(
            max((scrollView.frame.height - photoImageView.frame.height) / 2, 0),
            max((scrollView.frame.width - photoImageView.frame.width) / 2, 0),
            0,
            0
        )
    }
}

extension PhotoCripViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}

extension PhotoCripViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            //let data = try! Data(contentsOf: URL(string: url)!)
                
            photoImageView.image = image
            updateImage(size: image.size)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoCripViewController: UINavigationControllerDelegate {
    
}
