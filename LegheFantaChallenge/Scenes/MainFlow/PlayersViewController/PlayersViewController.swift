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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.aview?.activityIndicator.stopAnimating()
            self?.aview?.activityIndicator.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    private func configureUI() {
        
    }
    
    private func bind() {
        guard let aView = aview else { return }
    }
}
