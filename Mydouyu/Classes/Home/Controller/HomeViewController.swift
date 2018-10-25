//
//  HomeViewController.swift
//  Mydouyu 123
//
//  Created by o g m on 2018/10/24.
//  Copyright © 2018 o g m. All rights reserved.
//

import UIKit


private let KtitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    //懒加载属性pageTitleView
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: KtitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = .black
        titleView.delegate = self
        return titleView
    }()
    
    //懒加载pagecontentview
    private lazy var pageContentView : PageContentView = {[weak self] in
        //1.确定内容的fram
        let contentH = kScreenH - (kStatusBarH + kNavigationBarH + KtitleViewH)
        let contentFram = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + KtitleViewH, width: kScreenW, height: contentH)
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
//            vc.view.backgroundColor = UIColor(hexString: "#ffffff")
            vc.view.backgroundColor = UIColor(CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
       
        let contentView = PageContentView(frame: contentFram, childVcs: childVcs, fatherVc: self)
        return contentView
    }()
    
    //系统调用函数
    override func viewDidLoad() {
        //设置UI界面
        setupUI()
    }

}
//mark-设置UI界面
extension HomeViewController{
    private func setupUI(){
        //设置头部导航栏的左边部分，因为希望按下去有刷新的效果，所以自定义一个UIBarButtonItem
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "首页", style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        
        
        //1.自定义设置导航栏
        setupNavigationBar()
        
        //2.添加TitleView
        view.addSubview(pageTitleView)
        //3.添加contentview
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    private func setupNavigationBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.setImage(UIImage(named: "logo"), for: .highlighted)
        //自定义的UIButton没有大小，让他根据图片大小自动有大小
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        //设置右边
        let size = CGSize(width: 40, height: 40)
//        let historyBtn = UIButton()
//        historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
//        historyBtn.setImage(UIImage(named: "Image_my_history_click"), for: .highlighted)
////        historyBtn.sizeToFit()图片间距不够自定义
//        historyBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        let historyitem =  UIBarButtonItem(customView: historyBtn)
        let  historyitem = UIBarButtonItem(image: "image_my_history", hightImage: "Image_my_history_click", size: size)
        
        let searchitem =  UIBarButtonItem(image: "btn_search", hightImage: "btn_search_clicked", size: size)
        let qrcodeitem = UIBarButtonItem(image: "Image_scan", hightImage: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyitem,searchitem,qrcodeitem]
        
    }
    
   
}

//mark-遵守PageTitleViewDelegate协议
extension HomeViewController:PageTitleViewDelegate{
    func pageaTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

