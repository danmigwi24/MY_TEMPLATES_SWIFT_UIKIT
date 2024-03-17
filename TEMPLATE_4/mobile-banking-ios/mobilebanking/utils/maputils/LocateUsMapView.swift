//
// LocateUsMapView.swift
//
// Created by Daniel Kimani on 05/12/2023.
//

import Foundation
import MapKit
import CoreLocation
import UIKit
import SwiftUI
import MBCore

// MARK: - HealthCareLocation
struct LocateUsLocation: Codable ,Hashable{
    let id: String?
    let name: String?
    let address: String?
    let telephone: String?
    let services: String?
    let operatingTime: String?
    let type: String?
    let longitude: Double?
    let latitude: Double?
    let isActive: Bool?
    let isSuspended: Bool?
    let countryCode: String?
    // let updatedAt: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case telephone = "telephone"
        case services = "services"
        case operatingTime = "operatingTime"
        case type = "type"
        case longitude = "longitude"
        case latitude = "latitude"
        case isActive = "isActive"
        case isSuspended = "isSuspended"
        case countryCode = "countryCode"
    }
}

let listOfLocateUs: [LocateUsLocation] = [
    LocateUsLocation(
        id: "1",
        name: "Nairobi National Park",
        address: "Langata Road, Nairobi, Kenya",
        telephone: "+254 20 588080",
        services: "Wildlife viewing, picnic areas",
        operatingTime: "Daily 6:00 AM - 6:30 PM",
        type: "ATMS",
        longitude: -1.3748,
        latitude: 36.8455,
        isActive: true,
        isSuspended: false,
        countryCode: "KE"
    ),
    LocateUsLocation(
        id: "2",
        name: "Giraffe Centre",
        address: "Duma Rd, Nairobi, Kenya",
        telephone: "+254 20 8070804",
        services: "Giraffe feeding, conservation education",
        operatingTime: "Daily 9:00 AM - 5:30 PM",
        type: "BRANCH",
        longitude: -1.3682,
        latitude: 36.7699,
        isActive: true,
        isSuspended: false,
        countryCode: "KE"
    ),
    // Add more locations as needed
]

struct LocateUsMapView:UIViewRepresentable {
    
    let region: MKCoordinateRegion
    var userLocation: CLLocationCoordinate2D?
    var lineCoordinatesNames: [LocateUsLocation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        //mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        
        if let userLocation = userLocation {
            let userAnnotation = MapMaker()//MKPointAnnotation()
            userAnnotation.coordinate = userLocation
            userAnnotation.title = "My Location"
            userAnnotation.makerType = "userLocation"
            uiView.addAnnotation(userAnnotation)
        }
        
        for (index, data) in lineCoordinatesNames.enumerated() {
            Logger("INDEX \(index)")
            let coordinate = CLLocationCoordinate2D(latitude: data.latitude ?? 0.0, longitude: data.longitude ?? 0.0)
            
            if isValidCoordinate(coordinate) {
                Logger("ValidCoordinate \(data)",showLog: true)
                let annotation = MapMaker()//MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = data.name ?? ""
                if data.type == "ATMS"{
                    annotation.makerType = "ATMS"
                }else if data.type == "BRANCH"{
                    annotation.makerType = "BRANCH"
                }
                
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
                uiView.setRegion(uiView.regionThatFits(region), animated: false)
                uiView.addAnnotation(annotation)
                
            } else {
                // Handle invalid coordinates (e.g., show an error message, skip them, or take appropriate action)
                Logger("isValidCoordinate \(data)",showLog: true)
            }
        }
    }
    
    func isValidCoordinate(_ coordinate: CLLocationCoordinate2D) -> Bool {
        // Check if a coordinate is valid based on your criteria (e.g., within a specific range)
        // You can define your own criteria for valid coordinates here
        return coordinate.latitude >= -90 && coordinate.latitude <= 90 &&
        coordinate.longitude >= -180 && coordinate.longitude <= 180
    }
    
    
    
    
    func makeCoordinator() -> HealthCareCoordinator {
        HealthCareCoordinator(self)
    }
    
    
    class HealthCareCoordinator: NSObject, MKMapViewDelegate {
        var parent: LocateUsMapView
        
        init(_ parent: LocateUsMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let routePolyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: routePolyline)
                renderer.strokeColor = UIColor.systemBlue
                renderer.lineWidth = 1
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Customize the user location annotation
            
            if let mapmaker = annotation as? MapMaker {
                if mapmaker.makerType == "userLocation"{
                    let userAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
                    userAnnotationView.image = UIImage(named: "user_location_maker") // Set your custom image
                    return userAnnotationView
                } else if mapmaker.makerType == "ATMS"{
                    //let uiImage = UIImage(named: "atmslocateus")
                   
                    // Assuming you have an image named "atmslocateus"
                    if let originalImage = UIImage(named: "atmslocateus") {
                        // Specify the desired size
                        let targetSize = CGSize(width: 55.0, height: 40.0) // Replace with your desired width and height

                        // Resize the image
                        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
                        originalImage.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
                        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()

                        // Now 'resizedImage' contains the UIImage with the desired size
                        // You can use 'resizedImage' in your UI
                        let userAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "ATMS")
                        userAnnotationView.image =  resizedImage// Set your custom image
                        return userAnnotationView
                    }

//                    let userAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "ATMS")
//                    userAnnotationView.image =  uiImage// Set your custom image
//                    return userAnnotationView
                    
                }else{
                   // let uiImage = UIImage(named: "branchlocateus") // Set your custom image
                    
                    // Assuming you have an image named "atmslocateus"
                    if let originalImage = UIImage(named: "branchlocateus") {
                        // Specify the desired size
                        let targetSize = CGSize(width: 55.0, height: 40.0) // Replace with your desired width and height

                        // Resize the image
                        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
                        originalImage.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
                        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()

                        // Now 'resizedImage' contains the UIImage with the desired size
                        // You can use 'resizedImage' in your UI
                        let userAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "BRANCH")
                        userAnnotationView.image =  resizedImage// Set your custom image
                        return userAnnotationView
                    }
                    
//                    let userAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "BRANCH")
//                    userAnnotationView.image = uiImage
//                    return userAnnotationView
                    
                }
            }
            
            return nil
        }
        
        
        
        
    }
    
    
    
}



