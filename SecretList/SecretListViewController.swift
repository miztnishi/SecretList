//
//  SecretListViewController.swift
//  SecretList
//
//  Created by first on 2021/03/06.
//

import UIKit

class SecretListViewController: UIViewController {
    
    private var secretList:[String] = ["初期値"]
    var secretTextField = UITextField()
    var secretListView = UITableView()
    var saveBtn = UIButton()
    var paddingTopbetweenListandInput:CGFloat = 5
    var safeAreaBottom:CGFloat = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.safeAreaInsets.bottom)
        view.backgroundColor = .systemBackground
        secretTextField.layer.borderWidth = 1
        secretTextField.layer.borderColor = UIColor.black.cgColor
        
        secretTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(secretTextField)
        
        saveBtn.layer.cornerRadius = 10
        saveBtn.addTarget(self, action: #selector(tapSave), for: .touchUpInside)
        saveBtn.backgroundColor = .systemBlue
        saveBtn.setTitle("save", for: .normal)
        
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(saveBtn)
        
        secretListView.dataSource = self
        secretListView.delegate = self
        secretListView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secretListView)
        
    }
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                safeAreaBottom = self.view.safeAreaInsets.bottom
                
                //SE用
                if(safeAreaBottom == 0) {
                    safeAreaBottom = 10
                    paddingTopbetweenListandInput = 20
                    
                }
            //iphone以外の使用は想定しないでおきたい
            @unknown default: break
            }

            
            secretListView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            secretListView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -70).isActive = true
            secretListView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            secretTextField.topAnchor.constraint(equalTo: secretListView.bottomAnchor, constant: paddingTopbetweenListandInput).isActive = true
            secretTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 5).isActive = true
            secretTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant:  -100).isActive = true
            secretTextField.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -safeAreaBottom).isActive = true
            
            saveBtn.topAnchor.constraint(equalTo: secretListView.bottomAnchor, constant: paddingTopbetweenListandInput).isActive = true
            saveBtn.leadingAnchor.constraint(equalTo: secretTextField.trailingAnchor, constant: 2).isActive = true
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor ,constant: -5).isActive = true
            saveBtn.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -safeAreaBottom).isActive = true
        }
        
        
        
    }
    
    @objc func tapSave(){
        secretList.append(secretTextField.text ?? "")
        secretListView.reloadData()
        secretTextField.text = ""
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension SecretListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secretList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
        cell.textLabel?.text = secretList[indexPath.row]
        return cell
    }
    
    
}
