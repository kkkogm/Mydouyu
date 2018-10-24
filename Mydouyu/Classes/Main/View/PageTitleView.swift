//
//  PageTitleView.swift
//  Mydouyu
//
//  Created by o g m on 2018/10/25.
//  Copyright © 2018 o g m. All rights reserved.
//

import UIKit

private let kscrollLineH : CGFloat = 2

class PageTitleView: UIView {

    //mark-定义属性
    private var titles:[String]
    
    private lazy var Lables : [UILabel] = [UILabel]()
    //懒加载属性
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        //隐藏垂直方向滚动条
        scrollView.showsHorizontalScrollIndicator = false
        //触摸状态栏，试图自动滚到最顶端
        scrollView.scrollsToTop = false
//        scrollView.isPagingEnabled = false  默认false 不需要分页
        //让状态栏不滚动
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
   //mark-i自定义构造函数
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView{
    private func setupUI(){
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2. 添加title对应的Label
        setupTitleLabels()
        
        //3.添加底线和左右滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setupTitleLabels(){
        
        // 0.   确定lable的一些frame值
        let lableW : CGFloat = frame.width / CGFloat(titles.count)
        let lableH : CGFloat = frame.height - kscrollLineH
        let lableY : CGFloat = 0
        
        for(index,title) in titles.enumerated(){
            //1.创建UILable
            let label = UILabel()
            //2.设置lable的内容
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //3.设置frame用于显示

            let lableX : CGFloat = lableW * CGFloat(index)
            
            label.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            //4.将lable 添加到scrollView 中
            scrollView.addSubview(label)
            Lables.append(label)
        }
    }
    private func setupBottomMenuAndScrollLine(){
        //1.添加底线
        let bottonLine = UIView()
        bottonLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottonLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottonLine)
        //2.添加scrollLine,使用懒加载比较好
          //2.1获取第一个Lable(如果没有值直接返回)
        guard let firstLable = Lables.first else {return}
        firstLable.textColor = UIColor.orange
            //2.2设置scrollIview的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y:frame.height - kscrollLineH, width: firstLable.frame.width, height: kscrollLineH)
        
    }
}
