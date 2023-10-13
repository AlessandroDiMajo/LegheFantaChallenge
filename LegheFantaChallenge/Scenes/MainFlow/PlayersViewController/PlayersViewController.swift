//
//  PlayersViewController.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import UIKit
import RxSwift
import RxCocoa

protocol PlayersViewControllerDelegate: AnyObject { }

class PlayersViewController: UIViewController {
    
    var aview: PlayersView? {
        return view as? PlayersView
    }

    weak var delegate: PlayersViewControllerDelegate?
    private let viewModel: PlayersViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: PlayersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PlayersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        aview?.collectionView.delegate = self
        aview?.collectionView.dataSource = self
        aview?.collectionView.register(FootballPlayerCollectionViewCell.self)
        configureUI()
        bind()
        aview?.activityIndicator.isHidden = false
        aview?.activityIndicator.startAnimating()
        viewModel.retrieveFootballPlayers() { [weak self] in
            DispatchQueue.main.async {
                self?.aview?.activityIndicator.stopAnimating()
                self?.aview?.activityIndicator.isHidden = true
            }
        }
        navigationController?.navigationBar.topItem?.titleView = aview?.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    private func configureUI() {
        
    }
    
    private func bind() {
        guard let aView = aview else { return }
        
        aView.searchBar.searchTextField.rx.text
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .bind { [weak self] text in
                guard let text = text else { return }
                self?.viewModel.filterFootballPlayersList(text: text)
            }
            .disposed(by: disposeBag)
        
        viewModel.footballPlayersFilteredRelay
            .bind { [weak self] _ in
                //guard let isFirstFetchDone = self?.viewModel.isFirstFetchDone else { return }
                DispatchQueue.main.async {
                    self?.aview?.collectionView.reloadData()
                }
            }
            .disposed(by: disposeBag)
    }
}

extension PlayersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.footballPlayersFilteredRelay.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FootballPlayerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let footballPlayer = viewModel.footballPlayersFilteredRelay.value[indexPath.item]
        
            cell.configure(footballPlayer: footballPlayer)

            cell.onStarButtonTapped = { [weak self] in
                
                self?.viewModel.didTappedStarButton(footballPlayer: footballPlayer)
            }
        //TODO: Manage favorites
            /*if footballPlayer.isFavorite {
                cell.bookmarkButton.setImage(UIImage(named: "star"), for: .normal)
            } else {
                cell.bookmarkButton.setImage(UIImage(named: "star.fill"), for: .normal)
            }*/
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let footballPlayer = viewModel.footballPlayersFilteredRelay.value[indexPath.item]
        //guard let footballPlayer = viewModel.footballPlayersFilteredRelay.value[safe: indexPath.item] else { return }
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
