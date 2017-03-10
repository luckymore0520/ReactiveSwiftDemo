//
//  UserInfoViewModel.swift
//  ReactiveSwiftDemo
//
//  Created by WangKun on 2017/3/9.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result


class UserInfoViewModel {
    var phone:Property<String>
    var password:Property<String>
    var id:Property<String>
    
    init(_ user:User) {
        phone = Property(value: user.phone)
        password = Property(value: user.password)
        id = Property(value: "\(user.id)")
    }
}
