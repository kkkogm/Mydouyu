//封装pagetitleview
    1.自定义view，并且自定义构造函数
    2.添加子控件，》1.UIScrollView 2.设置TitleLable 3.设置顶部的线段
//封装pageContentView    
    1.自定义View并且自定义构造函数
    2.添加子控件》1.UIControllerView 2. 给UIControllerView设置内容

//处理pagetitleview和pagecontentView的逻辑关系
 1.pagetitleview中发生点击事件将pagecontentView与点击事件对应
 
 监听label，添加手势
 pagetitleview事件响应以后，传个调用controller，让此controller通知pagecontentView做出对应的动作
 pagetitleview使用代理会让代码更加清晰
 
 2. pagecontentView滑动，让pagetitleview中对应显示

