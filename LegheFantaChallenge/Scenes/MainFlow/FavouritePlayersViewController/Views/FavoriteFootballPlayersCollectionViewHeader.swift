//
//  FavoriteFootballPlayersCollectionViewHeader.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 14/10/23.
//

import Anchorage

class FavoriteFootballPlayersCollectionViewHeader: UICollectionReusableView, ReusableView, ReusableSupplementaryView {
    
    lazy var footballPlayerNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        label.text = "Calciatore"
        return label
    }()
    
    lazy var footballPlayerPGLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        label.text = "PG"
        return label
    }()
    
    lazy var footballPlayerMVLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        label.text = "MV"
        return label
    }()
    
    lazy var footballPlayerMFVLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        label.text = "MFV"
        return label
    }()

    lazy var playerInfosStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [footballPlayerPGLabel, footballPlayerMVLabel, footballPlayerMFVLabel])
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [footballPlayerNameLabel, playerInfosStackView])
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.white
        addSubview(mainStackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureConstraints() {
        mainStackView.topAnchor == topAnchor
        mainStackView.leadingAnchor == leadingAnchor + 16
        mainStackView.trailingAnchor == trailingAnchor - 16
        mainStackView.bottomAnchor == bottomAnchor
    }
}

