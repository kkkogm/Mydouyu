
//
//  PageContentView.swift
//  Mydouyu
//
//  Created by o g m on 2018/10/25.
//  Copyright © 2018 o g m. All rights reserved.
//

import UIKit

//ID
private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    private var childVcs : [UIViewController]
    private var fatherVc : UIViewController
    
    //lazy加载属性
    private lazy var collectionView : UICollectionView = {
       //1.创建布局layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size // 页面大小，这个view有多大设置多大
        layout.minimumLineSpacing = 0 //行间距 0
        layout.minimumInteritemSpacing = 0 //
        layout.scrollDirection = .horizontal //水平滚动
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //水平滚动条
        collectionView.isPagingEnabled = true //分页显示
        collectionView.bounces = false //超出内容滚动w区域？？？？
        
        //如果想显示内容，必须设置数据源
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()

    //自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],fatherVc:UIViewController) {
        self.childVcs = childVcs
        self.fatherVc = fatherVc
        super.init(frame:frame)
        
        setupUI()
    }
    //自定义构造函数必须要这个
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//mark-设置UI界面
extension PageContentView{
    private func setupUI(){
        //1.将子控制器加到父控制器中
        for childVc in childVcs{
            fatherVc.addChild(childVc)
        }
        //2.添加UICollectionView，用于在cell中存放子控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        //2.添加UICollectionView，用于在cell中存放子控制器的view
 
    }
}

//mark-遵守UICollectionViewDataSource，因为collectionView已经成为程序员，所以必须要遵守协议
extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell，必须先注册cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //2.给cell设置内容
        //移除上一层的view
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
    
}
