//
//  QRController.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 26/12/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit
import AVFoundation

class QRController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    
    var session: AVCaptureSession?
    var capa : AVCaptureVideoPreviewLayer?
    var marcoQR : UIView?
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaConfiguracion()
        iniciaQR()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        session?.startRunning()
        marcoQR?.frame = CGRect.zero
        
    }
    
    func iniciaConfiguracion(){
        self.title = "QR"
    }
    
    func iniciaQR(){
        
        let dispositivo = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let entrada = try AVCaptureDeviceInput(device: dispositivo)
            session = AVCaptureSession()
            session?.addInput(entrada)
            let metaDatos = AVCaptureMetadataOutput()
            session?.addOutput(metaDatos)
            metaDatos.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDatos.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            capa = AVCaptureVideoPreviewLayer(session: session)
            capa?.videoGravity = AVLayerVideoGravityResizeAspectFill
            capa?.frame = view.layer.bounds
            view.layer.addSublayer(capa!)
            
            marcoQR = UIView()
            marcoQR?.layer.borderWidth = 3
            marcoQR?.layer.borderColor = UIColor.red.cgColor
            view.addSubview(marcoQR!)
            session?.startRunning()
        }
        catch{
        
        }
    }

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        marcoQR?.frame = CGRect.zero
        
        if (metadataObjects == nil || metadataObjects.count == 0){
            return
        }
        
        let objMetadato = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if objMetadato.type == AVMetadataObjectTypeQRCode{
            let objBordes = capa?.transformedMetadataObject(for: objMetadato as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            marcoQR?.frame = objBordes.bounds
            if objMetadato.stringValue != nil {
                self.url = objMetadato.stringValue
                let nav = self.navigationController
                nav?.performSegue(withIdentifier: "qrDetalle", sender: self)
                
            }
            
            
        }
        
    }
    

}
