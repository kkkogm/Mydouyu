
//
//  PageContentView.swift
//  Mydouyu
//
//  Created by o g m on 2018/10/25.
//  Copyright © 2018 o g m. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView:PageContentView,progress: CGFloat,sourceIndex: Int,targetIndex: Int)
}

//ID
private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    private var childVcs : [UIViewController]
    private weak var fatherVc : UIViewController? //添加weak变成若引用，防止强引用循环引用
    private var startOffsetX : CGFloat = 0
    private var isForbidScrollDelegat = false
    weak var delegate : PageContentViewDelegate?
    
    //lazy加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in //弱引用优化
       //1.创建布局layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)! // 页面大小，这个view有多大设置多大
//        layout.itemSize = self?.bounds.size 强引用类型，上面是优化之后，添加[weak self] in变成弱引用
        layout.minimumLineSpacing = 0 //行间距 0
        layout.minimumInteritemSpacing = 0 //
        layout.scrollDirection = .horizontal //水平滚动
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //水平滚动条
        collectionView.isPagingEnabled = true //分页显示
        collectionView.bounces = false //超出内容滚动w区域？？？？
        //创建代理0
        collectionView.delegate = self
        
        //如果想显示内容，必须设置数据源
        collectionView.dataSource = self //前面已经将self转为弱引用，所以不用加 as? UICollectionViewDataSource
        //注册
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()

    //自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],fatherVc:UIViewController?) {
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
            fatherVc?.addChild(childVc)
        }
        //2.添加UICollectionView，用于在cell中存放子控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        //2.添加UICollectionView，用于在cell中存放子控制器的view
 
    }
}

//mark-遵守UICollectionViewDataSource，因为collectionView已经成为代理员，所以必须要遵守协议
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
//mark-遵守UICollectionViewDelegate协议 ,检测滚动事件
extension PageContentView:UICollectionViewDelegate{
    //监听contentview的左滑还是又滑
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegat = false
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0.判断是都是点击事件
        if isForbidScrollDelegat {return}
        
        //1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0 //当前标签角标
        var targetIndex : Int = 0  //滑动下一刻，标签角标，需要contentOffset判断
        //2.判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{
            //左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex  
            }
            
        }else {
            //右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
        }
            //3.将progress、sourceIndex、targetIndex传递给titleView
            print("progress:\(progress)、sourceIndex:\(sourceIndex)、targetIndex:\(targetIndex)")
            delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
    }
}

//mark-对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex: Int) {
        isForbidScrollDelegat = true //记录需要禁止代理方法
        let offsetX = CGFloat(currentIndex ) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}
