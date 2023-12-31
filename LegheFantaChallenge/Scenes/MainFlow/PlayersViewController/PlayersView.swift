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

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Cerca calciatori"
        searchBar.searchTextField.clearButtonMode = .never
        return searchBar
    }()
    
    lazy var microphoneButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.tintColor = Colors.gray6
        button.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = Colors.white
        view.showsVerticalScrollIndicator = false
        return view
    }()

    lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        label.text = "La ricerca non ha prodotto risultati"
        label.textColor = Colors.gray4
        return label
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
        addSubview(collectionView)
        addSubview(activityIndicator)
        addSubview(emptyStateLabel)
        searchBar.addSubview(microphoneButton)
    }

    private func configureConstraints() {
        activityIndicator.centerAnchors == centerAnchors
    
        collectionView.topAnchor == safeAreaLayoutGuide.topAnchor
        collectionView.leadingAnchor == leadingAnchor
        collectionView.trailingAnchor == trailingAnchor
        collectionView.bottomAnchor == bottomAnchor
        
        emptyStateLabel.centerAnchors == centerAnchors
        
        microphoneButton.centerYAnchor == searchBar.centerYAnchor
        microphoneButton.trailingAnchor == searchBar.trailingAnchor - 24
    }
}
