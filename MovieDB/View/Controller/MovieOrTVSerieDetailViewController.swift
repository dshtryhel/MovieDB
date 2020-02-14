//
//  MovieOrTVSerieDetailViewController.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import UIKit

final class MovieOrTVSerieDetailViewController: UIViewController {
    
    @IBOutlet private weak var backDropImageView: UIImageView!
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel! // Movie or TV serie name
    @IBOutlet private weak var genreLabel: UILabel!
    
    @IBOutlet private weak var voteAverageIntegerValueLabel: UILabel!
    @IBOutlet private weak var voteAverageDecimalValueLabel: UILabel!
    @IBOutlet private var starImageViews: [UIImageView]!
    
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var crewAndCastCollectionView: UICollectionView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    let viewModel = MovieDetailViewModel()
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Subcribing to movie
        subscribeMovie()
        
        // MARK: Configuring CollectionView
        configureMovieCrewCollectionView()
        
        // MARK: Subscribing to Movie Cast&Crew Response
        subscribeMovieCreditsResponse()
        
        // MARK: Subcribing to TV Serie
        subscribeTVSerie()
    }
    
    // MARK: Subcription Of TV Serie
    func subscribeTVSerie() {
        viewModel.tvSerie.subscribe(onNext: { (tvSerie) in
            
            if let tvSerieId = tvSerie?.id {
                self.viewModel.fetchTVSerieCharacterList(tvSerieId: tvSerieId)
            }
            
            if let url = URL(string: tvSerie?.backdropPath?.url ?? "") {
                self.backDropImageView.kf.setImage(with: url)
            } else {
                self.backDropImageView.image = UIImage(named: "placeHolderImage")
            }
            
            if let url = URL(string: tvSerie?.posterPath?.url ?? "") {
                self.posterImageView.kf.setImage(with: url)
            }
            
            if let name = tvSerie?.name?.uppercased() {
                self.nameLabel.text = name
            }
            
            if let voteAverage = tvSerie?.voteAverage?.stringValue.split(separator: ".") {
                self.voteAverageIntegerValueLabel.text = "\(voteAverage[0])"
                self.voteAverageDecimalValueLabel.text = ".\(voteAverage[1])"
            }
            
            if let overview = tvSerie?.overview?.getLineSpacedAttributedText(lineSpacing: 8) {
                self.overviewLabel.attributedText = overview
            }
            
            let starCount = Int((tvSerie?.voteAverage ?? 0)) / 2
            for imageView in 0..<starCount {
                self.starImageViews[imageView].image = #imageLiteral(resourceName: "icStarSelected")
            }
            
            var genreList: [String] = []
            tvSerie?.genreids?.forEach({ (id) in
                if let genre = ApplicationVariables.tvSerieGenreList?.first(where: {$0.id == id})?.name {
                    genreList.append(genre)
                }
            })
            
            if let genres = genreList.getStringFromArraySeperatedByComa() {
                self.genreLabel.text = genres
            }
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Subscription Of Movie Credits Response
    func subscribeMovieCreditsResponse() {
        viewModel.creditsResponse.subscribe(onNext: { [weak self] (movieCreditsResponse) in
            self?.spinner.stopAnimating()
            self?.crewAndCastCollectionView.reloadData()
        }, onError: { (error) in
            print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Configuration of Movie Crew Collection View
    func configureMovieCrewCollectionView() {
        crewAndCastCollectionView.register(UINib(nibName: "MovieCrewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCrewCellID")
        crewAndCastCollectionView.dataSource = self
    }
    
    // MARK: Subcription Of Movie
    func subscribeMovie() {
        viewModel.movie.subscribe(onNext: { (movie) in
            
            if let movieId = movie?.id {
                self.viewModel.fetchMovieCharacterList(movieId: movieId)
            }
            
            if let url = URL(string: movie?.backdropPath?.url ?? "") {
                self.backDropImageView.kf.setImage(with: url)
            } else {
                self.backDropImageView.image = UIImage(named: "placeHolderImage")
            }
            
            if let url = URL(string: movie?.posterPath?.url ?? "") {
                self.posterImageView.kf.setImage(with: url)
            }
            
            if let name = movie?.originalTitle?.uppercased() {
                self.nameLabel.text = name
            }
            
            if let voteAvrage = movie?.voteAverage?.stringValue.split(separator: ".") {
                self.voteAverageIntegerValueLabel.text = "\(voteAvrage[0])"
                self.voteAverageDecimalValueLabel.text = ".\(voteAvrage[1])"
            }
            
            if let overview = movie?.overview?.getLineSpacedAttributedText(lineSpacing: 8) {
                self.overviewLabel.attributedText = overview
            }
            
            
            for imageView in 0..<(Int((movie?.voteAverage ?? 0)) / 2) {
                self.starImageViews[imageView].image = #imageLiteral(resourceName: "icStarSelected")
            }
            
            var genreList: [String] = []
            movie?.genreids?.forEach({ (id) in
                if let genre = ApplicationVariables.movieGenreList?.first(where: {$0.id == id})?.name {
                    genreList.append(genre)
                }
            })
            
            if let genres = genreList.getStringFromArraySeperatedByComa() {
                self.genreLabel.text = genres
            }
        })
            .disposed(by: viewModel.disposeBag)
    }
}

// MARK: UICollectionViewDataSource Extension
extension MovieOrTVSerieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.crewList.count + viewModel.castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCrewCellID", for: indexPath) as! MovieCrewCollectionViewCell
        
        
        if viewModel.crewList.count > 0, indexPath.item < viewModel.crewList.count {
            let crew = viewModel.crewList[indexPath.item]
            cell.setWith(crew: crew)
        }
        
        if viewModel.castList.count > 0, indexPath.item < viewModel.castList.count {
            let cast = viewModel.castList[indexPath.item]
            cell.setWith(cast: cast)
        }
        
        return cell
    }
    
    
}
