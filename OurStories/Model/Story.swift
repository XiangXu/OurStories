//
//  Story.swift
//  OurStories
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//
import Foundation
import MapKit

struct Story
{
    let location: String
    let storyContent: String
    let imageName: String
    let coordinate: CLLocationCoordinate2D
    
    init(location: String, storyContent: String, imageName: String, coordinate: CLLocationCoordinate2D)
    {
        self.location = location
        self.storyContent = storyContent
        self.imageName = imageName
        self.coordinate = coordinate
    }
    
    static func storyGenerate() ->[Story]
    {
        return [
            Story(location: "爱尔兰-梅努斯",
                  storyContent: "2012年7月 我们第一次相遇在梅努斯这个小镇 还记得当时我们都因为签证原因来晚了 被分配在同一个公寓 我比你早到一天 我一直觉得这就是命运的安排让我们相遇 我们的故事也就在这里开始 我想也是从那天开始 爱上了这个小镇...",
                  imageName: "1.png",
                  coordinate: CLLocationCoordinate2D(latitude: 53.381210, longitude: -6.592220)),
            
           
            Story(location: "爱尔兰-都柏林",
                  storyContent: "2012年8月 记得第一次来这里是你带着我 去之前你信誓旦旦的说你已经很熟悉了 可以带我到处逛逛 到了以后却“意外”的迷路了 记得我们吃了中餐 第一次让你试了鱼香肉丝 也看了地标的大柱子 很充实开心的一天... ",
                  imageName: "2.png",
                  coordinate: CLLocationCoordinate2D(latitude: 53.349804, longitude: -6.260310)),

            Story(location: "中国-武汉",
                  storyContent: "2013年6月19号 22岁 你为了给我惊喜飞过来给我过生日 记得你在街上偷偷的去买蛋糕 我找不到你的慌张 偷偷告诉你 当时许的愿 现在已经实现了...",
                  imageName: "3.png",
                  coordinate: CLLocationCoordinate2D(latitude: 30.592850, longitude: 114.305542)),

            Story(location: "中国-厦门",
                  storyContent: "2013年8月 你提前的生日 这是我第二次到厦门 记得你倔强的一定要带我去鼓浪屿看看 从没有想过会和这座城市有这么紧密的联系 我想这就是缘分吧...",
                  imageName: "4.png",
                  coordinate: CLLocationCoordinate2D(latitude: 24.479834, longitude: 118.089424)),
            
            Story(location: "中国-上海",
                  storyContent: "2013年9月 我们结束了第一次回国的暑假 从上海飞回爱尔兰 那天上海小雨 我们从酒店散步到了外滩 上海的夜景真的是很美...",
                  imageName: "5.png",
                  coordinate: CLLocationCoordinate2D(latitude: 31.230391, longitude: 121.473701)),
            
//            Story(location: "爱尔兰-韦克斯福德",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 52.339230, longitude: -6.460040)),
//
//            Story(location: "爱尔兰-沃特福德",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "2.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 52.259319, longitude: -7.110070)),//
//            Story(location: "爱尔兰-科克",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 51.896893, longitude: -8.486316)),
//
//
//            Story(location: "西班牙-巴塞罗那",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测段落测试段落测试段落测试段落",
//                  imageName: "2.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 41.385063, longitude: 2.173404)),
//
//            Story(location: "西班牙-马德里",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试试段落测试段落",
//                  imageName: "2.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 40.416775, longitude: -3.703790)),
//
//            Story(location: "法国-巴黎",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "2.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 48.856613, longitude: 2.352222)),
//
//            Story(location: "英国-伦敦",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段段落测试测试段落",
//                  imageName: "3.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 51.507351, longitude: -0.127758)),
//
//            Story(location: "爱尔兰-高威",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "3.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 53.270668, longitude: -9.056790)),
//
//            Story(location: "中国-香港",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "3.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 22.396427, longitude: 114.109497)),
//
//            Story(location: "中国-成都",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "3.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 30.572815, longitude: 104.066803)),
//
//            Story(location: "荷兰-阿姆斯特丹",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 52.370216, longitude: 4.895168)),
//
//            Story(location: "德国-科隆",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 50.937531, longitude: 6.960279)),
//
//            Story(location: "奥地利-萨尔茨堡",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 47.809490, longitude: 13.055010)),
//
//            Story(location: "奥地利-哈尔斯塔特",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "2.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 47.557281, longitude: 13.646960)),
//
//            Story(location: "意大利-威尼斯",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "2.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 45.440845, longitude: 12.315515)),
//
//            Story(location: "意大利-维罗纳",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "3.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 45.438618, longitude: 10.993313)),
//
//            Story(location: "德国-天鹅堡",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "3.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 47.576431, longitude: 10.732980)),
//
//            Story(location: "德国-慕尼黑",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "3.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 48.135124, longitude: 11.581981)),
//
//            Story(location: "葡萄牙-里斯本",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 38.722252, longitude: -9.139337)),
//
//            Story(location: "匈牙利-布达佩斯",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 47.497913, longitude: 19.040236)),
//
//            Story(location: "捷克-布拉格",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 50.075539, longitude: 14.437800)),
//
//            Story(location: "捷克-CK小镇",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 48.810719, longitude: 14.315020)),
//
//            Story(location: "意大利-米兰",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 45.464203, longitude: 9.189982)),
//
//            Story(location: "意大利-比萨",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 43.722839, longitude: 10.401689)),
//
//            Story(location: "比利时-布鲁塞尔",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 50.850346, longitude: 4.351721)),
//
//            Story(location: "比利时-布鲁日",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 51.209347, longitude: 3.224699)),
//
//            Story(location: "荷兰-鹿特丹",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 51.924419, longitude: 4.477733)),
//
//            Story(location: "法国-迪斯尼",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 48.841919, longitude: 2.705300)),
//
//            Story(location: "意大利-罗马",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 41.902782, longitude: 12.496365)),
//
//            Story(location: "梵蒂冈",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 41.902916, longitude: 12.453389)),
//
//            Story(location: "斯洛伐克-布拉迪斯拉发",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 48.148598, longitude: 17.107748)),
//
//            Story(location: "荷兰-埃因霍温",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 51.441643, longitude: 5.469722)),
//
//            Story(location: "比利时-安特卫普",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                   coordinate: CLLocationCoordinate2D(latitude: 51.219448, longitude: 4.402464)),
//
//            Story(location: "中国-重庆",
//                 storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                 imageName: "3.png",
//                 coordinate: CLLocationCoordinate2D(latitude: 30.199869, longitude: 107.732391)),
//
//            Story(location: "泰国-普吉岛",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "3.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 7.951933, longitude: 98.338089)),
        ]
    }
}
