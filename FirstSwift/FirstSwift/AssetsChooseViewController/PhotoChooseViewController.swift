//
//  PhotoChooseViewController.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/10.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit
import Photos

class PhotoChooseViewController: PhotoBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var photoCollection : PHAssetCollection?
    var mCollectionView : UICollectionView?
    var photoChooseView : PhotoChooseView?
    var maxChooseCount : Int?
    
    var photoImageArr : NSMutableArray?
    var selectedImageArr : NSMutableArray?
    var selectedIndexArr : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "选择照片"
        self.addBackButton {
            self.backAction()
        }

        if self.maxChooseCount! > 10 {
            self.maxChooseCount = 10
        }
        self.photoImageArr = NSMutableArray.init()
        self.selectedIndexArr = NSMutableArray.init()
        self.selectedImageArr = NSMutableArray.init()
        self.setUpCollectionView()
        self.setOtherView()
    }
    
    func setOtherView() -> Void {
        self.photoChooseView = PhotoChooseView.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50))
        self.photoChooseView?.setUpSelectedImageArr(imageArr: self.selectedImageArr!)
        self.view.addSubview(self.photoChooseView!)
    }
    
    func setUpCollectionView() -> Void {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        self.mCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50.0), collectionViewLayout:  flowLayout)
        self.mCollectionView?.backgroundColor = UIColor.clear
        self.mCollectionView?.showsHorizontalScrollIndicator = false
        self.mCollectionView?.showsVerticalScrollIndicator = false
        self.mCollectionView?.delegate = self
        self.mCollectionView?.dataSource = self
        self.view.addSubview(self.mCollectionView!)
        
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.size.width
        
        return CGSize.init(width: width/4.0, height: width/4.0)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let assets = PHAsset.fetchAssets(in: self.photoCollection!, options: nil)

        return assets.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = PhotoChooseCollectionViewCell.cellWithCollectionView(collectionView: self.mCollectionView!, indexPath: indexPath)
        let assets = PHAsset.fetchAssets(in: self.photoCollection!, options: nil)
        
        PHImageManager.default().requestImage(for: assets[indexPath.item], targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil, resultHandler: { (result: UIImage?, info: [AnyHashable : Any]?) in

            cell.photoImageView?.image = result
            self.photoImageArr?.add(result as Any)
        })
    
        cell.block = {image, selected, button in
            if selected {
                if self.selectedImageArr?.count == self.maxChooseCount {
                    print("超过最大选择值")
                    button.isSelected = !button.isSelected
                    return
                }
                self.selectedImageArr?.add(image as Any)
                self.photoChooseView?.setUpSelectedImageArr(imageArr: self.selectedImageArr!)
                self.selectedIndexArr?.add(indexPath.item)
            }else {
                
                if (self.selectedImageArr?.contains(image as Any))! {
                    
                    self.selectedImageArr?.remove(image as Any)
                    self.photoChooseView?.setUpSelectedImageArr(imageArr: self.selectedImageArr!)
                    self.selectedIndexArr?.remove(indexPath.item)
                }
            }
            self.refreshCollectionCellData()
        }
        return cell
    }
    
    func refreshCollectionCellData() -> Void {
        //单元格序号
        for index in self.selectedIndexArr! {

            let cell = self.mCollectionView?.cellForItem(at: IndexPath.init(row: index as! Int, section: 0)) as! PhotoChooseCollectionViewCell
            
            let count = (self.selectedImageArr?.index(of: cell.photoImageView?.image as Any))! + 1
            
            cell.selectedButton?.setTitle(String.init(format: "%d", count), for: UIControlState.selected)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let previewVC = PhotoPreViewViewController()
        previewVC.currentIndex = indexPath.item
        previewVC.photoImageArr = self.photoImageArr?.copy() as? NSArray
        self.navigationController?.pushViewController(previewVC, animated: false)
    }
}

