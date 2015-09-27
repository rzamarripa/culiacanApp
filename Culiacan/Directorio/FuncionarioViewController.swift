//
//  FuncionarioViewController.swift
//  Culiacan
//
//  Created by Diego Mendoza on 9/26/15.
//  Copyright (c) 2015 RedRabbit. All rights reserved.
//

import UIKit

class FuncionarioViewController: UIViewController {

    @IBOutlet weak var fotoImage: UIImageView!
    @IBOutlet weak var nombreText: UILabel!
    @IBOutlet weak var correoText: UILabel!
    @IBOutlet weak var direccionText: UILabel!
    @IBOutlet weak var telefonoText: UILabel!
    @IBOutlet weak var puestoText: UILabel!
    @IBOutlet weak var dependenciaText: UILabel!
    
    var funcionario:Funcionario!
    let baseUrl = "http://apps.culiacan.gob.mx/transparencia/funcionarios/galeria/"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dependenciaText.text = funcionario.dependencia
        puestoText.text = funcionario.puesto
        nombreText.text = funcionario.nombre
        correoText.text = funcionario.correo
        direccionText.text = funcionario.direccion
        telefonoText.text = funcionario.telefono
        
        fotoImage.contentMode = UIViewContentMode.ScaleAspectFit
        let imageURL = String(format: "%@%@", arguments: [baseUrl,funcionario.foto])
        if let checkedUrl = NSURL(string: imageURL) {
            downloadImage(checkedUrl)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    
    func downloadImage(url:NSURL){
        println("Started downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                println("Finished downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
                self.fotoImage.image = UIImage(data: data!)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
