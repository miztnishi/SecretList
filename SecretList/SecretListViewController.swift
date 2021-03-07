//
//  SecretListViewController.swift
//  SecretList
//
//  Created by first on 2021/03/06.
//

import UIKit

class SecretListViewController: UIViewController {
    
    private var secretList:[String] = ["１つ目"]
    var secretTextField = UITextField()
    var secretListView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secretTextField.frame = CGRect(x: 0, y: 10, width: 250, height: 30)
        secretTextField.layer.borderWidth = 1
        secretTextField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(secretTextField)
        
        var saveBtn = UIButton(frame: CGRect(x: 250, y: 10, width: 100, height: 30))
        saveBtn.addTarget(self, action: #selector(tapSave), for: .touchUpInside)
        saveBtn.backgroundColor = .systemBlue
        saveBtn.setTitle("save", for: .normal)
        view.addSubview(saveBtn)
        
        secretListView.frame = CGRect(x: 0, y: 40, width: view.frame.size.width, height: view.frame.size.height)
        secretListView.dataSource = self
        secretListView.delegate = self
        view.addSubview(secretListView)
        

       
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
