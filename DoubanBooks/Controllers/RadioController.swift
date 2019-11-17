//
//  RadioController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/15.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit
import AVFoundation
import AlamofireImage
import Alamofire
var player:AVPlayer?
class RadioController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgHost: UIImageView!
    @IBOutlet weak var lblHost: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblPast: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if player == nil {
            player = AVPlayer()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgHost.layer.cornerRadius = imgHost.frame.width / 2
        imgHost.clipsToBounds = true
        initPlay()
        // Do any additional setup after loading the view.
    }
    @IBAction func play(_ sender: UIButton) {
        if player!.rate == 0 {
            player!.play()
            sender.setImage(UIImage(named: "zanting"), for: .normal)
        } else {
            player!.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    @IBAction func dragSlider(_ sender: UISlider) {
        let seconds = Int64(slider.value)
        let targetTime = CMTimeMake(value: seconds, timescale: 1)
        player!.seek(to: targetTime)
        if player!.rate == 0 {
            player!.play()
            btnPlay.setImage(UIImage(named: "zanting"), for: .normal)
        }
    }
    
    
    fileprivate func displayAlbumInfo() {
        lblTitle.text = "123"
        lblHost.text = "456"
        Alamofire.request("456").responseImage{ response in
            if let imag = response.result.value {
                self.imgHost.image = imag
            }
        }
        Alamofire.request("book.image!").responseImage{ response in
            if let imag = response.result.value {
                self.imgCover.image = imag
            }
        }
    }
    
    func initPlay() {
        displayAlbumInfo()
        let playItem = AVPlayerItem(url: URL(string: "akfkl;ea")!)
        player!.replaceCurrentItem(with: playItem)
        player!.volume = 1
        let duration = playItem.asset.duration
        let seconds = CMTimeGetSeconds(duration)
        slider.minimumValue = 0
        slider.isEnabled = true
        slider.maximumValue = Float(seconds)
        lblTotal.text = getLegaMinutes(seconds: Float(seconds))
        slider.isContinuous = false
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1,preferredTimescale:  1), queue: DispatchQueue.main, using:
            {_ in
                if player!.currentItem?.status == .readyToPlay {
                    let currentTime = CMTimeGetSeconds(player!.currentTime())
                    self.slider.value = Float(currentTime)
                    self.lblPast.text = self.getLegaMinutes(seconds: Float(currentTime))
                }
        } )
    }

    
    func  getLegaMinutes(seconds:Float) -> String {
        var time = ""
        
        return time
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
