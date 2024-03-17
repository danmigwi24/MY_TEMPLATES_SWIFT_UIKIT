//
//  UserMapUiKit.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 12/02/2024.
//

import Foundation
import SwiftUI
import MBCore
import MapKit

// Create a UIViewRepresentable view for MapKit
struct MapViewSingleLocationCoordinate: UIViewRepresentable {
    //@Binding
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        //mapView.frame = UIScreen.main.bounds
        // Apply constraints
        //mapView.translatesAutoresizingMaskIntoConstraints = false
        /*
         NSLayoutConstraint.activate([
         mapView.topAnchor.constraint(equalTo: context.coordinator.parent.view.topAnchor),
         mapView.leadingAnchor.constraint(equalTo: context.coordinator.parent.view.leadingAnchor),
         mapView.trailingAnchor.constraint(equalTo: context.coordinator.parent.view.trailingAnchor),
         mapView.bottomAnchor.constraint(equalTo: context.coordinator.parent.view.bottomAnchor)
         ])
         */
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotation = MapMaker()//MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.makerType = "userLocation"
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotation(annotation)
        
        //uiView.setCenter(coordinate, animated: true)
        //
        let region = MKCoordinateRegion( center: coordinate, latitudinalMeters: CLLocationDistance(exactly: 100) ?? 1000, longitudinalMeters: CLLocationDistance(exactly: 100) ?? 1000)
        //let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        uiView.setRegion(uiView.regionThatFits(region), animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: MapViewSingleLocationCoordinate
        
        init(_ parent: MapViewSingleLocationCoordinate) {
            self.parent = parent
        }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Customize the user location annotation
            if let mapmaker = annotation as? MapMaker {
                let userAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
                userAnnotationView.image = UIImage(named: "user_location_maker") // Set your custom image
                return userAnnotationView
            }
            return nil
        }
    }
}




/**
 
 struct UiKitMapView:UIViewRepresentable {
 typealias UIViewType = MKMapView
 
 func makeCoordinator() -> MapViewCoordinator  {
 return MapViewCoordinator()
 }
 
 func makeUIView(context: Context) -> MKMapView {
 let mapView = MKMapView()
 mapView.delegate = context.coordinator
 
 let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.71, longitude: -74), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
 mapView.setRegion(region, animated: true)
 
 
 //NYC
 let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.71, longitude: -74))
 
 //Buston
 let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05))
 
 let request = MKDirections.Request()
 request.source = MKMapItem(placemark: p1)
 request.destination = MKMapItem(placemark: p2)
 request.transportType = .automobile
 
 let direction = MKDirections(request: request)
 direction.calculate { response ,error in
 guard let route = response?.routes.first else {return}
 mapView.addAnnotations([p1,p2])
 mapView.addOverlay(route.polyline)
 mapView.setVisibleMapRect(
 route.polyline.boundingMapRect,
 edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
 animated: true
 )
 }
 return mapView
 }
 
 func updateUIView(_ uiView: MKMapView, context: Context) {
 
 }
 
 
 class MapViewCoordinator : NSObject, MKMapViewDelegate {
 
 func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
 let renderer = MKPolygonRenderer(overlay: overlay)
 renderer.strokeColor = .blue
 renderer.lineWidth = 5
 //return renderer
 return MKOverlayRenderer(overlay: overlay)
 }
 }
 
 }
 
 */


