//
//  CompanyInfoTableViewCell.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import UIKit

class CompanyInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblCompanyInfo: UILabel!
    
    static let nib = UINib(nibName: String(describing: CompanyInfoTableViewCell.self), bundle: nil)
    static let identifier = "CompanyInfoCell"
    
    func setupCell(company: CompanyInfo) {
        self.viewBackground.layer.cornerRadius = 10
        self.viewBackground.layer.masksToBounds = true
        self.selectionStyle = .none
        self.lblCompanyInfo.text = "\(company.name) was founded by \(company.founder) in \(company.founded). It has now \(company.employees) employees, \(company.launch_sites) launch sites, and is valued at USD \(company.valuation.formatLargeNumber())."
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("MainViewController") {
    let service = ServiceMock.shared
    let vm = MainViewModel(service)
    let vc = MainViewController(viewModel: vm)
    let nav = UINavigationController(rootViewController: vc)
    
    return nav
}

@available(iOS 17.0, *)
#Preview("Cell") {
    let cell = CompanyInfoTableViewCell()
    cell.setupCell(company: CompanyInfo.stub())
    
    return cell
}
#endif
