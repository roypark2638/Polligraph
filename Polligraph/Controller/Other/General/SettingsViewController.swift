//
//  SettingsViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/5/21.
//

import UIKit



// no other class can subclass this "final" class
/// View Contorller to show user settings menu
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        // grouped will allow us to get the defualt look of that group table
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingsCellModel]]() // 2d array for multiple sections

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
    }
    
    // this function will get called after all of the subviews have laid out
    // so we can assign our frames here, that way it will account for things like safearea.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureTableView() {
        let section = [
            SettingsCellModel(title: "Sign Out") { [weak self] in
                self?.didTapSignedOut()
            }
        ]
        data.append(section)
    }
    
    private func didTapSignedOut() {
        let actionSheet = UIAlertController(title: "Sign Out",
                                            message: "Are you sure you want to sign out?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            AuthManager.shared.signOutUser { (signedOut) in
                if signedOut {
                    DispatchQueue.main.async {
                        let vc = SignInViewController()
                        vc.modalPresentationStyle = .fullScreen
                        // on completion, we should take away the settings and switch back to the main tab
                        // that way, when the user sign in again, they're back to the home tab rahter than a settings.
                        self.present(vc, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                }
                // error occurs while signing out the user.
                else {
                    fatalError("Could not sign out the user")
                }
            }
            
        }))
        
        // make sure it doesn't crash on the iPad
        // if you don't assign this on iPad, the actionsheet doesn't know how to present itself
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionSheet, animated: true, completion: nil)
    }

}

// MARK: - TableView Delegate and DataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle cell selection
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}
