//
//  PostCell.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

final class PostCell: UITableViewCell {
    
    static let identifier = "post-cell"
    
    private lazy var postView = PostView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: PostCellViewModel?) {
        guard let viewModel = viewModel else { return }
        postView.title = viewModel.title
        postView.subtitle = viewModel.subtitle
    }
    
    func setupViews() {
        accessoryType = .disclosureIndicator
        
        contentView.addSubviewForAutoLayout(postView)
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Metrics.margin),
            postView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.margin),
            postView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.margin),
            postView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.margin)
        ])
    }
}
