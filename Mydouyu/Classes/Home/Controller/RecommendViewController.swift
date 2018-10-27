//
//  RecommendViewController.swift
//  Mydouyu
//
//  Created by xmm on 2018/10/26.
//  Copyright © 2018 o g m. All rights reserved.
//
/*
 1.系统主函数-》加载UI界面，UI界面用extensiony拓展来做
 2.在拓展中使用懒加载属性，创建UICollectionView，
 3.UICollectionView 设置fram和布局，用到布局，所以先创建布局UICollectionViewFlowLayout()
 4.设置布局的为流水布局，设置s一些属性模块大小，上下间距，左右间距，模块大小先写死，后面处理
 5.collectionView设置好以后，里面是没有东西的，如果想有东西设置控制器为数据源dataSource
 6.让本类遵守协议（继承）UICollectionViewDataSource，复写实现其中的方法
 7.numberOfSections 设置多少组
 8.numberOfItemsInSection 每组有多少数据
 9.cellForItemAt indexPath 为数据添加cell，用于存东西 其中使用dequeueReusableCell的方法必须注册cell
 10 collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
 11.cell弄好以后，都是连在一起看不出来，要设置组头
 12.在组头设置view，需要注册方法,为
 collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
 13.这个注册方法也需要一个标识,
 14，小细节注意。布局的高度可能不是自动适应，导致有些组大小没有显示全
 15.设置contentFram 高度加上tabar的高度
 设置collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
 */


import UIKit

private let kItemMargin : CGFloat = 10 //外边距
private let kItemW : CGFloat = (kScreenW-3*kItemMargin)/2
private let kItemH : CGFloat = kScreenW * 3/4
private let kHeaderViewH : CGFloat = 50 //组头高度
//ID
private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    //mark-懒加载属性
    private lazy var collectionView: UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH) //模块大小
        layout.minimumLineSpacing = 0 //上下行间距
        layout.minimumInteritemSpacing = kItemMargin //左右块的间隔
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)//组头
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)//设置组的内边距
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self //让控制器成为他的数据源
         collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //注册（协议用）
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        //注册（组头用）
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        //xib header
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
    
        
        return collectionView
    }()
    //系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui界面
        setupUI()
//        self.view.backgroundColor = UIColor.purple
        
       
        
    }
}
//mark-设置UI界面
extension RecommendViewController{
    private func setupUI(){
        //1.将UICollectionView添加到view中,使用lazy 加载方式初始化
        view.addSubview(collectionView)
    }
}
//mark-遵循数据源协议
extension RecommendViewController:UICollectionViewDataSource{
    
    func numberOfSections (in collectionView: UICollectionView) -> Int {
        return 12 //返回12组 可以理解为定义12个板块
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //每组有多少数据
        if section == 0{//第一组，返回数据8
            return 8
        }
        return 4  //其他组返回数据4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell dequeueReusableCell的方法必须注册cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    //与组头有关的函数
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
//        headerView.backgroundColor = .green
        return headerView
    }
    
    
}

