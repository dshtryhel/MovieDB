//
//  MovieOrTVSerieCollectionViewCell.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 21.01.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import Kingfisher

class MovieOrTVSerieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var movieOrTVSerieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    func setMovie(movie: MovieResult) {
        if let url = URL(string: movie.posterPath?.url ?? "placeHolderImage") {
            movieOrTVSerieImageView.kf.indicatorType = .activity
            movieOrTVSerieImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeHolderImage"),
                options: [
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
    }

    func setTVSerie(tvSerie: TVSerieResult) {
        if let url = URL(string: tvSerie.posterPath?.url ?? "placeHolderImage") {
            movieOrTVSerieImageView.kf.indicatorType = .activity
            movieOrTVSerieImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeHolderImage"),
                options: [
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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieOrTVSerieImageView.image = nil
    }
        
}

