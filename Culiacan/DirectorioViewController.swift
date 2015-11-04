//
//  DirectorioViewController.swift
//  Culiacan
//
//  Created by Roberto Zamarripa on 18/08/15.
//  Copyright (c) 2015 RedRabbit. All rights reserved.
//

import UIKit

class DirectorioViewController: UITableViewController {
    private var arrayDirectorio: NSMutableArray!
    private var arrayFuncionarios: NSMutableArray!
    private var dicDirectorio: NSDictionary!
    var filtrados:NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayDirectorio = []
        arrayFuncionarios  = []
        
        self.view.startLoading("Cargando")
       // self.navigationController!.view.startLoading(NSLocalizedString("Saving...", comment:"Saving..."))
        
        

        getFuncionarios()
        getDependencias()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrayDirectorio.count
    }
    
    func congfigRequest(uri:String) -> NSMutableURLRequest {
        let usr = "dsdd"
        let pwdCode = "dsds"
        let params:[String: AnyObject] = [
            "email" : usr,
            "userPwd" : pwdCode ]
        
        let url = NSURL(string:uri)
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
        } catch let error as NSError {
            err = error
            request.HTTPBody = nil
        }
        
        return request
    }
    
    func getFuncionarios(){
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        let request = congfigRequest("http://transparencia.culiacan.gob.mx/api/directorio/funcionarios")
        //var err: NSError?
        
        let funcionarios = session.dataTaskWithRequest(request) {
            data, response, error in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("response was not 200: \(response)")
                    return
                }
            }
            if (error != nil) {
                print("error submitting request: \(error)")
                return
            }
            
            // handle the data of the successful response here
            
            if let result:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary {
                /*
                "foto": "4_17_irma_moreno.jpg",
                "nombre_completo": "C. Irma Guadalupe Moreno Ovalles",
                "correo": "irma.moreno@culiacan.gob.mx",
                "direccion": "Palacio Municipal\nPlanta baja",
                "telefono": "Conmut. 758-01-01 Ext. 1391, 1392 Directo 758-01-19 Directo 715-85-46",
                "puesto": "SÍNDICA PROCURADORA",
                "dependencia": "SÍNDICO PROCURADOR",
                "estado":
                */
                
                if let items  = result.objectForKey("funcionarios") as? NSArray {
                    print(result)
                    for item in items {
                        let funcionario:Funcionario = Funcionario()
                        var hasName = false
                        if let foto:String = item.objectForKey("foto") as? String {
                            funcionario.foto = foto
                        }
                        if let correo:String = item.objectForKey("correo") as? String{
                            funcionario.correo = correo
                        }
                        if let nombre:String = item.objectForKey("nombre_completo") as? String {
                            funcionario.nombre = nombre
                            hasName = true
                        }
                        if let direccion:String = item.objectForKey("direccion") as? String {
                            funcionario.direccion = direccion
                        }
                        if let telefono:String = item.objectForKey("telefono") as? String {
                            funcionario.telefono = telefono
                        }
                        if let puesto:String = item.objectForKey("puesto") as? String {
                            funcionario.puesto = puesto
                        }
                        if let dependencia:String = item.objectForKey("dependencia") as? String {
                            funcionario.dependencia = dependencia
                        }
                        if let estado:String = item.objectForKey("estado") as? String {
                            funcionario.estado = estado
                        }
                        
                        if hasName {
                            self.arrayFuncionarios.addObject(funcionario)
                        }
                    }
                    
                }
                
            }
        }
        funcionarios.resume()
        
    }
    
    func getDependencias() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        let usr = "dsdd"
        let pwdCode = "dsds"
        let params:[String: AnyObject] = [
            "email" : usr,
            "userPwd" : pwdCode ]
        
        let url = NSURL(string:"http://transparencia.culiacan.gob.mx/api/directorio/dependencias")
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
        } catch let error as NSError {
            err = error

            request.HTTPBody = nil
        }
        
        let dependencias = session.dataTaskWithRequest(request) {
            data, response, error in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("response was not 200: \(response)")
                    return
                }
            }
            if (error != nil) {
                print("error submitting request: \(error)")
                return
            }
            
            // handle the data of the successful response here
            
            if let result:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary {
                
                
                if let items  = result.objectForKey("dependencias") as? NSArray {
                   // println(result)
                    for item in items {
                        let dependencia:Dependencia = Dependencia()
                        var hasName = false
                        if let slug:String = item.objectForKey("dependencia_slug") as? String {
                            dependencia.slug = slug
                        }
                        if let dependencia_id:String = item.objectForKey("id_dependencia") as? String{
                                dependencia.dependencia_id = dependencia_id
                        }
                        if let nombre:String = item.objectForKey("nombre_dependencia") as? String {
                            dependencia.nombre = nombre
                            hasName = true
                        }
                        if hasName {
                            self.arrayDirectorio.addObject(dependencia)
                        }
                    }
                    self.tableView.reloadData()
                    self.view.stopLoading()
        
                }
  
             }
        }
        dependencias.resume()
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        
        let dependencia:Dependencia = arrayDirectorio[indexPath.row] as! Dependencia
        
        cell.textLabel?.text = dependencia.nombre

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dependencia = arrayDirectorio[indexPath.row] as! Dependencia
        let nombre = dependencia.nombre
        
        let dependenciaPredicate = NSPredicate(format: "dependencia  = %@", nombre)
//        arrayFuncionarios.filterUsingPredicate(dependenciaPredicate)
        filtrados =  arrayFuncionarios.filteredArrayUsingPredicate(dependenciaPredicate)
        
        
        self.performSegueWithIdentifier("funcionarios_segue", sender: nil)
        
    

       // self.navigationController?.pushViewController(controller, animated: true)
        

        //println(filtrados)
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "funcionarios_segue" {
            let controller:FuncionariosViewController = segue.destinationViewController as! FuncionariosViewController
            controller.arrayFuncionarios = filtrados
        }
    }


}
