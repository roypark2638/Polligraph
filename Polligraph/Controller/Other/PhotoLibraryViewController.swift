//
//  PhotoLibraryViewController.swift
//  Polligraph
//
//  Created by Roy Park on 4/27/21.
//

import UIKit
import Photos

class PhotoLibraryViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    private var data = Data()
    
    private var assets = [PHAsset]()
    private var images = [UIImage?]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        configureCollectionView()
        checkLibraryPermission()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func checkLibraryPermission() {
        
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            getImages()
        }
        else {
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized, .limited:
                    DispatchQueue.main.async {
                        self.getImages()
                    }
                case .notDetermined, .restricted, .denied:
                    return
                @unknown default:
                    return
                }
            }
        }
    }
    
    private func getImages() {
        let assets = PHAsset.fetchAssets(
            with: PHAssetMediaType.image,
            options: nil
        )
        
        assets.enumerateObjects { object, count, stop in
            self.assets.append(object)
        }
        // In order to get latest image first, reverse the array
        self.assets.reverse()
        
        // To show photos, I have taken a UICollectionView
        self.collectionView?.reloadData()
        
    }
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        
        collectionView.allowsSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }


}

extension PhotoLibraryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,  numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath
        ) as? PhotoCollectionViewCell else {
            fatalError()
        }
        
        
        let asset = assets[indexPath.row]
        let manager = PHImageManager.default()
        
        if cell.tag != 0 {
            manager.cancelImageRequest(PHImageRequestID(cell.tag))
        }
        
        cell.tag = Int(manager.requestImage(
                        for: asset,
                        targetSize: CGSize(width: 120, height: 120),
                        contentMode: .aspectFill,
                        options: nil,
                        resultHandler: { result, _ in
                            cell.imageView.image = result
                            self.images.append(result)
                        }))
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.allowsSelection = true
        
        
        guard let image = images[indexPath.row],
              let data = image.pngData()
              else { return }
        self.data = data
        
        
        if let cell = collectionView.cellForItem(at: indexPath) {
//            let view = UIView()
//            view.backgroundColor = .gray
//            view.alpha = 0.5
//            cell.addSubview(view)
            
                        let image = UIImageView(image: UIImage(named: "SelectionBackground"))
                        image.alpha = 0.5
                        cell.addSubview(image)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.allowsSelection = true
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            let view = UIView()
            
//            let view = UIView()
//            view.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
//            cell.addSubview(view)
//            cell.contentView.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
//            cell.contentView.backgroundColor = UIColor(red: 190, green: 190, blue: 190, alpha: 0.05)
//            let image = UIImageView(image: UIImage(named: "SelectionBackground"))
//            image.alpha = 0.5
//            cell.addSubview(image)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            cell.contentView.backgroundColor = nil
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.width * 0.32
        let height = view.height * 0.179910045
        print("width and height \n:\n")
        print(width)
        print(height)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension PhotoLibraryViewController: SelectPictureViewControllerDelegate {
    func selectPictureViewControllerDidTapUpload(_ controller: SelectPictureViewController) {
        guard let username = UserDefaults.standard.string(forKey: "username") else { return }
    
        StorageManager.shared.uploadProfilePicture(
            username: username,
            data: data) { result in
            switch result {
            // doing this on the background because fetchProfileInfo is on the main thread.
            case .success(let imageStringURL):
                UserDefaults.standard.set(imageStringURL, forKey: "profile_picture_url")
                print(imageStringURL)
            case .failure(let error):
                print("failed to upload the profile picture to the firebase storage ")
                print("StorageManager error: \(error)")
            }
        }
    }
    
}
