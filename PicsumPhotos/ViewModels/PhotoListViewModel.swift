//
//  PhotoListViewModel.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import Foundation

class PhotoListViewModel {
    private var photos: [Photo] = []
    private var currentPage = 1
    private let limit = 20
    private var isFetching = false
    private var checkboxStates: [String: Bool] = [:]
    
    var photosDidUpdate: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    func photo(at index: Int) -> Photo? {
        guard index >= 0 && index < photos.count else {
            return nil
        }
        return photos[index]
    }
    
    func isCheckboxSelected(for photoId: String) -> Bool {
        return checkboxStates[photoId] ?? false
    }
    
    func setCheckboxState(for photoId: String, isSelected: Bool) {
        checkboxStates[photoId] = isSelected
    }
    
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
    
    func refreshPhotos() {
        currentPage = 1
        photos.removeAll()
        checkboxStates.removeAll()
        fetchPhotos()
    }
}
