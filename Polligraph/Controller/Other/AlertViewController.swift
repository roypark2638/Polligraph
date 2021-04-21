//
//  AlertViewController.swift
//  Polligraph
//
//  Created by Roy Park on 4/19/21.
//

import UIKit

class AlertViewController: UIViewController {
    
    var alerts = [Alert]()
    
    private let noAlert: UILabel = {
        let label = UILabel()
        label.text = "No new alerts."
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        label.textColor = .secondaryLabel
        label.isHidden = false
        label.textAlignment = .center
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        
        tableView.register(
            AlertUserFollowTableViewCell.self,
            forCellReuseIdentifier: AlertUserFollowTableViewCell.identifier
        )
        tableView.register(
            AlertPostCommentTableViewCell.self,
            forCellReuseIdentifier: AlertPostCommentTableViewCell.identifier
        )
        tableView.register(
            AlertPostCommentLikeTableViewCell.self,
            forCellReuseIdentifier: AlertPostCommentLikeTableViewCell.identifier
        )
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tintColor = .label
        spinner.startAnimating()
        return spinner
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addSubviews()
        fetchAlertData()
        tableView.delegate = self
        tableView.dataSource = self
//        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayouts()
    }

    private func fetchAlertData() {
        DatabaseManager.shared.getAlerts { [weak self] (alerts) in
            print("\n\n\(alerts.count)")
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.spinner.isHidden = true
                self?.alerts = alerts
                self?.updateUI()
            }
        }
    }
    
    
    private func updateUI() {
        if alerts.isEmpty {
            noAlert.isHidden = false
            tableView.isHidden = true
        }
        else {
            noAlert.isHidden = true
            tableView.isHidden = false
        }
        
        tableView.reloadData()
    }
    
    private func addSubviews() {
        view.addSubview(noAlert)
        view.addSubview(tableView)
        view.addSubview(spinner)
    }
    
    private func configureLayouts() {
        tableView.frame = view.bounds
        
        noAlert.sizeToFit()
        noAlert.frame = CGRect(
            x: (view.width-noAlert.width)/2,
            y: view.safeAreaInsets.top + 150,
            width: noAlert.width,
            height: noAlert.height
        )
        
        spinner.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 100
        )
        
        spinner.center = view.center
    }
    
}

// MARK: - UITableViewDataSource

extension AlertViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = alerts[indexPath.row]
        
//        guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: AlertUserFollowTableViewCell.identifier,
//                for: indexPath)
//                as? AlertUserFollowTableViewCell else {
//            return UITableViewCell()
//        }
//        cell.configure(with: "TestUsername", model: model)
//
//        return cell
        switch model.type {

        case .userFollow(let username):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AlertUserFollowTableViewCell.identifier,
                    for: indexPath
            ) as? AlertUserFollowTableViewCell else {
                return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            }
            cell.configure(with: username, model: model)
            return cell

        case .postComment(let postName):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AlertPostCommentTableViewCell.identifier,
                    for: indexPath
            ) as? AlertPostCommentTableViewCell else {
                return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            }
            cell.configure(with: model)

            return cell
        case .postCommentLike(let postName):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AlertPostCommentLikeTableViewCell.identifier,
                    for: indexPath
            ) as? AlertPostCommentLikeTableViewCell else {
                return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            }
            cell.configure(with: model)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITableViewDelegate

extension AlertViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let model = alerts[indexPath.row]
        model.isHidden = true
        
        DatabaseManager.shared.markAlertAsHidden(alertID: model.identifier) { [weak self] success in
            if success {
                self?.alerts = self?.alerts.filter({ $0.isHidden == false }) ?? []
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .none)
                tableView.endUpdates()
            }
        }
    }
}
