//
//  ContentView.swift
//  Sochi
//
//  Created by KIR Q on 2022.04.20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}


struct MapView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        //        Add point on the Map
        let annotation = MKPointAnnotation()
        annotation.title = "Sochi"
        annotation.subtitle = "Hometown"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 43, longitude: 43)
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: MapView
        
        func mapViewDidChangeVisibleRegion (_ mapView: MKMapView) {
            
            print(mapView.centerCoordinate)
            
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

