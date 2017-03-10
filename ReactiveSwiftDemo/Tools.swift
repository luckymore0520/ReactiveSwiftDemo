//
//  Tools.swift
//  ReactiveSwiftDemo
//
//  Created by WangKun on 2017/3/9.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func imageWithColor(color:UIColor, size:CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor);
        context?.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
