//
//  FavoritePlayersViewController.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import UIKit
import RxSwift
import RxCocoa

protocol FavoritePlayersViewControllerDelegate: AnyObject { }

class FavouritePlayersViewController: UIViewController {
    
    var aview: FavoritePlayersView? {
        return view as? FavoritePlayersView
    }

    weak var delegate: FavoritePlayersViewControllerDelegate?
    private let viewModel: FavoritePlayersViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: FavoritePlayersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = FavoritePlayersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        aview?.collectionView.delegate = self
        aview?.collectionView.dataSource = self
        aview?.collectionView.register(FavoriteFootballPlayersCollectionViewCell.self)
        aview?.collectionView.register(FavoriteFootballPlayersCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FavoriteFootballPlayersCollectionViewHeader.defaultReuseIdentifier)
        configureUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    private func configureUI() {
        
    }
    
    private func bind() {
        guard let _ = aview else { return }
        
        viewModel.savedFootballPlayersRelay
            .bind { [weak self] playersList in
                DispatchQueue.main.async {
                    self?.aview?.emptyStateLabel.isHidden = !(playersList.isEmpty)
                    self?.aview?.collectionView.reloadData()
                }
            }
            .disposed(by: disposeBag)
    }
}

extension FavoritePlayersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.savedFootballPlayersRelay.value.count == 0 ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.savedFootballPlayersRelay.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoriteFootballPlayersCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let footballPlayer = viewModel.savedFootballPlayersRelay.value[indexPath.item]
        cell.configure(footballPlayer: footballPlayer)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let footballPlayer = viewModel.savedFootballPlayersRelay.value[indexPath.item]
        print("Tapped on \(footballPlayer.playerName)")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 70

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let heightCondition = (section == 0)
        return CGSize(width: collectionView.frame.width, height: heightCondition ? 35 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FavoriteFootballPlayersCollectionViewHeader.defaultReuseIdentifier, for: indexPath) as? FavoriteFootballPlayersCollectionViewHeader else { fatalError() }
        return header
    }

}
