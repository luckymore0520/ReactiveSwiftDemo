//
//  UserService.swift
//  ReactiveSwiftDemo
//
//  Created by WangKun on 2017/3/9.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import Foundation

class UserService {
    
    static func register(withUsername username: String, password:String, verifyCode:String, completion: @escaping (Bool) -> Void) {
        let delay = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            completion(true)
        }
    }
    
    
    static func sendAuthCode(withUsername username: String, completion: @escaping (Bool) -> Void) {
        let delay = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            completion(true)
        }
    }
}
