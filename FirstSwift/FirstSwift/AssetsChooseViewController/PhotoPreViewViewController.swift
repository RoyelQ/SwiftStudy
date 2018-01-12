//
//  PhotoPreViewViewController.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/11.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

class PhotoPreViewViewController: PhotoBaseViewController, UIScrollViewDelegate {

    var photoImageArr : NSArray?
    var currentIndex : Int?
    var mScrollView : UIScrollView?
    var photoChooseView : PhotoChooseView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "预览"
        
        self.addBackButton {
            self.backAction()
        }

        self.setUpScrollView()
        self.setOtherView()
    }
 
    func setOtherView() -> Void {
        self.photoChooseView = PhotoChooseView.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50))
        self.photoChooseView?.setUpSelectedImageArr(imageArr: self.photoImageArr!)
        self.photoChooseView?.appearImage = true
        self.view.addSubview(self.photoChooseView!)
    }
    
    func setUpScrollView() -> Void {
        
        self.mScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50))
        self.mScrollView?.delegate = self
        self.view.addSubview(self.mScrollView!)
        
        var index = CGFloat(0)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height - CGFloat(Navi_Height) - 50
        
        for image in self.photoImageArr! {
            let imageView = UIImageView.init(image: image as? UIImage)
            imageView.frame = CGRect.init(x: index * width, y: 0, width: width, height: height)
            self.mScrollView?.addSubview(imageView)
            index += 1
            
//            // 双击缩放
//            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleClick(gestureRecognizer:)))
//            doubleTap.numberOfTapsRequired = 2
//            imageView.isUserInteractionEnabled = true
//            imageView.addGestureRecognizer(doubleTap)
        }
        self.mScrollView?.isPagingEnabled = true
        self.mScrollView?.contentSize = CGSize.init(width: CGFloat((self.photoImageArr?.count)!) * width, height: height)
        self.mScrollView?.contentOffset = CGPoint.init(x: CGFloat(self.currentIndex!) * width, y: 0)
//
//        // 两个手指拿捏缩放
//        self.mScrollView?.minimumZoomScale = 0.3
//        self.mScrollView?.maximumZoomScale = 2.0
    }
    
    
//    
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    
//    }
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        
//    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        
//    }
//    
//    
//    
//    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        // 设置被缩放的对应视图
//        for imageview in scrollView.subviews {
//            
//            if imageview is UIImageView {
//                
//                return imageview
//            }
//        }
//        return nil
//    }
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//     
//        
//    }
//    
//    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
//        // 居中显示
//        let imageview = scrollView.subviews.first as! UIImageView
//        self.centerShow(scrollview: scrollView, imageview: imageview)
//    }
//    
//    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//
//        if scrollView.minimumZoomScale >= scale
//        {
//            scrollView.setZoomScale(0.3, animated: true)
//        }
//        if scrollView.maximumZoomScale <= scale
//        {
//            scrollView.setZoomScale(2.0, animated: true)
//        }
//    }
//    
//    // MARK: - 双击缩放
//    var isScaleBig : Bool = false
//    @objc func doubleClick(gestureRecognizer:UITapGestureRecognizer)
//    {
//        // 放大缩小
//        let scale = self.mScrollView?.zoomScale
//        if isScaleBig
//        {
//            self.mScrollView?.setZoomScale((scale! / 0.3), animated: true)
//            isScaleBig = false
//        }
//        else
//        {
//            self.mScrollView?.setZoomScale((scale! * 0.3), animated: true)
//            isScaleBig = true
//        }
//    }
//    
//   @objc func centerShow(scrollview:UIScrollView, imageview:UIImageView)
//    {
//        // 居中显示
//        let offsetX = (scrollview.bounds.size.width > scrollview.contentSize.width) ? (scrollview.bounds.size.width - scrollview.contentSize.width) * 0.5 : 0.0;
//        let offsetY = (scrollview.bounds.size.height > scrollview.contentSize.height) ?
//            (scrollview.bounds.size.height - scrollview.contentSize.height) * 0.5 : 0.0;
//        imageview.center = CGPoint.init(x : scrollview.contentSize.width * 0.5 + offsetX, y : scrollview.contentSize.height * 0.5 + offsetY)
//    }
//    
}
