//
//  HomeViewController.swift
//  project
//
//  Created by tranthanh on 4/17/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import ImageSlideshow
import GoogleMobileAds

class HomeViewController: UIViewController , GADInterstitialDelegate {
    
     class func newVC() -> HomeViewController {
          let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
          return storyBoard.instantiateViewController(withIdentifier: HomeViewController.className) as! HomeViewController
    }

    @IBOutlet weak var heightNewVideo: NSLayoutConstraint!
    @IBOutlet weak var heightChart: NSLayoutConstraint!
    @IBOutlet weak var heightArtist: NSLayoutConstraint!
    @IBOutlet weak var heightGenres: NSLayoutConstraint!
    var list_banners: [Video] = [Video]()
    var list_new_releases : [Video] = [Video]()
    var list_charts: [Video] = [Video]()
    var list_artists: [Video] = [Video]()
    var list_genres: [Video] = [Video]()
    var listSongs : [Song] = [Song]()
    
    @IBOutlet weak var newVideoCollectionView: UICollectionView!
    @IBOutlet weak var bieuDoCVC: UICollectionView!
    @IBOutlet weak var artistCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var tableViewSongs: UITableView!
    @IBOutlet weak var slideShowImageView: ImageSlideshow!

    @IBOutlet weak var height_list_artists: NSLayoutConstraint!
    @IBOutlet weak var height_list_genres: NSLayoutConstraint!
    
     let HEIGHT_CELL: CGFloat = 80
    
    func updateUI(){
        height_list_genres.constant = CGFloat(list_genres.count / 2) * HEIGHT_CELL + 50
    }
    
    @IBAction func morePhienBanMoiButton(_ sender: Any) {
        let moreNewVideo = MoreNewVideoViewController.newVC()
        self.navigationController?.pushViewController(moreNewVideo, animated: true)
    }
    
    
    @IBAction func moreBieuDoButton(_ sender: Any) {
         let bieudo = MoreChartVC.newVC()
          self.navigationController?.pushViewController(bieudo, animated: true)
        
    }
    
    
    @IBAction func moreNgheSiButton(_ sender: Any) {
        let moreNgheSi = MoreArtistVC.newVC()
        self.navigationController?.pushViewController(moreNgheSi, animated: true)
    }
    
    @IBAction func moreTheloai(_ sender: Any) {
        let moreCategory = MoreGenresVC.newVC()
        self.navigationController?.pushViewController(moreCategory, animated: true)
    }
   
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initSlideShow()
        initCollectionView()
        currentVc = self

    }
    
    var isFirstLoad = true
      
      override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          if isFirstLoad {
            let theWidth = (screenWidth - (30))/3   // it will generate 2 column
              if let newVideoCollectionView = newVideoCollectionView.collectionViewLayout  as? UICollectionViewFlowLayout {
            
                 newVideoCollectionView.itemSize.width = theWidth
                 newVideoCollectionView.itemSize.height = theWidth + 20
                 newVideoCollectionView.invalidateLayout()
                 self.heightNewVideo.constant = theWidth + 20
              }
              
              if let bieuDoCVC = bieuDoCVC.collectionViewLayout as? UICollectionViewFlowLayout {
                    bieuDoCVC.itemSize.width = theWidth
                        bieuDoCVC.itemSize.height = theWidth + 20
                        bieuDoCVC.invalidateLayout()
                       self.heightChart.constant = theWidth + 20
              }
              
              if let artistCollectionView = artistCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                     artistCollectionView.itemSize.width = theWidth
                     artistCollectionView.itemSize.height = theWidth + 20
                     artistCollectionView.invalidateLayout()
                 self.heightArtist.constant = (theWidth + 20 + 5) * 2
              }
              
              if let categoryCollectionView = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                categoryCollectionView.itemSize.width = theWidth
                categoryCollectionView.itemSize.height = theWidth + 20
                categoryCollectionView.invalidateLayout()
                 self.heightGenres.constant = (theWidth + 20 + 5) * 3
              }
              
        
              getDataSever()
              isFirstLoad = false
          }
      }

    @IBOutlet weak var heightTableSong: NSLayoutConstraint!
    
    func getDataSever(){
        HomeDataStore.share.getListHome( responses: { [weak self] productHome in
              if let self = self , let productHome = productHome  {
                          self.list_banners = productHome.list_banners
                          self.list_new_releases = productHome.list_new
                          self.list_charts = productHome.list_charts
                          self.list_artists = productHome.list_artists
                          self.list_genres = productHome.list_genres
                          
                          DispatchQueue.main.async {
                             self.setSlideShowSource()
                             self.newVideoCollectionView.reloadData()
                             self.bieuDoCVC.reloadData()
                             self.artistCollectionView.reloadData()
                             self.categoryCollectionView.reloadData()
                          }
                          
                      }
        }) { (error) in
            DispatchQueue.main.async {
                self.showAlertNormal(title: "[Thông báo về việc bảo trì GRAFTV]", message: "GRAFTV đang trong quá trình chuẩn bị để có thể cung cấp dịch vụ âm nhạc trên toàn cầu.Hiện tại, Server của chúng tôi đang tạm thời bị quá tải do nhận được sự truy cập quá lớn từ tất cả các quốc gia châu Á mà dịch vụ hiện đang cung cấp.Chúng tôi đang tiến hành bảo trì hệ thống để khắc phục. Dịch vụ sẽ được bình thường hóa sau ít phút, mong mọi người có thể chờ đợi trong giây lát.Thay vào đó, chúng tôi sẽ cố gắng hết sức để có thể cung cấp cho mọi người những dịch vụ tốt hơn với nhiều bài hát và video hay với chất lượng cao.Nếu bạn có bất kì thắc mắc gì, vui lòng liên hệ với chúng tôi qua email dưới đây.Hỗ trợ : grafsound@kmscom.com")
            }
            
        }
      
    }

    func initSlideShow(){
        slideShowImageView.slideshowInterval = 5.0
        slideShowImageView.contentScaleMode = UIView.ContentMode.scaleAspectFill
        slideShowImageView.pageIndicatorPosition = PageIndicatorPosition(horizontal: .right(padding: 20), vertical: .bottom)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBanner))
        slideShowImageView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func didTapBanner(){
        if list_banners.count > 0 {
            var banner =  list_banners[slideShowImageView.currentPage]
            banner.isBanner = true
            onClickItem(item: banner)
        }
         
    }
    func setSlideShowSource(){
        var inputs = [InputSource]()
        for item in self.list_banners{
            inputs.append(SDWebImageSource(urlString: item.img_banner)!)
        }
        self.slideShowImageView.setImageInputs(inputs)
    }
    
    func initCollectionView(){
        // Category CollectionView
        newVideoCollectionView.delegate = self
        newVideoCollectionView.dataSource = self
        newVideoCollectionView.register(UINib(nibName: CellPhienBanMoi.className, bundle: nil), forCellWithReuseIdentifier: CellPhienBanMoi.className)
        
        bieuDoCVC.delegate = self
        bieuDoCVC.dataSource = self
        bieuDoCVC.register(UINib(nibName: CellBieuDo.className, bundle: nil), forCellWithReuseIdentifier: CellBieuDo.className)
        
        artistCollectionView.delegate = self
        artistCollectionView.dataSource = self
        artistCollectionView.register(UINib(nibName: CellBieuDo.className, bundle: nil), forCellWithReuseIdentifier: CellBieuDo.className)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: CellCategory.className, bundle: nil), forCellWithReuseIdentifier: CellCategory.className)
    }
    
    
    

}

