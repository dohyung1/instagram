//
//  SettingsViewController.swift
//  instagram
//
//  Created by Administrator on 12/6/20.
//

import UIKit
import SafariServices

struct SettingCellModel{
    
    let title:String
    let handler:(()->Void)
    
}

/// View Controller to show user settings
final class SettingsViewController: UIViewController {

    private let tableview:UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    private func configureModels(){
        
        data.append([
            //add weak to prevent causing memory leak of self
            SettingCellModel(title: "Edit Profile"){ [weak self] in
                self?.didTapEditProfile()
                
            },
            
            SettingCellModel(title: "Invite Friends"){ [weak self] in
                self?.didTapInviteFriends()
                
            },
            
            SettingCellModel(title: "Save Original Posts"){ [weak self] in
                self?.didTapSaveOriginalPosts()
                
            }
        ])
        
        data.append([
            //add weak to prevent causing memory leak of self
            SettingCellModel(title: "Terms of Service"){ [weak self] in
                self?.openURL(type: .terms)
                
            },
            SettingCellModel(title: "Privacy Policy"){ [weak self] in
                self?.openURL(type: .privacy)
                
            },
            SettingCellModel(title: "Help / Feedback"){ [weak self] in
                self?.openURL(type: .help)
                
            },
        ])
        
        data.append([
            //add weak to prevent causing memory leak of self
            SettingCellModel(title: "Log Out"){ [weak self] in
                self?.didTapLogOut()
                
            }
        ])
        
    }
    
    enum SettingsUrlType{
        
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsUrlType){
        let urlString:String
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com/"
        
        }
        
        guard let url = URL(string: urlString)else{
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    private func didTapEditProfile(){
        let vc = EditProfilesViewController()
        vc.title = "Edit Profile"
        
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func didTapInviteFriends(){
        //Show share sheet
    }
    
    private func didTapSaveOriginalPosts(){
        
    }
    
    private func didTapLogOut(){
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            
            AuthMgr.shared.logOut(completion: {success in
                DispatchQueue.main.async {
                    if success{
                        //present log in
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                    else{
                        // error occurred
                        fatalError("Could not log out user")
                    }
                }
            })
        }))
        
        actionSheet.popoverPresentationController?.sourceView = tableview
        actionSheet.popoverPresentationController?.sourceRect = tableview.bounds
        present(actionSheet, animated: true)
    }
}

extension SettingsViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = data[indexPath.section][indexPath.row]
        model.handler()
        
        //Handle cell selection
    }
    
}
