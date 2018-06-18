//
//  MapVC.swift
//  Demo
//
//  Created by Admin on 21.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    var pointArray:[DistributionPoint] = []
    var etalonTerminal: Terminal?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAdress: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var heightForTableView:CGFloat = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageControl.numberOfPages = 0
        if etalonTerminal == nil {
            let localSearchRequest = MKLocalSearchRequest()
            localSearchRequest.naturalLanguageQuery = "Россия Томск"
            let localSearch = MKLocalSearch(request: localSearchRequest)
            localSearch.start { (localSearchResponse, error) -> Void in
                
                guard let response = localSearchResponse else { return }
                let coordinate = CLLocationCoordinate2D(latitude: response.boundingRegion.center.latitude, longitude: response.boundingRegion.center.longitude)
                self.mapView.centerCoordinate = coordinate
                let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
                self.mapView.setRegion(region, animated: true)
            }
            mapView.showsUserLocation = true
            requestLocationAccess()
            
            for i in 1...4 {
                let localSearchRequest = MKLocalSearchRequest()
                localSearchRequest.naturalLanguageQuery = "Россия Томск Ленина " + String(i * 10)
                let localSearch = MKLocalSearch(request: localSearchRequest)
                localSearch.start { (localSearchResponse, error) -> Void in
                    guard let response = localSearchResponse else { return }
                    let pointAnnotation = MKPointAnnotation()
                    pointAnnotation.title = ""
                    pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: response.boundingRegion.center.latitude, longitude: response.boundingRegion.center.longitude)
                   
                    self.pointArray.append(DistributionPoint(vendorName: "Ювелирные украшения", city: "Томск", streetName: "Ленина", streetNumber: String(i * 10), location: pointAnnotation.coordinate))
                    
                    self.mapView.addAnnotation(pointAnnotation)
                    
                    self.pageControl.numberOfPages = self.pointArray.count
                    self.pageControl.currentPage = 0
                    self.labelName.text = self.pointArray[self.pageControl.currentPage].vendorName
                    self.labelAdress.text = self.pointArray[self.pageControl.currentPage].streetName + ", " + self.pointArray[self.pageControl.currentPage].streetNumber
                    self.labelTime.text = "10:00 - 18:00"//pointArray[pageControl.currentPage + 1].vendorName
                }
            }
            
            /*
            MeAPI.getMe { (response, error) in
                guard let response = response else { return }
                guard let access = response.access else { return }
                guard let terminal = access.terminal else { return }
                guard let currentTerminals = terminal.terminals else { return }
                for element in currentTerminals{
                    guard let vendor = element.vendor else { continue }
                    guard let vendorName = vendor.name else { continue }
             
                    guard let distributionPoint = element.distributionPoint else { continue }
                    guard let city = distributionPoint.city  else { continue }
                    guard let streetName = distributionPoint.streetName  else { continue }
                    guard let streetNumber = distributionPoint.streetNumber  else { continue }
             
                    let localSearchRequest = MKLocalSearchRequest()
                    localSearchRequest.naturalLanguageQuery = "Россия \(city) \(streetName) \(streetNumber)"
                    let localSearch = MKLocalSearch(request: localSearchRequest)
                    localSearch.start { (localSearchResponse, error) -> Void in
                        guard let response = localSearchResponse else { return }
                        let pointAnnotation = MKPointAnnotation()
                        pointAnnotation.title = vendorName
                        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: response.boundingRegion.center.latitude, longitude: response.boundingRegion.center.longitude)
             
             
                        self.pointArray.append(DistributionPoint(vendorName: vendorName, city: city, streetName: streetName, streetNumber: streetNumber, location: pointAnnotation.coordinate))
             
                        //let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
                       // pinAnnotationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapOnPin(sender:))))
             
                        //self.mapView.centerCoordinate = pointAnnotation.coordinate
                        self.mapView.addAnnotation(pointAnnotation)
                    }
                }
             
             
                self.pageControl.numberOfPages = self.pointArray.count
             
                self.labelName.text = self.pointArray[self.pageControl.currentPage].vendorName
                self.labelAdress.text = self.pointArray[self.pageControl.currentPage].streetName + ", " + self.pointArray[self.pageControl.currentPage].streetNumber
                self.labelTime.text = "10:00 - 18:00"//pointArray[pageControl.currentPage + 1].vendorName
                self.heightForTableView = self.labelName.frame.height + self.labelAdress.frame.height + self.labelTime.frame.height + self.pageControl.frame.height + 50
            }
             self.pageControl.currentPage = 0*/
            
           
        } else {
            guard var point = etalonTerminal?.distributionPoint else { return }
            
            let localSearchRequest = MKLocalSearchRequest()
            localSearchRequest.naturalLanguageQuery = "Россия \(point.city) \(point.streetName) \(point.streetNumber)"
            let localSearch = MKLocalSearch(request: localSearchRequest)
            
            localSearch.start { (localSearchResponse, error) -> Void in
                guard let response = localSearchResponse else { return }
                let pointAnnotation = MKPointAnnotation()
                pointAnnotation.title = point.vendorName
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: response.boundingRegion.center.latitude, longitude: response.boundingRegion.center.longitude)
                point.location = pointAnnotation.coordinate
                
                self.pointArray.append(point)
                self.mapView.addAnnotation(pointAnnotation)
                
                let coordinate = CLLocationCoordinate2D(latitude: response.boundingRegion.center.latitude, longitude: response.boundingRegion.center.longitude)
                self.mapView.centerCoordinate = coordinate
                let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
                self.mapView.setRegion(region, animated: true)
                
                self.pageControl.numberOfPages = self.pointArray.count
                self.pageControl.currentPage = 0
                self.labelName.text = self.pointArray[self.pageControl.currentPage].vendorName
                self.labelAdress.text = self.pointArray[self.pageControl.currentPage].streetName + ", " + self.pointArray[self.pageControl.currentPage].streetNumber
                self.labelTime.text = "10:00 - 18:00"//pointArray[pageControl.currentPage + 1].vendorName
            }
        }
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionForMapView(sender:))))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe))
        swipeLeft.direction = .left
        downView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe))
        swipeRight.direction = .right
        downView.addGestureRecognizer(swipeRight)
        downView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnDownView)))
        
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
    }
    
    
    
    @objc fileprivate func leftSwipe() {
        if pageControl.currentPage < pointArray.count - 1 {
            
            self.pageControl.currentPage += 1
            self.labelName.text = self.pointArray[self.pageControl.currentPage].vendorName
            self.labelAdress.text = self.pointArray[self.pageControl.currentPage].streetName + ", " + self.pointArray[self.pageControl.currentPage].streetNumber
            self.labelTime.text = "10:00 - 18:00"
            self.downView.frame.origin.x += self.downView.frame.width
            heightForTableView = labelName.frame.height + labelAdress.frame.height + labelTime.frame.height + pageControl.frame.height + 20
        }
    }
    @objc fileprivate func rightSwipe() {
        guard pageControl.currentPage > 0 else { return }
        pageControl.currentPage -= 1
        labelName.text = pointArray[pageControl.currentPage].vendorName
        labelAdress.text = pointArray[pageControl.currentPage].streetName + ", " + pointArray[pageControl.currentPage].streetNumber
        labelTime.text = "10:00 - 18:00"
        heightForTableView = labelName.frame.height + labelAdress.frame.height + labelTime.frame.height + pageControl.frame.height + 20
        
    }
    
    @objc fileprivate func tapOnPin(sender: MKPinAnnotationView) {
        guard let location = sender.annotation?.coordinate else { return }
        guard let index = pointArray.index(where: { (point) -> Bool in
            guard let currentLocation = point.location else { return false }
            return currentLocation.latitude == location.latitude && currentLocation.longitude == location.longitude
        }) else { return }
        pageControl.currentPage = index
        labelName.text = pointArray[pageControl.currentPage].vendorName
        labelAdress.text = pointArray[pageControl.currentPage].streetName + ", " + pointArray[pageControl.currentPage].streetNumber
        labelTime.text = "10:00 - 18:00"
        
    }
    
    @objc fileprivate func tapOnDownView() {
        guard let location = pointArray[pageControl.currentPage].location else { return }
        mapView.setCenter(location, animated: true)
    }
    
    @IBAction func actionForShowTableView(_ sender: Any) {
        guard let constraint = downView.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height && constraint.constant == 0
        }) else { return }
        NSLayoutConstraint.deactivate([constraint])
        heightForTableView = labelName.frame.height + labelAdress.frame.height + labelTime.frame.height + pageControl.frame.height + 20
        UIView.animate(withDuration: 1, animations: {
            self.downView.frame.origin.y = self.mapView.frame.height + self.mapView.frame.origin.y - self.heightForTableView
            self.downView.frame.size.height = self.heightForTableView
        }, completion: { (_) in
            self.downView.heightAnchor.constraint(equalToConstant: self.heightForTableView).isActive = true
        })
    }
    
    @objc fileprivate func actionForMapView(sender: Any) {
        guard let constraint = downView.constraints.first(where: { (constraint) -> Bool in
            return constraint.firstAttribute == .height && constraint.constant == heightForTableView
        }) else { return }
        NSLayoutConstraint.deactivate([constraint])
        UIView.animate(withDuration: 1, animations: {
            self.downView.frame.origin.y = self.mapView.frame.origin.y + self.mapView.frame.height
            self.downView.frame.size.height = 0
        }, completion: { (_) in
            self.downView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        })
    }
    
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        default:
           print("location access denied")
        }
    }
}





























