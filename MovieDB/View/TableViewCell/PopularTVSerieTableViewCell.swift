//
//  PopularTVSerieTableViewCell.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import UIKit
import Kingfisher

class PopularTVSerieTableViewCell: UITableViewCell {

    @IBOutlet private weak var tvSeriePosterImageView: UIImageView!
    @IBOutlet private weak var voteAverageContainerView: UIView!
    @IBOutlet private weak var voteAverageIntegerValueLabel: UILabel!
    @IBOutlet private weak var voteAverageDecimalValueLabel: UILabel!
    @IBOutlet private weak var tvSerieNameLabel: UILabel!
    
    private let gradientStartColor = UIColor(red: 239 / 255, green: 127 / 255, blue: 16 / 255, alpha: 1)
    private let gradientEndColor = UIColor(red: 205 / 255, green: 26 / 255, blue: 85 / 255, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        voteAverageContainerView.applyGradient(startColor: gradientStartColor, endColor: gradientEndColor)
    }

    func setWith(tvSerie: TVSerieResult) {
        if let url = URL(string: tvSerie.backdropPath?.url ?? "") {
            let processor = DownsamplingImageProcessor(size: tvSeriePosterImageView.frame.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            tvSeriePosterImageView.kf.indicatorType = .activity
            tvSeriePosterImageView.kf.setImage(
                with: url,
                placeholder: #imageLiteral(resourceName: "placeHolderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
        
        if let voteAverage = tvSerie.voteAverage?.stringValue.split(separator: ".") {
            voteAverageIntegerValueLabel.text = "\(voteAverage[0])"
            voteAverageDecimalValueLabel.text = ".\(voteAverage[1])"
        }
        
        tvSerieNameLabel.text = tvSerie.name?.uppercased()
        
        if let firstAirDate = tvSerie.firstAirDate?.prefix(4), let name = tvSerie.name?.uppercased() {
            tvSerieNameLabel.text = "\(name)(\(firstAirDate)-)"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tvSeriePosterImageView.image = nil
    }
    
}
