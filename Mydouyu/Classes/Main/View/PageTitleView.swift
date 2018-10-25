//
//  PageTitleView.swift
//  Mydouyu
//
//  Created by o g m on 2018/10/25.
//  Copyright © 2018 o g m. All rights reserved.
//

import UIKit
//mark-定义协议，让pageContentView做出响应,写class意思是本协议只对类有效
protocol PageTitleViewDelegate : class {
    func pageaTitleView(titleView : PageTitleView,selectedIndex index :Int)
    
}


//定义滑块的高度
private let kscrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {

    //mark-定义属性
    private var currentIndex: Int = 0
    private var titles:[String]
    weak var delegate : PageTitleViewDelegate?
    
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
            label.textColor = UIColor(kNormalColor.0, kNormalColor.1, kNormalColor.2)
            label.textAlignment = .center
            
            //3.设置frame用于显示

            let lableX : CGFloat = lableW * CGFloat(index)
            
            label.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            //4.将lable 添加到scrollView 中
            scrollView.addSubview(label)
            Lables.append(label)
            
            //5.给label添加监听手势
            label.isUserInteractionEnabled = true //label默认是不能和用户交互的
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
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
        firstLable.textColor = UIColor(kSelectColor.0,kSelectColor.1,kSelectColor.2)
            //2.2设置scrollIview的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y:frame.height - kscrollLineH, width: firstLable.frame.width, height: kscrollLineH)
        
    }
}

//mark-监听label的点击
extension PageTitleView{
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
       //1.获取当前label
        guard let currentLabel = tapGes.view as? UILabel else {return}//如果没有值，直接返回
        //2.获取上次的label
       let oldLabel = Lables[currentIndex]
        //3.切换文字的颜色
        currentLabel.textColor = UIColor(kSelectColor.0,kSelectColor.1,kSelectColor.2)
        oldLabel.textColor = UIColor(kNormalColor.0, kNormalColor.1, kNormalColor.2)
        //3.保存最新label下标值
        currentIndex = currentLabel.tag
        //5.滚动条的位置发生改变
        let scrollLinePositionX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        //发生移动时候动画移动
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLinePositionX
        })
        
        //6.通知代理
        delegate?.pageaTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//mark-对外暴露的方法
extension PageTitleView{
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        //1.取出对应的label
        let sourceLabel  = Lables[sourceIndex]
        let targetLabel = Lables[targetIndex]
        
        //2.处理滑块移动
       let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.处理滑块颜色渐变
          //3.1颜色变换的范围
        let colorDelta = (kSelectColor.0-kNormalColor.0,kSelectColor.1-kNormalColor.1,kSelectColor.2-kNormalColor.2)
            //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(kSelectColor.0 - colorDelta.0 * progress,kSelectColor.1 - colorDelta.1 * progress,kSelectColor.2 - colorDelta.2 * progress)
            //3.3变化targetLabel
        targetLabel.textColor = UIColor(kNormalColor.0 + colorDelta.0 * progress,kNormalColor.1 + colorDelta.1 * progress,kNormalColor.2 + colorDelta.2 * progress)
        
        //4.记录新的index  ,解决滑动一下，再点击，颜色不消失bug
        currentIndex = targetIndex
    }
}

