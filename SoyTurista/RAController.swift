//
//  RAController.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 10/01/17.
//  Copyright © 2017 Aaron Marquez. All rights reserved.
//

import UIKit
import CoreLocation

class RAController: UIViewController, ARDataSource , CLLocationManagerDelegate{

    private var manejador: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

 
    @IBAction func ActivarRA(_ sender: Any) {
        initLocation()
    }

    
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        let vista = TestAnnotationView()
        vista.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        vista.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
        return vista
    }
    
    
    func initLocation(){
        manejador = CLLocationManager()
        manejador.delegate = self
        manejador.desiredAccuracy  = kCLLocationAccuracyBest
        manejador.requestWhenInUseAuthorization()
        manejador.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            manejador.startUpdatingLocation()
            iniciaRA()
        }else{
            manejador.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manejador.location != nil{
            //...
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alerta = UIAlertController(title: "Error", message: "error \(error._code), revisar permiso de ubicación", preferredStyle: .alert)
        let accionOk = UIAlertAction(title: "Ok", style: .default, handler: {
            (accion) in
            //..Se reinician valores

        })
        alerta.addAction(accionOk)
        self.present(alerta, animated: true, completion: nil)
    }
    
    func iniciaRA(){
        let latitud = manejador.location?.coordinate.latitude
        let longitud = manejador.location?.coordinate.longitude
        let delta = 0.05
        let numeroElementos = globalLugaresTuristicos.count
        let puntos = obtenAnotaciones(latitud: latitud!, longitud: longitud!, delta: delta, numeroDeElementos: numeroElementos)
        
        let arViewController = ARViewController()
        arViewController.dataSource = self
        arViewController.maxDistance = 0
        arViewController.maxVisibleAnnotations = 100
        arViewController.maxVerticalLevel = 5
        arViewController.headingSmoothingFactor = 0.05
        arViewController.trackingManager.userDistanceFilter = 25
        arViewController.trackingManager.reloadDistanceFilter = 75
        arViewController.setAnnotations(puntos)
        arViewController.uiOptions.debugEnabled = true
        arViewController.uiOptions.closeButtonEnabled = true
        //arViewController.interfaceOrientationMask = .landscape
        arViewController.onDidFailToFindLocation =
            {
                [weak self, weak arViewController] elapsedSeconds, acquiredLocationBefore in
                // Show alert and dismiss
        }
        self.present(arViewController, animated: true, completion: nil)
        
    
    }
    
    
    private func obtenAnotaciones( latitud: Double, longitud: Double, delta: Double, numeroDeElementos: Int) -> Array<ARAnnotation>{
        
        var anotaciones: [ARAnnotation] = []
        for lugar in globalLugaresTuristicos
        {
            let anotacion = ARAnnotation()
            anotacion.location =  CLLocation(latitude: lugar.latitud as! CLLocationDegrees , longitude: lugar.longitud as! CLLocationDegrees)
            anotacion.title = lugar.nombre
            anotaciones.append(anotacion)
        }
        return anotaciones
        
    }
    
    
}
