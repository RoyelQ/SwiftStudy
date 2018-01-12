//
//  Const.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/5.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Device Macro
let iPhoneX = CGSize.init(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!)
let isPad = UI_USER_INTERFACE_IDIOM() == .pad
let isPhone = UI_USER_INTERFACE_IDIOM() == .phone

let User_Defaults = UserDefaults.standard

let JRAppDelegate = UIApplication.shared.delegate as! AppDelegate

let CurrentLanguage = NSLocale.preferredLanguages[0]

let CurrentSystemVersion = UIDevice.current.systemVersion

let AppCurrentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String



// MARK: - Color Macro
func ColorFromHex(rgbValue : Int) -> UIColor {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,                  green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,                  blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0, alpha: 1.0)    
}

func Color(r : Int, g : Int, b : Int) -> UIColor {
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}


//导航栏
let Navigation_Bar_Tint_Color = ColorFromHex(rgbValue: 0xF5F5F5)
let Navigation_Bar_Text_Color = ColorFromHex(rgbValue: 0x404040)
let Navigation_Bar_Item_Color = ColorFromHex(rgbValue: 0x808080)
//主色调
let Main_Background_Color = ColorFromHex(rgbValue: 0xF5F5F5)
let Main_Color = ColorFromHex(rgbValue: 0x27A7FE)
let Separata_Line_Color = ColorFromHex(rgbValue: 0xDCDCDC)
let Main_Text_Color = ColorFromHex(rgbValue: 0x404040)
let Main_Text_Color_Gray = ColorFromHex(rgbValue: 0x808080)
let Main_Text_Color_Light_Gray = ColorFromHex(rgbValue: 0x909090)

let White_Color = UIColor.white
let Clear_Color = UIColor.clear

let Button_Selected_Back_Color = ColorFromHex(rgbValue : 0x27A7FE)
let Button_Unselected_Back_Color = ColorFromHex(rgbValue : 0xDCDCDC)

let Random_Color = UIColor.init(red: CGFloat(Double(arc4random()%256)/255.0), green: CGFloat(Double(arc4random()%256)/255.0), blue: CGFloat(Double(arc4random()%256)/255.0), alpha: 1.0)


// MARK: - Layout Macro
let Screen_width = UIScreen.main.bounds.size.width
let Screen_height = UIScreen.main.bounds.size.height
let Tabbar_height = 57.0
let Navi_Height = 64.0 + (iPhoneX ? 24.0 : 0.0)


func AdaptX(x : CGFloat) -> CGFloat {
    
    return UIScreen.main.bounds.size.width/320.0 * x
}
func AdaptY(y : CGFloat) -> CGFloat {
    
    return UIScreen.main.bounds.size.width/568.0 * y
}

func viewX(object : UIView) -> CGFloat {
    return object.frame.origin.x
}
func viewY(object : UIView) -> CGFloat {
    return object.frame.origin.y
}
func viewWidth(object : UIView) -> CGFloat {
    return object.frame.size.width
}
func viewHeight(object : UIView) -> CGFloat {
    return object.frame.size.height
}
func viewRight(object : UIView) -> CGFloat {
    return viewWidth(object: object) + object.frame.origin.x
}
func viewBottom(object : UIView) -> CGFloat {
    return viewHeight(object: object) + object.frame.origin.y
}
func viewCenterX(object : UIView) -> CGFloat {
    return viewWidth(object: object)/2.0 + object.frame.origin.x
}
func viewCenterY(object : UIView) -> CGFloat {
    return viewHeight(object: object) + object.frame.origin.y
}

// MARK: - Other Macro




/**
 显示所有iPhone上的字体
 */
func showAllFonts() {
    let familyNames = UIFont.familyNames
    for familyName in familyNames {
        print("family:\(familyName)")
        let fontNames = UIFont.fontNames(forFamilyName: familyName as String)
        for fontName in fontNames {
            print("font:\(fontName)")
        }
        print("-------------")
    }
}

//苹方字体
func Font(size : CGFloat) -> UIFont {

    return UIFont.init(name: "PingFangSC-Regular", size: size)!
}




func printLog<T>(message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line)
{
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}


