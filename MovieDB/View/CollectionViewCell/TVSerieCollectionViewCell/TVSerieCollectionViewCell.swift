//
//  TVSerieCollectionViewCell.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import UIKit
import Kingfisher

class TVSerieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var tvSeriePosterImageView: UIImageView!
    @IBOutlet private weak var tvSerieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setWith(tvSerie: TVSerieResult) {
        if let url = URL(string: tvSerie.posterPath?.url ?? "") {
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
        tvSerieNameLabel.text = tvSerie.name?.uppercased()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tvSeriePosterImageView.image = nil
    }
    
}
