//
//  LugarTuristico.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 28/12/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import Foundation
import UIKit


public class  LugarTuristico {
    var nombre: String?
    var foto: UIImage?
    var descripcion: String?
    var latitud: NSObject?
    var longitud: NSObject?
    
    init(_nombre: String, _descripcion: String, _foto: UIImage){
        nombre = _nombre
        foto = _foto
        descripcion = _descripcion
    }
    
    init(){
    }
    
}

var globalLugaresTuristicos = [LugarTuristico]()
