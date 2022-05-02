//
//  ContentView.swift
//  Sochi
//
//  Created by KIR Q on 2022.04.20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var locations: [Location] = []
    
    @State private var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.43, longitude: -99.13),
        span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
    )
    
    var body: some View {
        //        MapView()
        //            .edgesIgnoringSafeArea(.all)
        Map(coordinateRegion: $coordinateRegion, annotationItems: locations) { Location in
            MapAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            ) {
                VStack {
                    Text(location.name)
                        .font(.caption2)
                        .bold()
                    Image(systemName: "star.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                        .shadow(radius: 1)
                }
            }
        }
            .onAppear(perform: readFile)
    }
    
    private func readFile () {
        if let url = Bundle.main.url(forResource: "locations", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(JSONData.self, from: data) {
                self.locations = jsonData.locations
            }
        }
    }
}

struct JSONData: Decodable {
    let locations: [Location]
}

struct Location: Decodable, Identifiable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
}

//struct MapView: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//
//        //        Add point on the Map
//        let annotation = MKPointAnnotation()
//        annotation.title = "Sochi"
//        annotation.subtitle = "Hometown"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 43, longitude: 43)
//        mapView.addAnnotation(annotation)
//
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        //
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//
//        var parent: MapView
//
//        func mapViewDidChangeVisibleRegion (_ mapView: MKMapView) {
//
//            print(mapView.centerCoordinate)
//
//        }
//
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
//            view.canShowCallout = true
//            return view
//        }
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//    }
//
//}
//

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

