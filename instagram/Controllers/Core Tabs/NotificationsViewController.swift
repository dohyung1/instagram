//
//  NotificationsViewController.swift
//  instagram
//
//  Created by Administrator on 12/6/20.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView:UITableView = {
       
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self,
                           forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        
        tableView.register(NotificationFollowEventTableViewCell.self,
                           forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        
        return tableView
    }()
    
    private let spinner:UIActivityIndicatorView = {
       
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(spinner)
        //spinner.startAnimating()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
        
    }
    
    private func addNoNotificationsView(){
        tableView.isHidden = true
        view.addSubview(noNotificationsView)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationsView.center = view.center
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
}
