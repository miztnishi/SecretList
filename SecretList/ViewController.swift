//
//  ViewController.swift
//  SecretList
//
//  Created by first on 2021/03/02.
//
import LocalAuthentication
import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("認証", for:.normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        let context = LAContext()
        var error: NSError? = nil
        //NSError is created by objective-c  → &error
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "please auth another"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ [weak self] success,error in
                
                DispatchQueue.main.async {
                    guard success, error == nil else{
                        //error
                        print("error")
                        return
                    }
                    //success
                    print("success")
                    let slvc = SecretListViewController()
                    //遷移にfull screen表示
                    slvc.modalPresentationStyle = .fullScreen
                    self?.present(slvc, animated:  false, completion: nil)
                }
                
            }
            
        }
    }
    
    
}

