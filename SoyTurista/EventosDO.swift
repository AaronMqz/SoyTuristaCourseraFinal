//
//  EventosDO.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 19/01/17.
//  Copyright © 2017 Aaron Marquez. All rights reserved.
//

import Foundation

class EventosDO{
    
    var eventos:[Eventos] = []
    
    func getEventos(){
        
        if let path = Bundle.main.path(forResource: "dummy", ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe)
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                
               
                for(_,value) in jsonDictionary{
                    var evento = Eventos()
                    evento.evento = (((value as! [String:Any])["evento1"]) as! [String:Any])["nombre"] as! String
                    evento.descripcion = (((value as! [String:Any])["evento1"]) as! [String:Any])["descripcion"] as! String
                    evento.fecha = (((value as! [String:Any])["evento1"]) as! [String:Any])["fecha"] as! String
                    self.eventos.append(evento)
                    
                    evento = Eventos()
                    evento.evento = (((value as! [String:Any])["evento2"]) as! [String:Any])["nombre"] as! String
                    evento.descripcion = (((value as! [String:Any])["evento2"]) as! [String:Any])["descripcion"] as! String
                    evento.fecha = (((value as! [String:Any])["evento2"]) as! [String:Any])["fecha"] as! String
                    self.eventos.append(evento)
                    
                    evento = Eventos()
                    evento.evento = (((value as! [String:Any])["evento3"]) as! [String:Any])["nombre"] as! String
                    evento.descripcion = (((value as! [String:Any])["evento3"]) as! [String:Any])["descripcion"] as! String
                    evento.fecha = (((value as! [String:Any])["evento3"]) as! [String:Any])["fecha"] as! String
                    self.eventos.append(evento)
                    
                    evento = Eventos()
                    evento.evento = (((value as! [String:Any])["evento4"]) as! [String:Any])["nombre"] as! String
                    evento.descripcion = (((value as! [String:Any])["evento4"]) as! [String:Any])["descripcion"] as! String
                    evento.fecha = (((value as! [String:Any])["evento4"]) as! [String:Any])["fecha"] as! String
                    self.eventos.append(evento)
                    
                    evento = Eventos()
                    evento.evento = (((value as! [String:Any])["evento5"]) as! [String:Any])["nombre"] as! String
                    evento.descripcion = (((value as! [String:Any])["evento5"]) as! [String:Any])["descripcion"] as! String
                    evento.fecha = (((value as! [String:Any])["evento5"]) as! [String:Any])["fecha"] as! String
                    self.eventos.append(evento)
                    
                    evento = Eventos()
                    evento.evento = (((value as! [String:Any])["evento6"]) as! [String:Any])["nombre"] as! String
                    evento.descripcion = (((value as! [String:Any])["evento6"]) as! [String:Any])["descripcion"] as! String
                    evento.fecha = (((value as! [String:Any])["evento6"]) as! [String:Any])["fecha"] as! String
                    self.eventos.append(evento)
                }
                
                
            } catch let err{
                print(err)
            }
        }
    }
    
}
