//
//  QRDetalleViewController.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 28/12/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit

class QRDetalleViewController: UIViewController {

    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var webView: UIWebView!
    var _url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _objURL = NSURL(string: _url!)
        
        if _objURL == nil{
            url.text = "El código QR no es valido para una URL"
        }
        else{
            url.text = _url!
            let peticion = NSURLRequest(url: _objURL as! URL)
            webView.loadRequest(peticion as URLRequest)
        }
    }
    
    


}
