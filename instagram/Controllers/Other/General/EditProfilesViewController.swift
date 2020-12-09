//
//  EditProfilesViewController.swift
//  instagram
//
//  Created by Administrator on 12/6/20.
//

import UIKit

class EditProfilesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancel))
        view.backgroundColor = .systemBackground
    }
    
    
    @objc private func didTapSave(){
        
    }
    
    @objc private func didTapCancel(){
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc private func didTapChangeProfilePic(){
        
        let actionsheet = UIAlertController(title: "Profile Picture",
                                            message: "Change Profile Picture",
                                            preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: {_ in
                                            
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: {_ in
                                            
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionsheet.popoverPresentationController?.sourceView = view
        actionsheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionsheet, animated: true)
        
    }
}
