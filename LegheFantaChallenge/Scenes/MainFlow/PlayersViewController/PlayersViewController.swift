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
            .bind { [weak self] universities in
                guard let isFirstFetchDone = self?.viewModel.isFirstFetchDone else { return }
                DispatchQueue.main.async {
                    self?.aview?.tableView.reloadData()
                }
            }
            .disposed(by: disposeBag)
    }
}
