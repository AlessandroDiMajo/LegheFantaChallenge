//
//  FavoriteFootballPlayersCollectionViewCell.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 14/10/23.
//

import Anchorage
import Kingfisher

class FavoriteFootballPlayersCollectionViewCell: UICollectionViewCell, ReusableView {
    
    private let CIRCLE_BACKGROUND_DIMENSION: CGFloat = 54
    private let PLAYER_ICON_DIMENSION: CGFloat = 40

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
    
    lazy var footballPlayerIconView: UIView = {
        let view = UIView()
        return view
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

    lazy var footballPlayerGeneralInfoView: UIView = {
        let view = UIView()
        return view
    }()


    lazy var footballPlayerPGLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        label.textAlignment = .center
        return label
    }()
    
    lazy var footballPlayerMVLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        label.textAlignment = .center
        return label
    }()

    lazy var footballPlayerMFVLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.gray3
        label.textAlignment = .center
        return label
    }()

    lazy var playerInfosView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [footballPlayerGeneralInfoView, playerInfosView])
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
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
        footballPlayerImageSquaredBackground.layer.cornerRadius = CIRCLE_BACKGROUND_DIMENSION / 2
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
        footballPlayerIconView.addSubview(footballPlayerImageSquaredBackground)
        footballPlayerIconView.addSubview(footballPlayerImageView)
        footballPlayerGeneralInfoView.addSubview(footballPlayerIconView)
        footballPlayerGeneralInfoView.addSubview(footballPlayerNameLabel)
        footballPlayerGeneralInfoView.addSubview(footballPlayerTeamNameLabel)
    
        playerInfosView.addSubview(footballPlayerPGLabel)
        playerInfosView.addSubview(footballPlayerMVLabel)
        playerInfosView.addSubview(footballPlayerMFVLabel)
        containerView.addSubview(mainStackView)
    }
    
    
    private func configureConstraints() {
        containerView.topAnchor == topAnchor
        containerView.leadingAnchor == leadingAnchor + 16
        containerView.trailingAnchor == trailingAnchor - 16
        containerView.bottomAnchor == bottomAnchor
    
        footballPlayerImageSquaredBackground.topAnchor == footballPlayerIconView.topAnchor + 8
        footballPlayerImageSquaredBackground.leadingAnchor == footballPlayerIconView.leadingAnchor + 8
        footballPlayerImageSquaredBackground.bottomAnchor == footballPlayerIconView.bottomAnchor - 8
        footballPlayerImageSquaredBackground.widthAnchor.constraint(equalToConstant: CIRCLE_BACKGROUND_DIMENSION).isActive = true
        footballPlayerImageSquaredBackground.heightAnchor.constraint(equalToConstant: CIRCLE_BACKGROUND_DIMENSION).isActive = true

        footballPlayerImageView.centerAnchors == footballPlayerImageSquaredBackground.centerAnchors
        footballPlayerImageView.widthAnchor.constraint(equalToConstant: PLAYER_ICON_DIMENSION).isActive = true
        footballPlayerImageView.heightAnchor.constraint(equalToConstant: PLAYER_ICON_DIMENSION).isActive = true

        footballPlayerIconView.centerYAnchor == footballPlayerGeneralInfoView.centerYAnchor
        footballPlayerIconView.centerXAnchor == footballPlayerGeneralInfoView.centerXAnchor
        footballPlayerIconView.leadingAnchor == footballPlayerGeneralInfoView.leadingAnchor

        footballPlayerNameLabel.topAnchor == footballPlayerImageSquaredBackground.topAnchor + 7
        footballPlayerNameLabel.leadingAnchor == footballPlayerImageSquaredBackground.trailingAnchor + 8
        footballPlayerNameLabel.trailingAnchor == footballPlayerGeneralInfoView.trailingAnchor

        footballPlayerTeamNameLabel.topAnchor == footballPlayerNameLabel.bottomAnchor + 5
        footballPlayerTeamNameLabel.leadingAnchor == footballPlayerNameLabel.leadingAnchor
        footballPlayerTeamNameLabel.trailingAnchor == footballPlayerGeneralInfoView.trailingAnchor
        
        
        footballPlayerPGLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        footballPlayerMVLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        footballPlayerMFVLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true

        footballPlayerMFVLabel.centerYAnchor == playerInfosView.centerYAnchor
        footballPlayerMFVLabel.trailingAnchor == playerInfosView.trailingAnchor - 16
        
        footballPlayerMVLabel.centerYAnchor == playerInfosView.centerYAnchor
        footballPlayerMVLabel.trailingAnchor == footballPlayerMFVLabel.leadingAnchor - 8
        
        footballPlayerPGLabel.centerYAnchor == playerInfosView.centerYAnchor
        footballPlayerPGLabel.trailingAnchor == footballPlayerMVLabel.leadingAnchor - 8
        footballPlayerPGLabel.leadingAnchor >= playerInfosView.leadingAnchor
        
        mainStackView.topAnchor == containerView.topAnchor
        mainStackView.leadingAnchor == containerView.leadingAnchor
        mainStackView.trailingAnchor == containerView.trailingAnchor
        mainStackView.bottomAnchor == containerView.bottomAnchor
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
