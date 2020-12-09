//
//  EditProfilesViewController.swift
//  instagram
//
//  Created by Administrator on 12/6/20.
//

import UIKit

struct EditProfileFormModel{
    let label:String
    let placeholder:String
    var value:String?
}

final class EditProfilesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView:UITableView = {
        let tableView = UITableView()
        
        tableView.register(FormTableViewCell.self,
                           forCellReuseIdentifier: FormTableViewCell.identifier)
        
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancel))
        view.backgroundColor = .systemBackground
    }
    
    private func configureModels(){
        // name, username, website, bio
        let section1Labels = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFormModel]()
        
        for label in section1Labels{
            let model = EditProfileFormModel(label: label,
                                             placeholder: "Enter \(label)..." ,
                                             value: nil)
            section1.append(model)
        }
        models.append(section1)
        //email, phone, gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileFormModel]()
        
        for label in section2Labels{
            let model = EditProfileFormModel(label: label,
                                             placeholder: "Enter \(label)..." ,
                                             value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Tableview
    
    private func createTableHeaderView() -> UIView{
        
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.height/4).integral)
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2,
                                                        y: (header.height-size)/2,
                                                        width: size,
                                                        height: size))
        
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self,
                                     action: #selector(didTapProfileButton),
                                     for: .touchUpInside)
        
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"),
                                              for: .normal)
        
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        
        return header
    }
    
    @objc private func didTapProfileButton(){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier,
                                                 for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else{
            return nil
        }
        
        return "Private Information"
    }
    
    // MARK: - Action
    
    
    
    @objc private func didTapSave(){
        
        //Save info to db
        dismiss(animated: true,
                completion: nil)
    }
    
    @objc private func didTapCancel(){
        
        dismiss(animated: true,
                completion: nil)
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

extension EditProfilesViewController : FormTableViewCellDelegate{
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        //Update the model
        
        print(updatedModel.label)
        print(updatedModel.value ?? "nil")
    }
    
    
}
