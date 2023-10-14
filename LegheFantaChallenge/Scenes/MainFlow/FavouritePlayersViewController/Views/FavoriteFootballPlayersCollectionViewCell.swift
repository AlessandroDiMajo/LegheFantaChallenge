//
//  FavoriteFootballPlayersCollectionViewCell.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 14/10/23.
//

import Anchorage
import Kingfisher

class FavoriteFootballPlayersCollectionViewCell: UICollectionViewCell, ReusableView {
    
    // MARK: - UI
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray
        view.layer.cornerRadius = 8
        return view
    }()

    lazy var footballPlayerImageSquaredBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray5
        return view
    }()

    lazy var footballPlayerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        //view.image = placeholder //TODO: USE PLACEHOLDER
        return view
    }()

    lazy var footballPlayerNameAndTeamStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()

    lazy var footballPlayerNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var footballPlayerTeamNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        return label
    }()
    
    lazy var footballPlayerStatsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.spacing = 8
        return stackView
    }()

    lazy var footballPlayerPGLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        return label
    }()
    
    lazy var footballPlayerMVLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        return label
    }()

    lazy var footballPlayerMFVLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        return label
    }()
    
    lazy var footballPlayerInfosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        footballPlayerImageSquaredBackground.layer.cornerRadius = min(footballPlayerImageSquaredBackground.frame.width, footballPlayerImageSquaredBackground.frame.height) / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        footballPlayerImageView.image = nil
        footballPlayerNameLabel.text = nil
        footballPlayerTeamNameLabel.text = nil
        footballPlayerPGLabel.text = nil
        footballPlayerMVLabel.text = nil
        footballPlayerMFVLabel.text = nil
        
    }
    // MARK: - Configure methods
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubview(footballPlayerImageSquaredBackground)
        containerView.addSubview(footballPlayerImageView)
        containerView.addSubview(footballPlayerNameAndTeamStackView)
        footballPlayerNameAndTeamStackView.addArrangedSubview(footballPlayerNameLabel)
        footballPlayerNameAndTeamStackView.addArrangedSubview(footballPlayerTeamNameLabel)
        containerView.addSubview(footballPlayerStatsStackView)
        footballPlayerStatsStackView.addArrangedSubview(footballPlayerPGLabel)
        footballPlayerStatsStackView.addArrangedSubview(footballPlayerMVLabel)
        footballPlayerStatsStackView.addArrangedSubview(footballPlayerMFVLabel)
    }
    
    
    private func configureConstraints() {
        containerView.topAnchor == topAnchor
        containerView.leadingAnchor == leadingAnchor + 14
        containerView.trailingAnchor == trailingAnchor - 14
        containerView.bottomAnchor == bottomAnchor

        footballPlayerImageSquaredBackground.topAnchor == containerView.topAnchor + 8
        footballPlayerImageSquaredBackground.leadingAnchor == containerView.leadingAnchor + 8
        footballPlayerImageSquaredBackground.bottomAnchor == containerView.bottomAnchor - 8
        footballPlayerImageSquaredBackground.widthAnchor == 54
        footballPlayerImageSquaredBackground.heightAnchor == 54

        footballPlayerImageView.centerAnchors == footballPlayerImageSquaredBackground.centerAnchors
        footballPlayerImageView.heightAnchor == 40
        footballPlayerImageView.widthAnchor == 40
    
        footballPlayerNameAndTeamStackView.topAnchor == containerView.topAnchor + 15
        footballPlayerNameAndTeamStackView.leadingAnchor == footballPlayerImageSquaredBackground.trailingAnchor + 10
        footballPlayerNameAndTeamStackView.bottomAnchor == containerView.bottomAnchor - 15
        
        footballPlayerStatsStackView.centerYAnchor == footballPlayerImageSquaredBackground.centerYAnchor
        footballPlayerStatsStackView.trailingAnchor == containerView.trailingAnchor - 16
        
        
    }
    
    func configure(footballPlayer: FootballPlayer) {
        footballPlayerImageView.kf.setImage(with: footballPlayer.imageURL)
        footballPlayerNameLabel.text = footballPlayer.playerName
        footballPlayerTeamNameLabel.text = footballPlayer.teamAbbreviation
        footballPlayerPGLabel.text = footballPlayer.gamesPlayed.description
        footballPlayerMVLabel.text = footballPlayer.averageGrade.description
        footballPlayerMFVLabel.text = footballPlayer.averageFantaGrade.description
    }
}
