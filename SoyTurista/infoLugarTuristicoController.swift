//
//  infoLugarTuristicoController.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 28/12/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit
import CoreLocation

protocol InfoLugarTuristicoDelegado {
    func LugarTuristicoGuardado(datos: LugarTuristico)
}

class infoLugarTuristicoController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, CLLocationManagerDelegate{

    var objLuagrTuristico: LugarTuristico?
    var delegate: InfoLugarTuristicoDelegado?
    var indexPath:Int?
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var descripcion: UITextField!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var btnGuardar: UIButton!
    @IBOutlet weak var btnCancelar: UIButton!
    @IBOutlet weak var btnFoto: UIButton!
    @IBOutlet weak var btnCompartir: UIButton!
     private var manejador: CLLocationManager!
    
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

    
    
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initElementos()
        
        nombre.delegate = self
        descripcion.delegate = self
        
        if objLuagrTuristico != nil{
            nombre.text = objLuagrTuristico?.nombre
            descripcion.text = objLuagrTuristico?.descripcion
            foto.image = objLuagrTuristico?.foto
            
            OcultarElementos()
            soloLectura()
        }
    }
    
    
    
    func initElementos(){
        foto.isHidden = true
        btnCompartir.isHidden = true
        nombre.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        descripcion.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    }

    @IBAction func Cancelar(_ sender: Any) {
        ocultarVista()
    }
    
    @IBAction func compartir(_ sender: Any) {
        let objetosCompartir = [nombre.text!, descripcion.text!]
        let actividadRD = UIActivityViewController(activityItems: objetosCompartir, applicationActivities: nil)
        self.present(actividadRD, animated: true, completion: nil)
    }
    
    @IBAction func Guardar(_ sender: Any) {
        setInfoLugarTuristicoDelegado()
        ocultarVista()
    }
 
    @IBAction func nuevaFoto(_ sender: Any) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)

    }

    func soloLectura(){
        nombre.isEnabled = false
        descripcion.isEnabled = false
        nombre.borderStyle = UITextBorderStyle.none
        descripcion.borderStyle = UITextBorderStyle.none
        nombre.backgroundColor = UIColor.clear
        descripcion.backgroundColor = UIColor.clear
        nombre.textColor = UIColor.white
        descripcion.textColor = UIColor.white
        foto.isHidden = false
        btnCompartir.isHidden = false
        nombre.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
        descripcion.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func OcultarElementos(){
        btnGuardar.isHidden = true
        btnCancelar.isHidden = true
        btnFoto.isHidden = true
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .photoLibrary
        
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            foto.image = image
            foto.isHidden = false
            btnFoto.isHidden = true
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setLugarTuristico() -> LugarTuristico{
        return LugarTuristico(_nombre: nombre.text!,_descripcion: descripcion.text!, _foto: foto.image!)
    }
    
    func setInfoLugarTuristicoDelegado(){
        self.delegate?.LugarTuristicoGuardado(datos: setLugarTuristico())
    }
    
    func ocultarVista(){
         self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        OcularTeclado()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        OcularTeclado()
        return true
    }
    
    func OcularTeclado(){
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
    }

}
