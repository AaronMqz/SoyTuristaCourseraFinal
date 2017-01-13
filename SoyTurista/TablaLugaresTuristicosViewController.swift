//
//  TablaLugaresTuristicosViewController.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 29/12/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit
import  CoreData

class TablaLugaresTuristicosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var indexPathCell:Int = 0
    private var lugarSeleccionado:LugarTuristico?
    @IBOutlet weak var tabla: UITableView!
    var contextoBD: NSManagedObjectContext? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }    

    override func viewWillAppear(_ animated: Bool) {
        self.tabla.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalLugaresTuristicos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaLugaresTuristicos")!
        
        let obj = globalLugaresTuristicos[indexPath.row]
        cell.textLabel?.text = obj.nombre
        cell.detailTextLabel?.text = obj.descripcion

        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexPathCell = (tableView.indexPathForSelectedRow?.row)!
        
        lugarSeleccionado = globalLugaresTuristicos[indexPathCell]
        performSegue(withIdentifier: "IrDeTablaADetalleLuagresTuristicos", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IrDeTablaADetalleLuagresTuristicos"{
            let vc = segue.destination as! infoLugarTuristicoController
            vc.objLuagrTuristico = lugarSeleccionado
        
        }
    }
    
}
