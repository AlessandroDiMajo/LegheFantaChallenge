//
//  FootballPlayerCollectionViewCell.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 13/10/23.
//

import Anchorage
import Kingfisher

class FootballPlayerCollectionViewCell: UICollectionViewCell, ReusableView {
    
    var onStarButtonTapped: (() -> Void)?
    
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

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
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

    lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal).withTintColor(Colors.gray4), for: .normal)
        return button
    }()


    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        starButton.addTarget(self, action: #selector(didTapStarButton), for: .touchUpInside)
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
        starButton.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal).withTintColor(Colors.gray4), for: .normal)
    }
    // MARK: - Configure methods
    
    private func configureUI() {
        addSubview(containerView)
        containerView.addSubview(footballPlayerImageSquaredBackground)
        containerView.addSubview(footballPlayerImageView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(footballPlayerNameLabel)
        stackView.addArrangedSubview(footballPlayerTeamNameLabel)
        containerView.addSubview(starButton)
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
    
        stackView.topAnchor == containerView.topAnchor + 16
        stackView.leadingAnchor == footballPlayerImageSquaredBackground.trailingAnchor + 10
        stackView.bottomAnchor == containerView.bottomAnchor - 15
        
        starButton.heightAnchor == 40
        starButton.widthAnchor == 40
        starButton.centerYAnchor == footballPlayerImageSquaredBackground.centerYAnchor
        starButton.trailingAnchor == containerView.trailingAnchor - 16
    }
    
    func configure(footballPlayer: FootballPlayer) {
        footballPlayerImageView.kf.setImage(with: footballPlayer.imageURL)
        footballPlayerNameLabel.text = footballPlayer.playerName
        footballPlayerTeamNameLabel.text = footballPlayer.teamAbbreviation
    }
    
    @objc
    private func didTapStarButton() {
        onStarButtonTapped?()
    }
}
