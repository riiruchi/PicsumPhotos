//
//  PhotoTableViewCell.swift
//  PicsumPhotos
//
//  Created by Ruchira  on 30/06/24.
//

import UIKit
import SDWebImage

/// Custom UITableViewCell to display a photo with its details and a checkbox.
class PhotoTableViewCell: UITableViewCell {
    
    /// Reuse identifier for the cell.
    static let identifier = "PhotoTableViewCell"
    
    /// ImageView to display the photo.
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    /// Label to display the title (author name).
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0  // Support multi-line text
        return label
    }()
    
    /// Label to display the description (URL).
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0  // Support multi-line text
        return label
    }()
    
    /// Button to act as a checkbox.
    private let checkbox: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("☐", for: .normal)
        button.setTitle("☑", for: .selected)
        return button
    }()
    
    /// Property wrapper to manage the checkbox state.
    @CheckboxState var isCheckboxChecked: Bool = false
    
    var checkboxAction: ((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        checkbox.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(checkbox)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: checkbox.leadingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: checkbox.leadingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            checkbox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            checkbox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            checkbox.widthAnchor.constraint(equalToConstant: 30),
            checkbox.heightAnchor.constraint(equalToConstant: 30),
            checkbox.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func toggleCheckbox() {
        isCheckboxChecked.toggle()
        checkbox.isSelected = isCheckboxChecked
        checkboxAction?(isCheckboxChecked)
    }
    
    /// Configures the cell with the given photo and checkbox state.
    ///
    /// - Parameters:
    ///   - photo: The photo to display.
    ///   - isSelected: The initial checkbox state.
    func configure(with photo: Photo, isSelected: Bool) {
        titleLabel.text = photo.author
        descriptionLabel.text = photo.url
        isCheckboxChecked = isSelected
        checkbox.isSelected = isCheckboxChecked
        // Use SDWebImage to load the image
        photoImageView.sd_setImage(with: URL(string: photo.downloadURL), placeholderImage: nil, options: .highPriority, completed: nil)
    }
}
