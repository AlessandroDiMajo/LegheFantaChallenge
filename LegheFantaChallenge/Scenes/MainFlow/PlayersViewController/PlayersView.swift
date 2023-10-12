//
//  PlayersView.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import Anchorage

class PlayersView: UIView {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = Colors.gray2
        view.isHidden = true
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.backgroundColor = Colors.white
        view.showsVerticalScrollIndicator = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) isn't supported")
    }
    
    private func configureUI() {
        backgroundColor = Colors.white
        addSubview(tableView)
        addSubview(activityIndicator)
    }

    private func configureConstraints() {
        activityIndicator.centerAnchors == centerAnchors
    
        tableView.topAnchor == safeAreaLayoutGuide.topAnchor
        tableView.leadingAnchor == leadingAnchor
        tableView.trailingAnchor == trailingAnchor
        tableView.bottomAnchor == bottomAnchor
    }
}