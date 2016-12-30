//
//  infoLugarTuristicoController.swift
//  SoyTurista
//
//  Created by Aaron Marquez on 28/12/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit


protocol InfoLugarTuristicoDelegado {
    func LugarTuristicoGuardado(datos: LugarTuristico)
}

class infoLugarTuristicoController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    var objLuagrTuristico: LugarTuristico?
    var delegate: InfoLugarTuristicoDelegado?
    var indexPath:Int?
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var descripcion: UITextField!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var btnGuardar: UIButton!
    @IBOutlet weak var btnCancelar: UIButton!
    @IBOutlet weak var btnFoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    @IBAction func Cancelar(_ sender: Any) {
        ocultarVista()
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
