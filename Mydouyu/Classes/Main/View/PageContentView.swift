
//
//  PageContentView.swift
//  Mydouyu
//
//  Created by o g m on 2018/10/25.
//  Copyright © 2018 o g m. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    
    private var childVcs : [UIViewController]
    private var fatherVc : UIViewController

    //自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],fatherVc:UIViewController) {
        self.childVcs = childVcs
        self.fatherVc = fatherVc
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView{
    private func setupUI(){
        //1.将子控制器加到父控制器中
        for childVc in childVcs{
            fatherVc.addChild(childVc)
        }
        //2.添加UICollectionView，用于在cell中存放子控制器的view
        //2.添加UICollectionView，用于在cell中存放子控制器的view
        
        
        
        
    }
}