extension HomeViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case newVideoCollectionView:
            return list_new_releases.count
        case bieuDoCVC :
            return list_charts.count
        case artistCollectionView :
            return list_artists.count
        default:
            return list_genres.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case newVideoCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellPhienBanMoi.className, for: indexPath) as! CellPhienBanMoi
             let item = list_new_releases[indexPath.row]
            cell.bind(item: item,index: indexPath.row)
             cell.delegate = self
            return cell
        case bieuDoCVC:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellBieuDo.className, for: indexPath) as! CellBieuDo
            let item = list_charts[indexPath.row]
            cell.bind(item : item)
            return cell
        case artistCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellBieuDo.className, for: indexPath) as! CellBieuDo
            let item = list_artists[indexPath.row]
            cell.bind(item : item)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellCategory.className, for: indexPath) as! CellCategory
            let item = list_genres[indexPath.row]
            cell.bind(item : item)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView)
        switch collectionView {
        case newVideoCollectionView:
             break
        case bieuDoCVC:
//            admobDelegate.showAd()
            var item = list_charts[indexPath.row]
            let detailBanner = BannerDetailViewController.newVC()
            item.isBanner = true
            detailBanner.item = item
           
            self.navigationController?.pushViewController(detailBanner, animated: true)
            case artistCollectionView:
//             admobDelegate.showAd()
             var item = list_artists[indexPath.row]
             let detailArtist = GenresDetailVC.newVC()
             item.isArtist = true
             detailArtist.item = item
             self.navigationController?.pushViewController(detailArtist, animated: true)
        default:
//             admobDelegate.showAd()
             var item = list_genres[indexPath.row]
             item.isArtist = false
             let detailCategory = GenresDetailVC.newVC()
             detailCategory.item = item
             self.navigationController?.pushViewController(detailCategory, animated: true)
        }
    }
}



extension HomeViewController : OnClickItemPlaylist {
    func onClickItem(item: Video) {
         let detailBanner = BannerDetailViewController.newVC()
        detailBanner.item = item
        self.navigationController?.pushViewController(detailBanner, animated: true)
    }


}

extension HomeViewController : ItemVideoListener {
    
    func onItemVideoClicked(index: Int) {
        UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: list_new_releases[index], playlistitems:  list_new_releases)
     }
     func onMenuOption(index: Int) {
        
    }
}
