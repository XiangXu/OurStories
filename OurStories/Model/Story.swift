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
                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
                  imageName: "1.png",
                  coordinate: CLLocationCoordinate2D(latitude: 53.381210, longitude: -6.592220)),
           
            Story(location: "爱尔兰-都柏林",
                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
                  imageName: "1.png",
                  coordinate: CLLocationCoordinate2D(latitude: 53.349804, longitude: -6.260310)),
           
//            Story(location: "中国-江汉油田",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 30.404983, longitude: 112.894037)),
//            
//            Story(location: "中国-武汉",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 30.592850, longitude: 114.305542)),
//            
//            Story(location: "中国-厦门",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 24.479834, longitude: 118.089424)),
//            
//            Story(location: "爱尔兰-科克",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 51.896893, longitude: -8.486316)),
//          
//            Story(location: "爱尔兰-韦克斯福德",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "1.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 52.339230, longitude: -6.460040)),
//            
//            Story(location: "爱尔兰-沃特福德",
//                  storyContent: "测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落测试段落",
//                  imageName: "2.png",
//                  coordinate: CLLocationCoordinate2D(latitude: 52.259319, longitude: -7.110070)),
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
