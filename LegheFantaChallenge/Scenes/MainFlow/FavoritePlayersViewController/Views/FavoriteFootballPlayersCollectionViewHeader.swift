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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.white
        addSubview(footballPlayerNameLabel)
        addSubview(footballPlayerPGLabel)
        addSubview(footballPlayerMVLabel)
        addSubview(footballPlayerMFVLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureConstraints() {
        
        addSubview(footballPlayerNameLabel)
        addSubview(footballPlayerPGLabel)
        addSubview(footballPlayerMVLabel)
        addSubview(footballPlayerMFVLabel)
        
        footballPlayerNameLabel.centerYAnchor == centerYAnchor
        footballPlayerNameLabel.leadingAnchor == leadingAnchor + 16
        
        footballPlayerPGLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        footballPlayerMVLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        footballPlayerMFVLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true

        
        footballPlayerMFVLabel.centerYAnchor == centerYAnchor
        footballPlayerMFVLabel.trailingAnchor == trailingAnchor - 32
        
        footballPlayerMVLabel.centerYAnchor == centerYAnchor
        footballPlayerMVLabel.trailingAnchor == footballPlayerMFVLabel.leadingAnchor - 8
        
        
        footballPlayerPGLabel.centerYAnchor == centerYAnchor
        footballPlayerPGLabel.trailingAnchor == footballPlayerMVLabel.leadingAnchor - 8
        footballPlayerPGLabel.leadingAnchor >= footballPlayerNameLabel.leadingAnchor

    }
}
