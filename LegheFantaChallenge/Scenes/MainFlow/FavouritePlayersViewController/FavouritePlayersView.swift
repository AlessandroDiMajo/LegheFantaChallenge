//
//  FavouritePlayersView.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import Anchorage

class FavouritePlayersView: UIView {
    
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
    }

    private func configureConstraints() {

    }
}
