//
//  NowPlayingMovieCollectionViewCell.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import UIKit
import Kingfisher

class NowPlayingMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setWith(nowPlayingMovie: MovieResult) {
        if let url = URL(string: nowPlayingMovie.posterPath?.url ?? "") {
            let processor = DownsamplingImageProcessor(size: moviePosterImageView.frame.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            moviePosterImageView.kf.indicatorType = .activity
            moviePosterImageView.kf.setImage(
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
        movieNameLabel.text = nowPlayingMovie.originalTitle?.uppercased()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterImageView.image = nil
    }
    
}
