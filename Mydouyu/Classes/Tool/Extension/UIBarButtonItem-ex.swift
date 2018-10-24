//
//  UIBarButtonItem-ex.swift
//  Mydouyu
//
//  Created by o g m on 2018/10/24.
//  Copyright © 2018 o g m. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //通过封装类方法
//    class func creatItem(image:String,hightImage:String,size:CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: image), for: .normal)
//        btn.setImage(UIImage(named: hightImage), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
//        return UIBarButtonItem(customView: btn)
//    }
    
    //通过封装便利构造函数
    convenience init(image:String,hightImage:String="",size:CGSize=CGSize(width: 0, height: 0 )){
        let btn = UIButton()
        btn.setImage(UIImage(named: image), for: .normal)
        if hightImage != ""{
            btn.setImage(UIImage(named: hightImage), for: .highlighted)
        }
        if size == CGSize(width: 0, height: 0 ){
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        
        
        self.init(customView: btn)
    }
    
}
