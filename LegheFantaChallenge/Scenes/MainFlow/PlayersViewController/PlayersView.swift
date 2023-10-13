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
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        addSubview(collectionView)
        addSubview(activityIndicator)
    }

    private func configureConstraints() {
        activityIndicator.centerAnchors == centerAnchors
    
        collectionView.topAnchor == safeAreaLayoutGuide.topAnchor
        collectionView.leadingAnchor == leadingAnchor
        collectionView.trailingAnchor == trailingAnchor
        collectionView.bottomAnchor == bottomAnchor
    }
}
