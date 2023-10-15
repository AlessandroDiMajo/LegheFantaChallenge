//
//  FavoritePlayersView.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import Anchorage

class FavoritePlayersView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionHeadersPinToVisibleBounds = true
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = Colors.white
        view.showsVerticalScrollIndicator = false
        return view
    }()

    lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        label.text = "Nessun preferito"
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
        backgroundColor = Colors.gray
        addSubview(collectionView)
        addSubview(emptyStateLabel)
    }

    private func configureConstraints() {
        collectionView.topAnchor == safeAreaLayoutGuide.topAnchor
        collectionView.leadingAnchor == leadingAnchor
        collectionView.trailingAnchor == trailingAnchor
        collectionView.bottomAnchor == bottomAnchor

        emptyStateLabel.centerAnchors == centerAnchors
    }
}
