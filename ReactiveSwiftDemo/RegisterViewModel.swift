//
//  RegisterViewModel.swift
//  ReactiveSwiftDemo
//
//  Created by WangKun on 2017/2/27.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class RegisterViewModel {
    let verifyCode: MutableProperty<String>
    let password: MutableProperty<String>
    let phone: MutableProperty<String>
    
    var countDown: MutableProperty<Int>
    let canSendAuthCode: Property<Bool>
    let isPolicyCheckd: MutableProperty<Bool>
    let canRegister: Property<Bool>
    var sendAuthCode : Action<(),Bool,NoError>!
    var register : Action<(),UserInfoViewModel?,NoError>!

    var timer: Timer?
    
    
    
    
    init(){
        phone = MutableProperty("")
        password = MutableProperty("")
        verifyCode = MutableProperty("")
        countDown = MutableProperty(0)
        isPolicyCheckd = MutableProperty(false)
        canSendAuthCode = phone.combineLatest(with: countDown).map({ (phone, count) -> Bool in
            return phone.characters.count == 11 && count <= 0
        })
        
        canRegister = phone.combineLatest(with: password).map({ (phone,password) -> Bool in
            return phone.characters.count == 11 && !password.isEmpty
        }).combineLatest(with: verifyCode).map({ (phoneAndPassword,verifyCode) -> Bool in
            return phoneAndPassword && verifyCode.characters.count == 4
        }).combineLatest(with: isPolicyCheckd).map({ (isAllFilled, isChecked) -> Bool in
            return isAllFilled && isChecked
        })
        sendAuthCode = Action<(),Bool,NoError>(enabledIf:canSendAuthCode) {
            return self.createSendAuthCodeSignalProducer(phone: self.phone.value)
        }
        register = Action<(),UserInfoViewModel?,NoError>(enabledIf:canRegister) {
            return self.createRegisterSignalProducer(phone: self.phone.value, password: self.password.value, verifyCode: self.verifyCode.value)
        }
        
    }
    
    
    private func startTimer(){
        if let lastTimer = timer {
            lastTimer.invalidate()
            timer = nil
        }
        countDown.value = 60
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {
            [unowned self]
            _ in
            self.countDown.value -= 1
            if (self.countDown.value <= 0) {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
    }
    
    private func createSendAuthCodeSignalProducer(phone: String) -> SignalProducer<Bool,NoError> {
        let (signal, observer) = Signal<Bool,NoError>.pipe()
        let signalProducer = SignalProducer<Bool, NoError>(signal).on {
            [unowned self]
            success in
            if (success) {
                self.startTimer()
            }
        }
        UserService.sendAuthCode(withUsername: phone) { (success) in
            observer.send(value: success)
            observer.sendCompleted()
        }
        return signalProducer
    }
    
    private func createRegisterSignalProducer(phone: String, password:String, verifyCode:String) -> SignalProducer<UserInfoViewModel?,NoError> {
        let (signal,observer) = Signal<UserInfoViewModel?,NoError>.pipe()
        let signalProducer = SignalProducer<UserInfoViewModel?, NoError>(signal)
        UserService.register(withUsername: phone, password: password, verifyCode: verifyCode) {
            (user) in
            if let user = user {
                observer.send(value: UserInfoViewModel(user))
                observer.sendCompleted()
            } else {
                observer.send(value: nil)
            }
        }
        return signalProducer
    }

    
}
