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
        guard let aView = aview else { return }
    }
}
