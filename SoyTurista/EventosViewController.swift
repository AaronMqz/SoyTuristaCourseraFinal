//
//  EventosViewController.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 19/01/17.
//  Copyright © 2017 Aaron Marquez. All rights reserved.
//

import UIKit

class EventosViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    var eventos = EventosDO()
    var evento: Eventos?
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 120
        table.rowHeight = UITableViewAutomaticDimension
        eventos.getEventos()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventos.eventos.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdaEvento = Bundle.main.loadNibNamed("EventoViewCell", owner: self, options: nil)?.first as! EventoViewCell
        
        evento = eventos.eventos[indexPath.row]
        celdaEvento.eventoNombre.text =  evento?.evento
        celdaEvento.eventoDescripcion.text =  evento?.descripcion
        celdaEvento.eventoFecha.text =  evento?.fecha
        
        return celdaEvento
    }

}
