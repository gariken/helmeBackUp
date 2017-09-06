//
//  helpViewController.swift
//  helpMe
//
//  Created by Александр on 26.04.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation

class helpViewController: UIViewController, SlideButtonDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var cancelView: UIView!
    
    @IBOutlet weak var helpButton: SlideButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    let phoneNumber  = PhoneNumberManager()
    
    @IBAction func callButton(_ sender: Any) {
        phoneNumber.phoneInsert(phone: "+79898197957")
    }
    
    
    var blackMaskView = UIView(frame: CGRect.zero)
    
    let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "slideMenu")
    
    var menuLeftConstraint: NSLayoutConstraint?
    
    var isShowingMenu = true
    
    let locationManager = CLLocationManager()
    
    @IBAction func slideMenuButton(_ sender: Any) {
        toogleMenu()
    }
    
    var messagesCount = 0
    
    //MARK: -Timer
    
    var timer : Timer!
    var countTimer = 299

    
    func updateTime(){
        if(countTimer > 0){
            let minutes = String(countTimer / 60)
            let seconds = String(countTimer % 60)
            countTimer = countTimer - 1
            self.timerLabel.text = minutes + " : " + seconds
        }
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(helpViewController.updateTime), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func stopTime(){
        timer.invalidate()
        timerLabel.isHidden = true
        self.countTimer = 299
    }
    
    
    /* MARK: HelpMe */
    
    func help(lat:String?, lap:String?){
            let ref = Database.database().reference()
            
            let dict: NSDictionary = ["Message": "1111", "UDID":"12345", "lat":lat!, "lap":lap!] as NSDictionary
            
            ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let array = snapshot.value as? NSArray
                ref.child("users").child("\((array?.count)!)").setValue(dict)
            }) { (error) in
                print(error.localizedDescription)
            }
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // geoPostion()
        
        self.timerLabel.isHidden = true
        
        constraintsMenu()
        
        self.helpButton.delegate = self
        
        self.bottomView.frame = CGRect (x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.bottomView.frame.size.height)
    }
    
    //MARK: - Animation
    
    func showBottomView() {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        self.bottomView.frame = CGRect (x: 0, y: self.view.frame.size.height - self.bottomView.frame.size.height, width: self.view.frame.size.width, height: self.bottomView.frame.size.height)
                        
        }, completion: { (finished) -> Void in
            self.geoPostion()
            self.startTimer()
        })
    }
    
    func hideBottomView() {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        self.bottomView.frame = CGRect (x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.bottomView.frame.size.height)
                        
        }, completion: { (finished) -> Void in
           self.stopTime()
        })
    }
    
    
    func animate(){
        
    }
    
    //MARK: - SlideButtonDelegate
    
    func sliderDidSlide() {
        if self.helpButton.lockAction {
            self.showBottomView()
            self.timerLabel.isHidden = false
            self.cancelView.isHidden = false
            self.cancelButton.isHidden = false
        }
        else {
            self.hideBottomView()
            self.cancelView.isHidden = true
            self.cancelButton.isHidden = true
            self.timerLabel.isHidden = true
        }
    }
    
  //MARK: - IBAction
    

    @IBAction func cancelButton(_ sender: Any) {
        hideBottomView()
        stopTime()
    }

    func geoPostion(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    /////UPDATEDATA
    func updateData(long:String, lap:String){
        var ref : DatabaseReference!
        ref = Database.database().reference()
        ref.child("geo/long").setValue(long)
        ref.child("geo/lap").setValue(lap)
    }

    
    //MARK: -coreLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let user_lat = String(format: "%f", (manager.location?.coordinate.latitude)!)
        let user_lap = String(format: "%f", (manager.location?.coordinate.longitude)!)
        let user_speed = String(format: "%f", (manager.location?.speed)!)
        let user_put = String(format: "%f", (manager.location?.altitude)!)
        
        
        help(lat: user_lap, lap: user_lat)
        
        print("Широта - \(user_lat)")
        print("Долгота - \(user_lap)")
        print("Скорость - \(user_speed)")
        print("путь   - \(user_put)")
        manager.stopUpdatingLocation()
    }

    
    
    
    
    
    
    
    
    /**** slideMenu ***/
    
    func constraintsMenu(){
        addChildViewController(menuViewController)
        menuViewController.didMove(toParentViewController: self)
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuViewController.view)
        
        let topConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        
        let widthConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 219)
        
        menuLeftConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: -widthConstraint.constant)
        
        view.addConstraints([topConstraint, menuLeftConstraint!, bottomConstraint, widthConstraint])
    }
    
    func toogleMenu() {
        isShowingMenu = !isShowingMenu
        
        if(isShowingMenu) {
            //Hide Menu
            
            UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.slide)
            
            menuLeftConstraint?.constant = -menuViewController.view.bounds.size.width
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.view.layoutIfNeeded()
            }, completion: { (completed) -> Void in
                self.menuViewController.view.isHidden = true
            })
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.view.layoutIfNeeded()
                self.blackMaskView.alpha = 0.0
            }, completion: { (completed) -> Void in
                self.blackMaskView.removeFromSuperview()
            })
            
        } else {
            //Present Menu
            
            UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.slide)
            
            blackMaskView = UIView(frame: CGRect.zero)
            blackMaskView.alpha = 0.0
            blackMaskView.translatesAutoresizingMaskIntoConstraints = false
            blackMaskView.backgroundColor = UIColor.black
            view.insertSubview(blackMaskView, belowSubview: menuViewController.view)
            
            let topConstraint = NSLayoutConstraint(item: blackMaskView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
            
            let bottomConstraint = NSLayoutConstraint(item: blackMaskView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            
            let leftConstraint = NSLayoutConstraint(item: blackMaskView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            
            let rightConstraint = NSLayoutConstraint(item: blackMaskView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            
            view.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
            view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.view.layoutIfNeeded()
                self.blackMaskView.alpha = 0.5
            }, completion: { (completed) -> Void in
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(helpViewController.tapGestureRecognized))
                self.blackMaskView.addGestureRecognizer(tapGesture)
            })
            
            menuViewController.view.isHidden = false
            menuLeftConstraint?.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.view.layoutIfNeeded()
            }, completion: { (completed) -> Void in
                
            })
        }
    }
    
    func tapGestureRecognized() {
        toogleMenu()
    }
    
    func menuCloseButtonTapped() {
        toogleMenu()
    }
    
    /******************/

}

