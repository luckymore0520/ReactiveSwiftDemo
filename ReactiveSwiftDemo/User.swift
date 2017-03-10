//
//  User.swift
//  ReactiveSwiftDemo
//
//  Created by WangKun on 2017/3/9.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import Foundation


struct User {
    var phone:String
    var password:String
    
    var id:Int {
        get {
            return phone.hashValue
        }
    }
}
