//
//  RepoItemVC.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/31/24.
//

import UIKit

class RepoItemVC: ItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(infoType: .repos, with: user.publicRepos)
        itemInfoView2.set(infoType: .gists, with: user.publicGists)
        actionButton.set(backGroungColor: .systemPurple, title: "Github Profile")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
    
    
}
