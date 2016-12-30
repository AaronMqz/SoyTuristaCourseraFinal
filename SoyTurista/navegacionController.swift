//
//  navegacionController.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 28/12/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit

class navegacionController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let origen = sender as! QRController
        
        let vc = segue.destination as! QRDetalleViewController
        origen.session?.stopRunning()
        vc._url = origen.url

    }
    

}
