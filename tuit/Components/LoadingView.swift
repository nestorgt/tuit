//
//  LoadingView.swift
//  tuit
//
//  Created by Nestor Garcia on 17/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    struct Config {
        let style: UIActivityIndicatorView.Style
        let outerMargin: CGFloat = 50
        let innerMargin: CGFloat = 20
    }
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.alpha = 0.75
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .tuitTitle
        label.isHidden = true
        return label
    }()
    
    private let spinner: UIActivityIndicatorView
    
    private let config: Config
    
    init(config: LoadingView.Config) {
        self.config = config
        spinner = UIActivityIndicatorView(style: config.style)
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    func present(in view: UIView?, message: String? = nil) -> LoadingView {
        guard let view = view else { fatalError("view is nil") }
        set(message: message)
        view.addSubviewForAutoLayout(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        setNeedsLayout()
        layoutIfNeeded()
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
        return self
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    @discardableResult
    func update(message: String?) -> LoadingView {
        UIView.animate(withDuration: 0.1) {
            self.set(message: message)
            self.layoutIfNeeded()
        }
        return self
    }
    
    static var standard: LoadingView {
        LoadingView(config: Config(style: .medium))
    }
}

// MARK: - Private

private extension LoadingView {
    
    func setupViews() {
        stackView.spacing = config.innerMargin

        addSubviewForAutoLayout(contentView)
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: config.outerMargin),
            contentView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -config.outerMargin),
            contentView.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: config.outerMargin),
            contentView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -config.outerMargin)
        ])
        
        contentView.addSubviewForAutoLayout(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: config.innerMargin),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -config.innerMargin),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: config.innerMargin),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -config.innerMargin)
        ])
        stackView.addArrangedSubview(spinner)
        stackView.addArrangedSubview(label)
        
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        spinner.startAnimating()
    }
    
    func set(message: String?) {
        label.isHidden = message?.count ?? 0 == 0
        label.text = message
    }
}
