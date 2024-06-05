//
//  FollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/31/24.
//

import UIKit

class FollowerItemVC: ItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(infoType: .followers, with: user.followers)
        itemInfoView2.set(infoType: .following, with: user.following)
        actionButton.set(backGroungColor: .systemGreen, title: "Get Followers")
    }
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
    
}
