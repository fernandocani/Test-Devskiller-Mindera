//
//  LaunchTableViewCell.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imgPatch: UIImageView!
    @IBOutlet weak var lblMission: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblRocket: UILabel!
    @IBOutlet weak var lblDaysTitle: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    static let nib = UINib(nibName: String(describing: LaunchTableViewCell.self), bundle: nil)
    static let identifier = "LaunchCell"
    
    func setupCell(launch: Launch, rocket: Rocket?) {
        self.viewBackground.layer.cornerRadius = 10
        self.viewBackground.layer.masksToBounds = true
        self.selectionStyle = .none
        
        self.setupIcon(launch: launch)
        self.setupMission(launch: launch)
        self.setupDateTime(launch: launch)
        if let rocket {
            self.setupRocket(rocket: rocket)
        } else {
            self.lblRocket.text = "Rocket not available"
        }
        self.setupDeltaDays(launch: launch)
        self.setupUpcoming(launch: launch)
    }
    
    private func setupIcon(launch: Launch) {
        self.imgPatch.layer.cornerRadius = 10
        self.imgPatch.layer.masksToBounds = true
        var link: String?
        if link == nil, let small = launch.links.patch.small {
            link = small
        }
        if link == nil, let large = launch.links.patch.large {
            link = large
        }
        guard let urlString = link else {
            self.imgPatch.image = UIImage(named: "placeholder")
            return
        }
        ImageCacheManager.fetchImage(urlString: urlString) { [weak self] image in
            self?.imgPatch.image = image
        }
    }
    
    private func setupMission(launch: Launch) {
        self.lblMission.text = launch.name
    }
    
    private func setupDateTime(launch: Launch) {
        if #available(iOS 15.0, *) {
            self.lblDateTime.text = launch.dateUTC?.formatted(date: .abbreviated, time: .shortened)
        } else {
            self.lblDateTime.text = launch.dateUTC?.description
        }
    }
    
    private func setupRocket(rocket: Rocket) {
        self.lblRocket.text = rocket.name
    }
    
    private func setupDeltaDays(launch: Launch) {
        if launch.upcoming {
            self.lblDaysTitle.text = "Days from launch"
        } else {
            self.lblDaysTitle.text = "Days since launch"
        }
        if let date = launch.dateUTC {
            let components = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: date)
            if launch.upcoming {
                self.lblDays.text = "\(components.day ?? 0)d, \(components.hour ?? 0)h, \(components.minute ?? 0)m, \(components.second ?? 0)s"
            } else {
                self.lblDays.text = "\(components.day ?? 0) days"
            }
        }
    }
    
    private func setupUpcoming(launch: Launch) {
        var status: String = "-"
        if let success = launch.success {
            status = success ? "👍" : "👎"
        }
        self.lblStatus.text = status
    }
}

extension LaunchTableViewCell {
    @available(iOS 15.0, *)
    private func fetchImageData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }

    private func fetchImageDataLegacy(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
            } else {
                completion(data)
            }
        }.resume()
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
    let cell = LaunchTableViewCell()
    cell.setupCell(launch: Launch.stub(), rocket: Rocket.stub())
    
    return cell
}
#endif
