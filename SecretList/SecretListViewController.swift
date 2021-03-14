//
//  SecretListViewController.swift
//  SecretList
//
//  Created by first on 2021/03/06.
//

import UIKit
import RealmSwift

class SecretListViewController: UIViewController {
    
    var secretList:Results<SecretItem>?
    
    var secretListView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        //addSubviewする前か
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(SecretTableViewCell.self, forCellReuseIdentifier: "secretCell")
        return tableView
    }()
    var navBar:UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.backgroundColor = .black
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(showSaveAlert))
        navItem.rightBarButtonItem = doneItem
        navigationBar.setItems([navItem], animated: false)
        return navigationBar
    }()
    
    //var paddingTopbetweenListandInput:CGFloat = 5 下にformを作った時にpaddingとしてSE用に作成
    //var safeAreaBottom:CGFloat = 20
    var safeAreaTop:CGFloat = 20
    
    override func viewWillAppear(_ animated: Bool) {
        secretList = SecretDBManager.sharedInstance.getAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(navBar)
        secretListView.dataSource = self
        secretListView.delegate = self
        view.addSubview(secretListView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                //safeAreaBottom = self.view.safeAreaInsets.bottom
                safeAreaTop = self.view.safeAreaInsets.top
            //                //SE用
            //                if(safeAreaBottom == 0) {
            //                    safeAreaBottom = 10
            //                    paddingTopbetweenListandInput = 20
            //
            //                }
            //iphone以外の使用は想定しないでおきたい
            @unknown default: break
            }
            
            //autoLayout設定
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant:safeAreaTop).isActive = true
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            navBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
            secretListView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
            secretListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            secretListView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            secretListView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
        
        
    }
    
    
    /// 登録
    @objc func showSaveAlert(){
        let alert = UIAlertController(title: "登録",message: "",preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.brown
        alert.view.backgroundColor = UIColor.lightGray
        alert.view.layer.cornerRadius = 25
        
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "サービス名"
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "ID"
        }
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Password"
        }
        
        alert.addAction(UIAlertAction(title: "登録", style: .default, handler: { [self] action in
            
            let serviceName = alert.textFields![0].text
            let formid = alert.textFields![1].text
            let password = alert.textFields![2].text
            
            //バリデーション
            if(serviceName!.isEmpty || formid!.isEmpty || password!.isEmpty){
                return
            }
            
            //登録
            let secretItem = SecretItem()
            secretItem.serviceName = serviceName
            secretItem.formId = formid
            secretItem.password = password
            self.saveSecret(object: secretItem)
            self.secretListView.reloadData()
        }))
        
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    
    func saveSecret(object:SecretItem){
        SecretDBManager.sharedInstance.add(data: object)
        secretList =  SecretDBManager.sharedInstance.getAll()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secretCell", for: indexPath) as! SecretTableViewCell
        (cell.viewWithTag(1) as! UILabel).text = "ID:" + secretList![indexPath.section].formId
        (cell.viewWithTag(2) as! UILabel).text = "Pass: " + secretList![indexPath.section].password
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secretList![section].serviceName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = secretList?.count {
            return count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "削除",
                                              handler: { [ self] (action: UIContextualAction, view: UIView, completion: @escaping(Bool) -> Void) in
                                                
                                                ConfirmAlert { isOk in
                                                    if isOk {
                                                        SecretDBManager.sharedInstance.deleteOne(id: secretList![indexPath.row].id)
                                                        secretListView.reloadData()
                                                        completion(true)
                                                    }else{
                                                        completion(false)
                                                    }
                                                }
                                              })
        return UISwipeActionsConfiguration(actions:  [deleteAction])
    }
    
    
    /// 確認アラート
    /// - Parameter handler: クロージャ:OK NO の処理
    func ConfirmAlert( handler: @escaping(Bool)->Void){
        let alert = UIAlertController(title: "削除していいですか",message: "",preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.brown
        alert.view.backgroundColor = UIColor.lightGray
        alert.view.layer.cornerRadius = 25
        let OkALert = UIAlertAction(title: "OK", style: .default) { action in
             handler(true)
        }
        let NoALert = UIAlertAction(title: "Cancel", style: .cancel) { action in
            handler(false)
        }
        alert.addAction(OkALert)
        alert.addAction(NoALert)
        self.present(alert, animated: true)
    }
    
    
    
    
    
}
