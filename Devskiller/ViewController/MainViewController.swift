//
//  MainViewController.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: MainViewModel
    private var isLoading = false
    
    enum MainSections: Int {
        case companyInfo = 0
        case launches = 1
    }
    
    required init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: MainViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SpaceX"
        self.setupFilter()
        self.setupTableView()
        self.getAll()
    }
    
    private func setupTableView() {
        self.tableView.separatorStyle = .none
        self.tableView.register(CompanyInfoTableViewCell.nib, forCellReuseIdentifier: CompanyInfoTableViewCell.identifier)
        self.tableView.register(LaunchTableViewCell.nib, forCellReuseIdentifier: LaunchTableViewCell.identifier)
    }
    
    private func getAll() {
        guard !self.isLoading else { return }
        self.isLoading = true
        
        Task {
            defer {
                self.isLoading = false
            }
            do {
                try await self.viewModel.initialLoad()
                self.tableView.reloadData()
            } catch let error as APIError {
                self.showAlert(title: error.errorDescription, message: error.recoverySuggestion)
            } catch {
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.getAll()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections = 0
        if self.viewModel.companyInfo != nil {
            sections += 1
        }
        if !self.viewModel.launches.isEmpty {
            sections += 1
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch MainSections(rawValue: section) {
        case .companyInfo: return "Company"
        case .launches:    return "Launches"
        default:           return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch MainSections(rawValue: section) {
        case .companyInfo: return 1
        case .launches:    return self.viewModel.filteredLaunches.count
        default:           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch MainSections(rawValue: indexPath.section) {
        case .companyInfo: return 100
        case .launches:    return 160
        default:           return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch MainSections(rawValue: indexPath.section) {
        case .companyInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanyInfoTableViewCell.identifier) as? CompanyInfoTableViewCell,
                  let companyInfo = self.viewModel.companyInfo else {
                return UITableViewCell()
            }
            cell.setupCell(company: companyInfo)
            return cell
        case .launches:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.identifier) as? LaunchTableViewCell else {
                return UITableViewCell()
            }
            let launch = self.viewModel.filteredLaunches[indexPath.row]
            let rocket = self.viewModel.rockets.first { $0.id == launch.rocket }
            cell.setupCell(launch: launch, rocket: rocket)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch MainSections(rawValue: indexPath.section) {
        case .companyInfo:
            break
        case .launches:
            let launch = self.viewModel.filteredLaunches[indexPath.row]
            var actions: [UIAlertAction] = []
            let alertController = UIAlertController(title: "Open Link", message: "Choose a link to open", preferredStyle: .actionSheet)
            if let articleUrl = launch.links.article {
                actions.append(UIAlertAction(title: "Article", style: .default) { _ in
                    self.openURL(articleUrl)
                })
            }
            if let wikiUrl = launch.links.wikipedia {
                actions.append(UIAlertAction(title: "Wikipedia", style: .default) { _ in
                    self.openURL(wikiUrl)
                })
            }
            if let videoUrl = launch.links.webcast {
                actions.append(UIAlertAction(title: "Video", style: .default) { _ in
                    self.openURL(videoUrl)
                })
            }
            if actions.isEmpty {
                alertController.message = "No links available"
            }
            actions.append(UIAlertAction(title: "Cancel", style: .cancel))
            actions.forEach { alertController.addAction($0) }
            present(alertController, animated: true)
        default: return
        }
    }
    
    private func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Filter
extension MainViewController {
    private func setupFilter() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(didTapFilterButton))
    }

    @objc private func didTapFilterButton() {
        var filterMessage = ""
        if let selectedYear = self.viewModel.selectedYear {
            filterMessage = "Year: \(selectedYear)"
        } else {
            filterMessage = "Year: All"
        }
        let sortOrder = self.viewModel.sortAscending ? "Ascending" : "Descending"
        filterMessage += "\nSort: \(sortOrder)"
        
        if let isSuccessful = self.viewModel.isSuccessful {
            let successStatus = isSuccessful ? "Successful" : "Failed"
            filterMessage += "\nSuccess: \(successStatus)"
        } else {
            filterMessage += "\nSuccess: All"
        }
        
        let alertController = UIAlertController(title: "Filter Options", message: filterMessage, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Year", style: .default) { _ in
            self.showYearFilter()
        })
        alertController.addAction(UIAlertAction(title: "Sort", style: .default) { _ in
            self.showSortFilter()
        })
        alertController.addAction(UIAlertAction(title: "Success", style: .default) { _ in
            self.showSuccessFilter()
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }

    private func showYearFilter() {
        let yearAlertController = UIAlertController(title: "Select Launch Year", message: nil, preferredStyle: .actionSheet)
        
        let allAction = UIAlertAction(title: "All", style: .default) { _ in
            self.viewModel.applyYearFilter(year: nil)
            self.tableView.reloadData()
        }
        if self.viewModel.selectedYear == nil {
            allAction.setValue(true, forKey: "checked")
        }
        yearAlertController.addAction(allAction)
        
        self.viewModel.launchYears.forEach { year in
            let yearAction = UIAlertAction(title: "\(year)", style: .default) { _ in
                self.viewModel.applyYearFilter(year: year)
                self.tableView.reloadData()
            }
            if self.viewModel.selectedYear == year {
                yearAction.setValue(true, forKey: "checked")
            }
            yearAlertController.addAction(yearAction)
        }
        
        yearAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(yearAlertController, animated: true)
    }

    private func showSortFilter() {
        let sortAlertController = UIAlertController(title: "Sort Order", message: nil, preferredStyle: .actionSheet)
        
        let ascAction = UIAlertAction(title: "Ascending", style: .default) { _ in
            self.viewModel.applySortOrder(ascending: true)
            self.tableView.reloadData()
        }
        let descAction = UIAlertAction(title: "Descending", style: .default) { _ in
            self.viewModel.applySortOrder(ascending: false)
            self.tableView.reloadData()
        }
        
        if self.viewModel.sortAscending {
            ascAction.setValue(true, forKey: "checked")
        } else {
            descAction.setValue(true, forKey: "checked")
        }
        
        sortAlertController.addAction(descAction)
        sortAlertController.addAction(ascAction)
        sortAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(sortAlertController, animated: true)
    }

    private func showSuccessFilter() {
        let successAlertController = UIAlertController(title: "Select Launch Success", message: nil, preferredStyle: .actionSheet)
        
        let successfulAction = UIAlertAction(title: "Successful", style: .default) { _ in
            self.viewModel.applySuccessFilter(success: true)
            self.tableView.reloadData()
        }
        let failedAction = UIAlertAction(title: "Failed", style: .default) { _ in
            self.viewModel.applySuccessFilter(success: false)
            self.tableView.reloadData()
        }
        let allAction = UIAlertAction(title: "All", style: .default) { _ in
            self.viewModel.applySuccessFilter(success: nil)
            self.tableView.reloadData()
        }
        
        if let isSuccessful = self.viewModel.isSuccessful {
            if isSuccessful {
                successfulAction.setValue(true, forKey: "checked")
            } else {
                failedAction.setValue(true, forKey: "checked")
            }
        } else {
            allAction.setValue(true, forKey: "checked")
        }
        
        successAlertController.addAction(allAction)
        successAlertController.addAction(successfulAction)
        successAlertController.addAction(failedAction)
        successAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(successAlertController, animated: true)
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    let service = ServiceMock.shared
    let vm = MainViewModel(service)
    let vc = MainViewController(viewModel: vm)
    let nav = UINavigationController(rootViewController: vc)
    
    return nav
}
#endif
