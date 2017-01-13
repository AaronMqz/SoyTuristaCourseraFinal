//
//  InterfaceController.swift
//  SoyTuristaWatchKit Extension
//
//  Created by Aaron Marquez on 11/01/17.
//  Copyright © 2017 Aaron Marquez. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var mapa: WKInterfaceMap!
    var wcSession: WCSession!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        wcSession = WCSession.default()
        wcSession.delegate = self
        wcSession.activate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let localizacion = CLLocationCoordinate2D(latitude: message["lat"] as! CLLocationDegrees, longitude: message["lon"] as! CLLocationDegrees)
        let region = MKCoordinateRegion(center: localizacion, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapa.setRegion(region)
        self.mapa.addAnnotation(localizacion, with: .red)

    }
    
}
