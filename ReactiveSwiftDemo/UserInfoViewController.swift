//
//  UserInfoViewController.swift
//  ReactiveSwiftDemo
//
//  Created by WangKun on 2017/3/9.
//  Copyright © 2017年 luckymore. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift


class UserInfoViewController: UIViewController {

    var userInfoViewModel:UserInfoViewModel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        phoneNumberLabel.reactive.text <~ userInfoViewModel.phone.map({ (phone) -> String in
            "手机号:\(phone)"
        })
        
        passwordLabel.reactive.text <~ userInfoViewModel.password.map({ (password) -> String in
            "密码:\(password)"
        })
        
        idLabel.reactive.text <~ userInfoViewModel.id.map({ (id) -> String in
            "ID:\(id)"
        })
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
