//
//  RegisterViewController.swift
//  ReactiveSwiftDemo
//
//  Created by WangKun on 2017/2/27.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyCodeTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    
    
    var viewModel: RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adjustView()
        self.bind()
    }
    
    
    private func adjustView(){
        self.verifyButton.setBackgroundImage(UIImage.imageWithColor(color: UIColor.gray, size: self.verifyButton.frame.size), for: UIControlState.disabled)
        self.registerButton.setBackgroundImage(UIImage.imageWithColor(color: UIColor.gray, size: self.registerButton.frame.size), for: UIControlState.disabled)
    }
    
    private func bind(){
        //TextField
        viewModel.phone <~ self.phoneNumberTextField.reactive.continuousTextValues.skipNil()
        viewModel.password <~ self.passwordTextField.reactive.continuousTextValues.skipNil()
        viewModel.verifyCode <~ self.verifyCodeTextField.reactive.continuousTextValues.skipNil()
        
        //Checkbox
        self.checkBox.reactive.isSelected <~ viewModel.isPolicyCheckd
        self.checkBox.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues { (button) in
            self.viewModel.isPolicyCheckd.value = !button.isSelected
        }
        
        //VerifyButton
        verifyButton.reactive.isEnabled <~ viewModel.canSendAuthCode
        verifyButton.reactive.pressed = CocoaAction(viewModel.sendAuthCode)
        verifyButton.reactive.title <~ viewModel.countDown.map({ (countDown) -> String in
            return countDown > 0 ? "\(countDown)" : "发送"
        })
        
        //RegisterButton
        registerButton.reactive.isEnabled <~ viewModel.canRegister
        registerButton.reactive.pressed = CocoaAction(viewModel.register)
        viewModel.registerSignal.observeValues { (viewModel) in
            guard let viewModel = viewModel else {
                return
            }
            self.performSegue(withIdentifier: "success", sender: viewModel)
        }

    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "success" {
            let nextViewController = segue.destination as? UserInfoViewController
            nextViewController?.userInfoViewModel = sender as? UserInfoViewModel
        }
    }
    

}
