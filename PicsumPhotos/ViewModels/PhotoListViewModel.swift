//
//  PhotoListViewModel.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import Foundation

class PhotoListViewModel {
    private var photos: [Photo] = []
    /// Current page for pagination.
    private var currentPage = 1
    /// Number of items to fetch per page.
    private let limit = 20
    private var isFetching = false
    /// Dictionary to keep track of checkbox states by photo ID.
    private var checkboxStates: [String: Bool] = [:]
    
    var photosDidUpdate: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    /// Returns the photo at the specified index.
    ///
    /// - Parameter index: The index of the photo.
    /// - Returns: The photo at the specified index, or nil if the index is out of bounds.
    func photo(at index: Int) -> Photo? {
        guard index >= 0 && index < photos.count else {
            return nil
        }
        return photos[index]
    }
    
    /// Checks if the checkbox is selected for a given photo ID.
    ///
    /// - Parameter photoId: The ID of the photo.
    /// - Returns: True if the checkbox is selected, false otherwise.
    func isCheckboxSelected(for photoId: String) -> Bool {
        return checkboxStates[photoId] ?? false
    }
    
    /// Sets the checkbox state for a given photo ID.
    ///
    /// - Parameters:
    ///   - photoId: The ID of the photo.
    ///   - isSelected: The checkbox state to set.
    func setCheckboxState(for photoId: String, isSelected: Bool) {
        checkboxStates[photoId] = isSelected
    }
    
    /// Fetches photos from the network.
    func fetchPhotos() {
        guard !isFetching else { return }
        isFetching = true
        
        NetworkManager.shared.fetchPhotos(page: currentPage, limit: limit) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let photos):
                self.photos.append(contentsOf: photos)
                self.photosDidUpdate?()
                self.currentPage += 1
            case .failure(let error):
                self.errorHandler?(error)
            }
        }
    }
    
    /// Refreshes the photo list by resetting the state and fetching the first page of photos.
    func refreshPhotos() {
        currentPage = 1
        photos.removeAll()
        checkboxStates.removeAll()
        fetchPhotos()
    }
}
