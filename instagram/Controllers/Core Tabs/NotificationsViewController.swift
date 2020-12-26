//
//  NotificationsViewController.swift
//  instagram
//
//  Created by Administrator on 12/6/20.
//

import UIKit

enum UserNotificationType{
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification{
    let type:UserNotificationType
    let text:String
    let user:User
}

final class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    private var models = [UserNotification]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
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
    
    private func fetchNotifications(){
        for x in 0...100 {
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string:"https://www.google.com/")!,
                                caption: nil,
                                likes: [],
                                postURL: URL(string:"https://www.google.com/")!,
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [])
            
            let model = UserNotification(type: x%2  == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "hello world",
                                         user: User(username: "joe",
                                                    bio: "",
                                                    name: (first: "", last: ""),
                                                    birthDate: Date(),
                                                    profilePhoto: URL(string: "https://www.google.com/")!,
                                                    gender: .male,
                                                    counts: UserCount(followers: 1, following: 1, posts: 1),
                                                    joinDate: Date()))
            
            models.append(model)
        }
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
        return models.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        switch model.type {
        case .like(_):
            //like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier,
                                                     for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            //follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier,
                                                     for: indexPath) as! NotificationFollowEventTableViewCell
            //cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension NotificationsViewController : NotificationLikeEventTableViewCellDelegate{
    func didTapRelatedPostButton(model: UserNotification) {
        //open the post
    }
}

extension NotificationsViewController : NotificationFollowEventTableViewCellDelegate{
    func didTapFollowUnfollowButton(model: UserNotification) {
        // follow
    }
}
