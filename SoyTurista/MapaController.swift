//
//  MapaController.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 26/12/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, InfoLugarTuristicoDelegado {


    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var mapa: MKMapView!
    private var origen: MKMapItem!
    private var destino: MKMapItem!
    private var manejador: CLLocationManager!
    private var pin:UIImageView!
    
    //public var lugares: [LugarTuristico]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMapa()
        initLocation()
        globalLugaresTuristicos = []
    }
    
    func initMapa(){
        mapa.delegate = self
    }
    
    func initLocation(){
        manejador = CLLocationManager()
        manejador.delegate = self
        manejador.desiredAccuracy  = kCLLocationAccuracyBest
        manejador.requestWhenInUseAuthorization()
        manejador.startUpdatingLocation()
    }
    
    func ubicarRegionEnMapa(){
        var region:MKCoordinateRegion = MKCoordinateRegion()
        region.span.latitudeDelta = 0.004
        region.span.longitudeDelta = 0.004
        region.center.latitude =  (manejador.location?.coordinate.latitude)!
        region.center.longitude = (manejador.location?.coordinate.longitude)!
        mapa.region = region
    }
    
    
    @IBAction func AgregarPinLugar(_ sender: Any) {
        irGuardarLugarTuristico()
    }
    
    func irGuardarLugarTuristico(){
        performSegue(withIdentifier: "irGuardarLugar", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irGuardarLugar" {
            let lugarTuristico = segue.destination as! infoLugarTuristicoController
            lugarTuristico.delegate = self
        }
    }
    
    
    /* Delegado de infoLugarTuristicoController */
    func LugarTuristicoGuardado(datos: LugarTuristico) {
        
        let point = MKPointAnnotation()
        let point2 = CGPoint(x: pin.center.x, y: pin.center.y + 16)
        let newCoor = mapa.convert(point2, toCoordinateFrom: self.mapa)
        point.coordinate = newCoor
        point.title = direccion.text
        mapa.addAnnotation(point)
        
        let locationItemDestino = CLLocation(latitude: newCoor.latitude, longitude: newCoor.longitude)
        let itemDestino = crearMapItem(ubicacion: locationItemDestino)
        
        datos.latitud = newCoor.latitude as NSObject
        datos.longitud = newCoor.longitude as NSObject
        globalLugaresTuristicos.append(datos)
        
        crearRuta(itemDestino: itemDestino)
    }

    
    func crearMapItem(ubicacion: CLLocation) -> MKMapItem{
        let puntoCoor = CLLocationCoordinate2D(latitude: ubicacion.coordinate.latitude, longitude: ubicacion.coordinate.longitude)
        let puntoLugar = MKPlacemark(coordinate: puntoCoor, addressDictionary: nil)
        let item = MKMapItem(placemark: puntoLugar)
        item.name = "test"
        
        return item
    }
    
    func crearRuta(itemDestino: MKMapItem){
        let itemOrigen = crearMapItem(ubicacion: manejador.location!)
        let solicitud = MKDirectionsRequest()
        solicitud.source = itemOrigen
        solicitud.destination = itemDestino
        solicitud.transportType = .walking
        
        let indicaciones = MKDirections(request: solicitud)
        indicaciones.calculate(completionHandler: {
            (respuesta: MKDirectionsResponse?, error: Error?) in
            if(error != nil){
                print("Error al obtener la ruta")
            }else{
                self.muestraRuta(respuesta: respuesta!)
            }
            
        } )
        
    }
    
    func muestraRuta(respuesta: MKDirectionsResponse){
        for ruta in respuesta.routes{
            mapa.add(ruta.polyline, level: MKOverlayLevel.aboveRoads)
            for paso in ruta.steps{
                print(paso.instructions)
            }
        }

    }
  
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 3
        return renderer
    }
    
    
    func setMainPin(){
        let imagen = UIImage(named: "destinationpin")
        let icon = UIImage(data: UIImagePNGRepresentation(imagen!)!, scale: 4.0)
        pin = UIImageView(image: icon)
        pin.translatesAutoresizingMaskIntoConstraints = false
        let x = NSLayoutConstraint(item: pin, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.mapa, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let y = NSLayoutConstraint(item: pin, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.mapa, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        self.mapa.addSubview(pin)
        NSLayoutConstraint.activate([x,y])
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        

        if pin != nil{
        
            let point2 = CGPoint(x: pin.center.x, y: pin.center.y + 16)
            let newCoor = mapa.convert(point2, toCoordinateFrom: self.mapa)
        
            let location = CLLocation(latitude: newCoor.latitude, longitude: newCoor.longitude)
            reverseGeocodeCoordinate(location: location)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            manejador.startUpdatingLocation()
            mapa.showsUserLocation = true
            ubicarRegionEnMapa()
            setMainPin()
            
        }else{
            manejador.stopUpdatingLocation()
            mapa.showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manejador.location != nil{

        }
    
        //print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alerta = UIAlertController(title: "Error", message: "error \(error._code), revisar permiso de ubicación", preferredStyle: .alert)
        let accionOk = UIAlertAction(title: "Ok", style: .default, handler: {
            (accion) in
            //..Se reinician valores
            if self.manejador.location != nil{
                self.ubicarRegionEnMapa()
            }
            self.direccion.text = "Ubicación no habilitada"
        })
        alerta.addAction(accionOk)
        self.present(alerta, animated: true, completion: nil)
    }
    
    
    func reverseGeocodeCoordinate(location: CLLocation){
        //CLGeocoder.reverseGeocodeLocation(coordinate)
       
        
        var title = ""
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
           
            
            if (error == nil){
                if let p = placemarks?[0]{
                    var subThoroughfare:String = ""
                    var thoroughfare:String = ""
                    
                    if p.subThoroughfare != nil{
                        subThoroughfare = p.subThoroughfare!
                    }
                    if p.thoroughfare != nil{
                        thoroughfare = p.thoroughfare!
                    }
                    title = "\(subThoroughfare) \(thoroughfare)"
                }
            }
            
            if title == "" {
                title = "Added\(NSDate())"
            }
            
            self.direccion.text = title
            //places.append(["name":title,"lat":"\(newCoordinate.latitude)", "lon":"\(newCoordinate.longitude)"])
            //let annotation  = MKPointAnnotation()
            //annotation.coordinate = newCoordinate
            //annotation.title = title
            //self.mapView.addAnnotation(annotation)
            
        })
        //print(title)
        //return title
    }
}
