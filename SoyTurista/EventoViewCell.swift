//
//  EventoViewCell.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 19/01/17.
//  Copyright © 2017 Aaron Marquez. All rights reserved.
//

import UIKit

class EventoViewCell: UITableViewCell {

    @IBOutlet weak var eventoNombre: UILabel!
    @IBOutlet weak var eventoDescripcion: UILabel!
    @IBOutlet weak var eventoFecha: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
