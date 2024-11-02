//
//  CollectionViewCell.swift
//  RickAndMortyYAP
//
//  Created by Рахим Габибли on 01.08.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let charImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    let speciesAndGenderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let originNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 200/255, green: 255/255, blue: 184/255, alpha: 1)
        label.textColor = .brown
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let watchEpisodesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Watch episodes", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 229/255, alpha: 1)
        return button
    }()

    override func prepareForReuse() {
        charImage.image = nil
        nameLabel.text = nil
        speciesAndGenderLabel.text = nil
        originNameLabel.text = nil
        statusLabel.text = nil

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()

        charImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(90)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(charImage.snp.trailing).inset(-25)
            make.trailing.equalToSuperview().inset(100)
            make.top.equalTo(charImage)
        }

        speciesAndGenderLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
        }

        watchEpisodesButton.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(speciesAndGenderLabel.snp.bottom).inset(-5)
            make.width.equalTo(160)
        }

        originNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(watchEpisodesButton.snp.bottom).inset(-10)
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(70)
            make.height.equalTo(25)
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupCell() {
        contentView.addSubview(charImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(speciesAndGenderLabel)
        contentView.addSubview(originNameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(watchEpisodesButton)
    }
    // swiftlint:disable:next function_parameter_count
    func configure(imageData: Data, name: String, species: String, gender: String, origin: String, status: String) {
        nameLabel.text = name
        charImage.image = UIImage(data: imageData)
        speciesAndGenderLabel.text = "\(species), \(gender)"
        originNameLabel.text = origin
        statusLabel.text = " \(status) "
    }
}
