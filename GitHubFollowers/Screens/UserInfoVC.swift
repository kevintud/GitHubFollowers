//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/26/24.
//

import UIKit

protocol USerInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let view1 = UIView()
    let view2 = UIView()
    let dateLabel = CustomBodyLabel(textAlignMent: .center)
    var itemsViews: [UIView] = []
    
    var username: String!
    weak var deleagate: FollowerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layouUI()
        getUserInfo()
        
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func getUserInfo() {
        Network.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIEllements(with: user)
                }
                
            case .failure(let error):
                self.pressentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, button: "Ok")
            }
            
        }
    }
    
    func configureUIEllements(with user: User)  {
        let repotItemVC = RepoItemVC(user: user)
        repotItemVC.delegate = self
        
        let followerItemVC = FollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: UserInfoHeaderVC(user: user), containerView: self.headerView)
        self.add(childVC: repotItemVC, containerView: self.view1)
        self.add(childVC: followerItemVC, containerView: self.view2)
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYeartFormat())"
    }
    
    func layouUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemsViews = [headerView, view1, view2, dateLabel]
        
        for itemsView in itemsViews {
            view.addSubview(itemsView)
            itemsView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            view1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant:  padding),
            view1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant:  padding),
            view2.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childVC: UIViewController, containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    @objc func dismissVC() {
        dismiss(animated: true)
    }

    
}

extension UserInfoVC: USerInfoVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            pressentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", button: "Ok")
            return
        }
        presentSafariVC(with: url)
        
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            pressentGFAlertOnMainThread(title: "No followers", message: "This user has no follower", button: "So Sad")
            return
        }
        deleagate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
}
