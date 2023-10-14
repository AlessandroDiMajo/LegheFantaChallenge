//
//  FavouritePlayersViewController.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import UIKit
import RxSwift
import RxCocoa

protocol FavouritePlayersViewControllerDelegate: AnyObject { }

class FavouritePlayersViewController: UIViewController {
    
    var aview: FavouritePlayersView? {
        return view as? FavouritePlayersView
    }

    weak var delegate: FavouritePlayersViewControllerDelegate?
    private let viewModel: FavouritePlayersViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: FavouritePlayersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = FavouritePlayersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        aview?.collectionView.delegate = self
        aview?.collectionView.dataSource = self
        aview?.collectionView.register(FavoriteFootballPlayersCollectionViewCell.self)
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
            .bind { [weak self] _ in
                //guard let isFirstFetchDone = self?.viewModel.isFirstFetchDone else { return }
                DispatchQueue.main.async {
                    self?.aview?.collectionView.reloadData()
                }
            }
            .disposed(by: disposeBag)
    }
}

extension FavouritePlayersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
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
        print("Hai tappato su \(footballPlayer.playerName)")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 70

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let heightCondition = (section == 0)
        return CGSize(width: collectionView.frame.width, height: heightCondition ? 16 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
