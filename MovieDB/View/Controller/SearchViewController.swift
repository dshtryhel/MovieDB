//
//  SearchViewController.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 21.01.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchViewController: UIViewController {

    // MARK: - private properties
    
    @IBOutlet private weak var movieOrTVSerieCollectionView: UICollectionView!
    
    private var viewModel = SearchViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBar: UISearchBar { searchController.searchBar }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Configure CollectionView
        configureMovieOrTVSerieCollectionView()

        // MARK: - Configure configureSearchBar
        configureSearchBar()
        setSearchBarAtTheTop()
        
        // MARK: - Subcribing of Movie Response
        subscribeMovieResponse()
        
        // MARK: - Subscribing of TV Serie Response
        subscribeTVSerieResponse()
        
        // MARK: - Searching with debounce
        self.searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(600), scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] text in
                self?.scrollToTop()
                guard let strongSelf = self else { return }
                
                strongSelf.viewModel.searchItemDidChange(index: strongSelf.searchBar.selectedScopeButtonIndex,
                                                     text: text)
        }).disposed(by: viewModel.disposeBag)
        
    }
    
    // MARK: - Configure MovieOrTVSerie CollectionView
    func configureMovieOrTVSerieCollectionView() {
        movieOrTVSerieCollectionView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        movieOrTVSerieCollectionView.rx.setDataSource(self).disposed(by: viewModel.disposeBag)
    }
    
    // MARK: - Subscribtion of Movie Response
    func subscribeMovieResponse() {
        viewModel.movieResponse.asObservable().subscribe(onNext: { [weak self]
            (movieResponse) in
            guard let strongSelf = self else { return }
            
            strongSelf.movieOrTVSerieCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        }).disposed(by: viewModel.disposeBag)
    }
    
    // MARK: - Subscription of TV Serie Response
    func subscribeTVSerieResponse() {
        viewModel.tvSerieResponse.asObservable().subscribe(onNext: { [weak self]
            (tvSerieResponse) in
            guard let strongSelf = self else { return }
            
            strongSelf.movieOrTVSerieCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        }).disposed(by: viewModel.disposeBag)
    }
    
    // MARK: - Configure SearchBar
    func configureSearchBar() {
        
        searchBar.delegate = self
        searchBar.scopeButtonTitles = ["Movies", "TV Series"]
        searchBar.showsScopeBar = true
        searchBar.placeholder = "Search any movies or tv series"
    }
    
    // MARK: - Scroll to top
    func scrollToTop() {
        self.movieOrTVSerieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                       at: .top, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueItemDetailVC" {
            let itemDetailVC = segue.destination as! MovieOrTVSerieDetailViewController
            
            switch viewModel.listType {
                  case "Movies": let movie = sender as! MovieResult
                  itemDetailVC.viewModel.movie.onNext(movie)
                  case "TV Series": let tvSerie = sender as! TVSerieResult
                  itemDetailVC.viewModel.tvSerie.onNext(tvSerie)
            default: break
            }
        }
    }
    
    func setSearchBarAtTheTop() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
    }
}

// MARK: - UICollectionViewDataSource Extension
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieOrTVSerieCellID", for: indexPath) as? MovieOrTVSerieCollectionViewCell else {
            return UICollectionViewCell()
        }

        switch viewModel.listType {
        case "Movies":
            if viewModel.movieList.count > indexPath.item {
                cell.setMovie(movie: viewModel.movieList[indexPath.item])
            }
        case "TV Series":
            if viewModel.tvSerieList.count > indexPath.item {
                cell.setTVSerie(tvSerie: viewModel.tvSerieList[indexPath.item])
            }
        default: break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = viewModel.itemCount - 1

        if indexPath.item == lastItem {
            viewModel.loadNextPage()
        }
    }
    
}

// MARK: - UICollectionViewDelegate Extension
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch viewModel.listType {
        case "Movies":
            if viewModel.movieList.count > indexPath.item {
                let movie = viewModel.movieList[indexPath.item]
                self.performSegue(withIdentifier: "SegueItemDetailVC",
                                  sender: movie)
            }
        case "TV Series":
            if viewModel.tvSerieList.count > indexPath.item {
                let tvSerie = viewModel.tvSerieList[indexPath.item]
                self.performSegue(withIdentifier: "SegueItemDetailVC",
                                  sender: tvSerie)
            }
        default: break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let cellWidth: CGFloat = screenWidth / 2
        let cellHeight: CGFloat = cellWidth * ApplicationVariables.imageAspectRatio
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

// MARK: - UISearchBarDelegate Extension
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        scrollToTop()
        viewModel.searchItemDidChange(index: searchBar.selectedScopeButtonIndex, text: searchBar.text)
    }
}
