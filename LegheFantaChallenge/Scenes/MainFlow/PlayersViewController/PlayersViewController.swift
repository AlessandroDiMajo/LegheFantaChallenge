//
//  PlayersViewController.swift
//  LegheFantaChallenge
//
//  Created by Alessandro Di Majo on 12/10/23.
//

import UIKit
import RxSwift
import RxCocoa
import NotificationBannerSwift
import Speech

protocol PlayersViewControllerDelegate: AnyObject { }

class PlayersViewController: UIViewController {
    
    var aview: PlayersView? {
        return view as? PlayersView
    }
    
    weak var delegate: PlayersViewControllerDelegate?
    private let viewModel: PlayersViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Speech implementation
    fileprivate let audioEngine = AVAudioEngine()
    fileprivate let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "it_IT"))
    fileprivate var request: SFSpeechAudioBufferRecognitionRequest?
    fileprivate var recognitionTask: SFSpeechRecognitionTask?
    
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
        aview?.searchBar.delegate = self
        speechRecognizer?.delegate = self
        aview?.collectionView.register(FootballPlayerCollectionViewCell.self)
        configureUI()
        bind()
        aview?.activityIndicator.isHidden = false
        aview?.activityIndicator.startAnimating()
        viewModel.retrieveFootballPlayers()
        navigationController?.navigationBar.topItem?.titleView = aview?.searchBar
        aview?.microphoneButton.addTarget(self, action: #selector(microphoneButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false

        let spacer = UIView.init(frame: .init(x: 0, y: 0, width: 20, height: 0))
        aview?.searchBar.searchTextField.rightView = spacer
        aview?.searchBar.searchTextField.rightViewMode = .always
    }
    
    private func configureUI() {
        
    }
    
    private func bind() {
        guard let aView = aview else { return }
        
        viewModel.stateRelay
                .bind { [weak self] state in
                    switch state {
                    case .loading:
                        DispatchQueue.main.async {
                            self?.aview?.activityIndicator.isHidden = false
                            self?.aview?.activityIndicator.startAnimating()
                        }
                    case .loaded:
                        DispatchQueue.main.async {
                            self?.aview?.activityIndicator.isHidden = true
                            self?.aview?.activityIndicator.stopAnimating()
                        }
                    case .error(let error):
                        DispatchQueue.main.async {
                            self?.aview?.activityIndicator.isHidden = true
                            self?.aview?.activityIndicator.stopAnimating()
                            let banner = FloatingNotificationBanner(title: error.errorTitle, subtitle: error.errorDescription, style: .danger)
                            banner.show()
                        }
                    }
                }
                .disposed(by: disposeBag)

        aView.searchBar.searchTextField.rx.text
            .skip(1)
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .bind { [weak self] text in
                guard let text = text else { return }
                self?.viewModel.overrideDataSourceBySearchBar(text: text)
            }
            .disposed(by: disposeBag)
        
        viewModel.footballPlayersFilteredRelay
            .bind { [weak self] playersList in
                DispatchQueue.main.async {
                    self?.aview?.emptyStateLabel.isHidden = !(playersList.isEmpty)
                    self?.aview?.collectionView.reloadData()
                }
            }
            .disposed(by: disposeBag)
    }
    
    @objc
    private func microphoneButtonTapped() {
        SFSpeechRecognizer.requestAuthorization { [weak self] (authStatus) in
            switch authStatus {
            case .authorized:
                self?.startRecording()
                break
            case .denied, .restricted, .notDetermined:
                guard let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.open(appSettings)
                }
                break
            @unknown default:
                guard let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.open(appSettings)
                }
            }
        }
    }
    
    func startRecording() {
        guard !audioEngine.isRunning else {
            DispatchQueue.main.sync { [weak self] in
                self?.aview?.microphoneButton.tintColor = Colors.gray6
            }
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
            request?.endAudio()
            return
        }
        do {
            request = SFSpeechAudioBufferRecognitionRequest()
            
            let inputNode = audioEngine.inputNode
            DispatchQueue.main.sync {
                aview?.microphoneButton.tintColor = .red
            }
            recognitionTask = speechRecognizer?.recognitionTask(with: request!, resultHandler: { [weak self] result, error in
                guard let self = self else { return }
                if let result = result, result.isFinal {
                    let bestString = result.bestTranscription.formattedString
                    self.aview?.searchBar.searchTextField.text? +=  bestString
                    self.aview?.searchBar.searchTextField.sendActions(for: .valueChanged)
                } else if let error = error {
                    print("Error: \(error)")
                }
            })
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                self.request?.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
        } catch {
            DispatchQueue.main.sync {
                aview?.microphoneButton.tintColor = Colors.gray6
            }
            print("Error: \(error)")
        }
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
        if footballPlayer.isFavorite{
            cell.starButton.setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Colors.blue), for: .normal)
        } else {
            cell.starButton.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal).withTintColor(Colors.gray4), for: .normal)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let footballPlayer = viewModel.footballPlayersFilteredRelay.value[indexPath.item]
        print("Tapped on \(footballPlayer.playerName)")
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

extension PlayersViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("SearchBar is focus")
        aview?.microphoneButton.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("SearchBar loses the focus")
        aview?.microphoneButton.isHidden = true
    }
}

extension PlayersViewController: SFSpeechRecognizerDelegate {}
