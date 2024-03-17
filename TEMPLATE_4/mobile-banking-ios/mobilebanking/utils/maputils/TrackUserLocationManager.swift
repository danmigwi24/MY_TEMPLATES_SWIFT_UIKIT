//
//  LocationManager.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 02/02/2024.
//

import Foundation
import MapKit
import MBCore

class TrackUserLocationManager:NSObject,ObservableObject{
    private let manager = CLLocationManager()
    
    @Published var location : CLLocation? = nil
    
    override init() {
        super.init()
        /*
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = kCLDistanceFilterNone
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
        */
        self.startUpdatingLocation()
    }
    
    
    func requestLocation(){
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
            Logger("Show dialog to request authorization ...",showLog: false)
        }else if status == .restricted || status == .denied{
            Logger("Take User to Setting")
            //openSettings()
            CustomAlertDailogWithCancelAndConfirm(
                title: "Info",
                message: "Location access is required for this feature to work, kindly allow permission in settings.",
                secondaryTitle: "Dismiss", primaryText: "Allow",
                secondaryAction: {
                    
                }, primaryAction: {
                    openSettings()
                })
        }else{
            Logger("Location is AUTHOIRZED",showLog: false)
            self.startUpdatingLocation()

        }
    }
    
    func startUpdatingLocation(){
        if manager.delegate == nil {
            manager.delegate = self
        }
        //manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.startUpdatingLocation()
        manager.distanceFilter = 3//Metres
        manager.allowsBackgroundLocationUpdates = false
        manager.pausesLocationUpdatesAutomatically = false
        manager.showsBackgroundLocationIndicator = true
        manager.activityType = .fitness
        manager.startMonitoringSignificantLocationChanges()
        manager.startUpdatingLocation()
        //self.startBackgroundTask()
    }
    
    func stopUpdatingLocation(){
        manager.stopMonitoringSignificantLocationChanges()
        manager.stopUpdatingLocation()
        if manager.delegate != nil {
            manager.delegate = nil
        }
        //self.endBackgroundTask()
    }
    
    
}


extension TrackUserLocationManager:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("TrackUserLocationManager : \(status)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{return}
        self.location = location
    }
}
