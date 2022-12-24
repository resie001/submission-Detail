//
//  DetailViewController.swift
//  submission-Detail
//
//  Created by Ade Resie on 24/12/22.
//

import UIKit
import Kingfisher
import submission_Core

class DetailViewController: UIViewController {
    weak var presenter: DetailViewToPresenterProtocol?
    var id: Float!
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var imgView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var nameValue = UILabel()
    private lazy var nameStackView = UIStackView()
    private lazy var addressLabel = UILabel()
    private lazy var addressValue = UILabel()
    private lazy var addressStackView = UIStackView()
    private lazy var likeLabel = UILabel()
    private lazy var likeValue = UILabel()
    private lazy var likeStackView = UIStackView()
    private lazy var infoStackView = UIStackView()
    private lazy var descLabel = UILabel()
    private lazy var descValue = UILabel()
    private lazy var retryBtn = UIButton()
    private lazy var messageLabel = UILabel()
    private lazy var failedStackView = UIStackView()
    private lazy var refreshControl = UIRefreshControl()
    private lazy var indicatorView = UIActivityIndicatorView(style: .large)
    private lazy var processor = DownsamplingImageProcessor(size: CGSize(width: 240, height: 240))
    
    @objc private func retryAction() {
        reloadData()
    }
    
    @objc private func reload(_ refreshControl: UIRefreshControl) {
        reloadData()
    }
    
    private func reloadData() {
        refreshControl.endRefreshing()
        updateUI(state: .loading)
        presenter?.fetchDetail(id: id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar(title: "Detail", isBorderless: false)
        view.backgroundColor = .white
        presenter?.fetchDetail(id: id)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(state: .initial)
    }
    
    private func updateUI(
        state: UIState, error: String? = nil
    ) {
        switch state {
        case .initial:
            scrollView.isHidden = true
            view.addSubview(scrollView)
            scrollView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            scrollView.addSubview(contentView)
            
            refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
            scrollView.refreshControl = refreshControl
            
            contentView.snp.makeConstraints { make in
                make.edges.equalTo(scrollView)
                make.width.equalTo(scrollView)
            }
            
            imgView.layer.cornerRadius = 12
            imgView.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner
            ]
            imgView.clipsToBounds = true
            imgView.kf.indicatorType = .activity
            contentView.addSubview(imgView)
            imgView.snp.makeConstraints { make in
                make.width.height.equalTo(160)
                make.leading.equalTo(contentView.snp.leading).offset(18)
                make.top.equalTo(contentView.snp.top).offset(12)
            }
            
            nameLabel.text = "Name"
            nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
            
            nameValue.numberOfLines = 2
            nameValue.font = .systemFont(ofSize: 14)
            
            nameStackView.axis = .vertical
            nameStackView.spacing = 2
            nameStackView.addArrangedSubview(nameLabel)
            nameStackView.addArrangedSubview(nameValue)
            
            addressLabel.text = "Release Date"
            addressLabel.font = .systemFont(ofSize: 16, weight: .bold)
            
            addressValue.numberOfLines = 2
            addressValue.font = .systemFont(ofSize: 14)
            
            addressStackView.axis = .vertical
            addressStackView.spacing = 2
            addressStackView.addArrangedSubview(addressLabel)
            addressStackView.addArrangedSubview(addressValue)
            
            likeLabel.text = "Metacritic Score"
            likeLabel.font = .systemFont(ofSize: 16, weight: .bold)
            
            likeValue.font = .systemFont(ofSize: 14)
            
            likeStackView.axis = .vertical
            likeStackView.spacing = 2
            likeStackView.addArrangedSubview(likeLabel)
            likeStackView.addArrangedSubview(likeValue)
            
            infoStackView.axis = .vertical
            infoStackView.spacing = 10
            infoStackView.addArrangedSubview(nameStackView)
            infoStackView.addArrangedSubview(addressStackView)
            infoStackView.addArrangedSubview(likeStackView)
            contentView.addSubview(infoStackView)
            infoStackView.snp.makeConstraints { make in
                make.centerY.equalTo(imgView.snp.centerY)
                make.leading.equalTo(imgView.snp.trailing).offset(18)
                make.trailing.equalTo(contentView.snp.trailing).inset(18)
            }
            
            descLabel.text = "Description"
            descLabel.font = .systemFont(ofSize: 16, weight: .bold)
            contentView.addSubview(descLabel)
            descLabel.snp.makeConstraints { make in
                make.top.equalTo(imgView.snp.bottom).offset(18)
                make.leading.equalTo(imgView.snp.leading)
            }
            
            descValue.numberOfLines = 0
            descValue.font = .systemFont(ofSize: 14, weight: .regular)
            contentView.addSubview(descValue)
            descValue.snp.makeConstraints { make in
                make.leading.trailing.equalTo(contentView).inset(18)
                make.top.equalTo(descLabel.snp.bottom).offset(12)
                make.bottom.equalTo(contentView.snp.bottom).inset(12)
            }
            
            failedStackView.axis = .vertical
            failedStackView.spacing = 12
            failedStackView.alignment = .center
            failedStackView.distribution = .equalCentering
            failedStackView.isHidden = true
            
            messageLabel.font = .systemFont(ofSize: 16, weight: .medium)
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            
            retryBtn.backgroundColor = .systemBlue
            retryBtn.setTitleColor(.white, for: .normal)
            retryBtn.layer.cornerRadius = 8
            retryBtn.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
            retryBtn.snp.makeConstraints { make in
                make.width.equalTo(160)
                make.height.equalTo(40)
            }
            
            failedStackView.isHidden = true
            failedStackView.addArrangedSubview(messageLabel)
            failedStackView.addArrangedSubview(retryBtn)
            view.addSubview(failedStackView)
            failedStackView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(18)
            }
            
            indicatorView.startAnimating()
            view.addSubview(indicatorView)
            indicatorView.snp.makeConstraints { make in
                make.center.equalTo(view.safeAreaLayoutGuide)
            }
            
        case .loading:
            failedStackView.isHidden = true
            scrollView.isHidden = true
            indicatorView.isHidden = false
            
        case .finish:
            imgView.kf.setImage(with: URL(string: presenter!.games.backgroundImage))
            descValue.text = presenter?.games.desc
            nameValue.text = presenter?.games.name
            addressValue.text = presenter?.games.release
            likeValue.text = "\(presenter?.games.metacritic)"
            scrollView.isHidden = false
            indicatorView.isHidden = true
            failedStackView.isHidden = true
            
        case .failed:
            indicatorView.isHidden = true
            scrollView.isHidden = true
            retryBtn.setTitle("Retry", for: .normal)
            messageLabel.text = error ?? ""
            failedStackView.isHidden = false
            
        case .empty:
            break
        }
    }
}

extension DetailViewController: DetailPresenterToViewProtocol {
    func showDetail() {
        updateUI(state: .finish)
    }
    
    func showError(error: String) {
        updateUI(state: .failed, error: error)
    }
}
