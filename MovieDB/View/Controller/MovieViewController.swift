//
//  ViewController.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import UIKit

final class MovieViewController: UIViewController {
    
    @IBOutlet private weak var topRatedMovieCollectionView: UICollectionView!
    @IBOutlet private weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet private weak var popularMovieCollectionView: UICollectionView!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var topRatedMovieSpinner: UIActivityIndicatorView!
    @IBOutlet private weak var nowPlayingMovieSpinner: UIActivityIndicatorView!
    @IBOutlet private weak var popularMovieSpinner: UIActivityIndicatorView!
    
    let viewModel = MovieViewModel()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: CollectionViews Configirations
        configureTopRatedMovieCollectionView()
        configureNowPlayingMovieCollectionView()
        configurePopularMovieCollectionView()
        
        
        // MARK: Subscribing to Top Rated Movie Response
        subscribeTopRatedMovieResponse()
        
        // MARK: Fetching Top Rated Movies
        viewModel.fetchTopRatedMovieList()
        
        // MARK: Subscribing to Now Playing Movie Response
        subscribeNowPlayingMovieResponse()

        // MARK: Fetching Now Playing Movies
        viewModel.fetchNowPlayingMovieList()

        // MARK: Subscribing to Popular Movie Response
        subscribePopularMovieResponse()

        // MARK: Fetching Popular Movies
        viewModel.fetchPopularMovieList()

        //MARK: Fetching Genres
        viewModel.fetchMovieGenreList()
    }
    
    // MARK: Subscription of Popular Movie Service Response
    func subscribePopularMovieResponse() {
        
        viewModel.popularMovieResponse.subscribe(onNext: { [weak self] (nowPlayingMovieResponse) in
            self?.popularMovieSpinner.stopAnimating()
            self?.popularMovieCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Subscription of Now Playing Movie Service Response
    func subscribeNowPlayingMovieResponse() {
        
        viewModel.nowPlayingMovieResponse.subscribe(onNext: { [weak self] (nowPlayingMovieResponse) in
            self?.nowPlayingMovieSpinner.stopAnimating()
            self?.nowPlayingCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Subscription of Top Rated Movie Service Response
    func subscribeTopRatedMovieResponse() {
        
        viewModel.topRatedMovieResponse.subscribe(onNext: { [weak self] (topRatedMovieResponse) in
            self?.topRatedMovieSpinner.stopAnimating()
            self?.topRatedMovieCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: configureTopRatedMovieCollectionView
    func configureTopRatedMovieCollectionView() {
        topRatedMovieCollectionView.register(UINib(nibName: "TopRatedMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedMovieCellID")
        topRatedMovieCollectionView.delegate = self
        topRatedMovieCollectionView.dataSource = self
    }
    
    // MARK: nowPlayingCollectionView
    func configureNowPlayingMovieCollectionView() {
        nowPlayingCollectionView.register(UINib(nibName: "NowPlayingMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingMovieCellID")
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
    }
    
    // MARK: configurePopularMovieCollectionView
    func configurePopularMovieCollectionView() {
        popularMovieCollectionView.register(UINib(nibName: "PopularMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularMovieMovieCellID")
        popularMovieCollectionView.delegate = self
        popularMovieCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueMovieDetailVC" {
            let movieDetailVC = segue.destination as! MovieOrTVSerieDetailViewController
            let movie = sender as! MovieResult
            movieDetailVC.viewModel.movie.onNext(movie)
        }
    }
}

// MARK: UICollectionViewDataSource Extension
extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topRatedMovieCollectionView:
            return viewModel.topRatedMovieList.count
        case nowPlayingCollectionView:
            return viewModel.nowPlayingMovieList.count
        case popularMovieCollectionView:
            return viewModel.popularMovieList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case topRatedMovieCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedMovieCellID", for: indexPath) as! TopRatedMovieCollectionViewCell
            
            let topRatedMovie = viewModel.topRatedMovieList[indexPath.item]
            
            cell.setWith(topRatedMovie: topRatedMovie)
            return cell
        case nowPlayingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieCellID", for: indexPath) as! NowPlayingMovieCollectionViewCell
            
            let nowPlayingMovie = viewModel.nowPlayingMovieList[indexPath.item]
            
            cell.setWith(nowPlayingMovie: nowPlayingMovie)
            return cell
        case popularMovieCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieMovieCellID", for: indexPath) as! PopularMovieCollectionViewCell
            
            let popularMovie = viewModel.popularMovieList[indexPath.item]
            
            cell.setWith(popularMovie: popularMovie)
            return cell
            
        default:
            break
        }
        
        return UICollectionViewCell()
    }
}

// MARK: UICollectionViewDelegate Extension
extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case topRatedMovieCollectionView:
            let movie = viewModel.topRatedMovieList[indexPath.item]
            self.performSegue(withIdentifier: "SegueMovieDetailVC", sender: movie)
        case nowPlayingCollectionView:
            let movie = viewModel.nowPlayingMovieList[indexPath.item]
            self.performSegue(withIdentifier: "SegueMovieDetailVC", sender: movie)
        case popularMovieCollectionView:
            let movie = viewModel.popularMovieList[indexPath.item]
            self.performSegue(withIdentifier: "SegueMovieDetailVC", sender: movie)
        default:
            break
        }
      
    }
}

