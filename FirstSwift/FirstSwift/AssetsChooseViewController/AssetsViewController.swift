//
//  AssetsViewController.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/10.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit
import Photos

class AssetsViewController: PhotoBaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    var mTableView : UITableView?
    var dataSource : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "相册"
        self.addBackButton {
            self.backAction()
        }
        self.checkAlbumAuthority()
        self.setUpTableView()
    }
    
    //MARK: - 相册数据
    func checkAlbumAuthority() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {

            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) in
                if status == PHAuthorizationStatus.authorized {
                  
                    self.getAlbumsArray()
                    DispatchQueue.main.sync {
                        self.mTableView?.reloadData()
                    }
                }
            })
        } else {
            self.getAlbumsArray()
            self.mTableView?.reloadData()
        }
    }
    
    func getAlbumsArray() {

        self.dataSource = NSMutableArray.init()
        let smartAlbum = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil).lastObject!
        self.dataSource?.add(smartAlbum)
        
        // 剩余相册
        let restAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        restAlbums.enumerateObjects({ (album: PHAssetCollection, index: Int, ptr: UnsafeMutablePointer<ObjCBool>) in
            self.dataSource?.add(album)
        })
    }
    
    // MARK: - mTableView初始化
    func setUpTableView() -> Void {
        self.mTableView = UITableView.init(frame: self.view.bounds);
        self.mTableView?.delegate = self
        self.mTableView?.dataSource = self
        self.mTableView?.backgroundColor = UIColor.clear
        self.view.addSubview(self.mTableView!)
        self.mTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.mTableView?.showsVerticalScrollIndicator = false
        self.mTableView?.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            self.mTableView?.estimatedRowHeight = 0.0
            self.mTableView?.estimatedSectionFooterHeight = 0.0
            self.mTableView?.estimatedSectionHeaderHeight = 0.0
        }
    }
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource == nil ? 0 : (self.dataSource?.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = AssetsTableViewCell.cellWithTableView(tableView: self.mTableView!, indexPath: indexPath)
        
        let assets = PHAsset.fetchAssets(in: self.dataSource![indexPath.row] as! PHAssetCollection, options: nil)
        if assets.count > 0 {
            PHImageManager.default().requestImage(for: assets[0], targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil, resultHandler: { (result: UIImage?, info: [AnyHashable : Any]?) in
                cell.assetsImageView?.image = result
            })
        }
        cell.asstesTitleLabel?.text = (self.dataSource![indexPath.row] as! PHAssetCollection).localizedTitle
        cell.assetsCountLabel?.text = String(assets.count)
        cell.setNeedsDisplay()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let photoVC = PhotoChooseViewController()
        photoVC.photoCollection = self.dataSource?[indexPath.row] as? PHAssetCollection
        photoVC.maxChooseCount = 100
        self.navigationController?.pushViewController(photoVC, animated: false)
    }
}

