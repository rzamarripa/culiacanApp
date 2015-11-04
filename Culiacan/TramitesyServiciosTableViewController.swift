//
//  TramitesyServiciosTableViewController.swift
//  Culiacan
//
//  Created by Roberto Zamarripa on 03/11/15.
//  Copyright © 2015 RedRabbit. All rights reserved.
//

import UIKit

class TramitesyServiciosTableViewController: UITableViewController {
    
    private var arrayTramitesyServicios:NSMutableArray!
    private var traimtesyServiciosSelected:TramiteyServicio!
    
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
    
    func getTramitesyServicios(){
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        let request = congfigRequest("http://transparencia.culiacan.gob.mx/api/dependencia/tamites_y_servicios")
        //var err: NSError?
        print(request)
        let tramites = session.dataTaskWithRequest(request) {
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
                if let items  = result.objectForKey("tramites_y_servicios") as? NSArray {
                    print(items)
                    for item in items {
                        let tramiteyServicio:TramiteyServicio = TramiteyServicio()
                        var hasName = false
                        if let dependencia:String = item.objectForKey("dependencia") as? String{
                            tramiteyServicio.dependencia = dependencia
                        }
                        if let tramite:String = item.objectForKey("tramite") as? String {
                            tramiteyServicio.tramite = tramite
                            hasName = true
                        }
                        if let comprobante_obtener:String = item.objectForKey("comprobante_obtener") as? String {
                            tramiteyServicio.tramite = comprobante_obtener
                            hasName = true
                        }
                        if let tiempo_respuesta:String = item.objectForKey("tiempo_respuesta") as? String {
                            tramiteyServicio.tramite = tiempo_respuesta
                            hasName = true
                        }
                        if let informacion_gral:String = item.objectForKey("informacion_gral") as? String {
                            tramiteyServicio.tramite = informacion_gral
                            hasName = true
                        }
                        if let area_proporciona:String = item.objectForKey("area_proporciona") as? String {
                            tramiteyServicio.tramite = area_proporciona
                            hasName = true
                        }
                        if let nombre_responsable:String = item.objectForKey("nombre_responsable") as? String {
                            tramiteyServicio.tramite = nombre_responsable
                            hasName = true
                        }
                        if let requisitos:String = item.objectForKey("requisitos") as? String {
                            tramiteyServicio.tramite = requisitos
                            hasName = true
                        }
                        if let hora_atencion:String = item.objectForKey("hora_atencion") as? String {
                            tramiteyServicio.tramite = hora_atencion
                            hasName = true
                        }
                        if let telefono:String = item.objectForKey("telefono") as? String {
                            tramiteyServicio.tramite = telefono
                            hasName = true
                        }
                        if let observaciones:String = item.objectForKey("observaciones") as? String {
                            tramiteyServicio.tramite = observaciones
                            hasName = true
                        }
                        if hasName {
                            self.arrayTramitesyServicios.addObject(tramiteyServicio)
                        }
                    }
                    self.tableView.reloadData()
                    self.view.stopLoading()
                }
            }
        }
        tramites.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayTramitesyServicios = []
        
        
        self.view.startLoading("Cargando")
        getTramitesyServicios()
        
        
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayTramitesyServicios.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let tys:TramiteyServicio = arrayTramitesyServicios[indexPath.row] as! TramiteyServicio
        
        cell.textLabel?.text = tys.tramite
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
