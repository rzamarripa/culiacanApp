//
//  Fetcher.swift
//  Culiacan
//
//  Created by Armando Trujillo on 09/12/14.
//  Copyright (c) 2014 RedRabbit. All rights reserved.
//

import UIKit

let kAppUrl:String = "http://api.culiacan.gob.mx/cabildoabierto/v1/"
let kAppUrlPredial = "http://pagos.culiacan.gob.mx"
//let kAppUrlOnly:String = "http://api.culiacan.gob.mx"

class Fetcher: NSObject {
    
    //MARK: - Cabildo Abierto
    class func callListSesiones() -> NSDictionary {
        let action = "/cabildoabierto/sesiones?limit=1000"
        let appUrlPath = kAppUrl+action
        print(appUrlPath)//Imprimir Url en Consola
        
        let url : NSURL = NSURL(string: appUrlPath)!
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
    
        let response : AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        let error : NSErrorPointer = nil

        var returnData : NSData!
        do {
            returnData =  try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
        } catch let error1 as NSError {
            error.memory = error1
            returnData = nil
        }
        var err : NSError
        
        if returnData != nil {
            let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(returnData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            print(jsonResult)
            return jsonResult
        }
        
        return NSDictionary()
        
    }
    
    class func callListProblematicasBy(action: String) -> NSDictionary{
        let appUrlPath = kAppUrl + action
        print("url lista problematicas : \(appUrlPath)")
        
        let url : NSURL = NSURL(string: appUrlPath)!
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        let response : AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        let error : NSErrorPointer = nil
        
        var returnData : NSData!
        do {
            returnData =  try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
        } catch let error1 as NSError {
            error.memory = error1
            returnData = nil
        }
        var err : NSError
        
        if returnData != nil {
            let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(returnData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            print(jsonResult)
            return jsonResult
        }
        
        return NSDictionary()
        
    }
    
    class func callListAsignacionBy(id_problematicas: Int) -> NSDictionary {
        let action = "/cabildoabierto/asignaciones?id_problematica="
        let appUrlPath = kAppUrl + action + String(id_problematicas)
        print(appUrlPath)
        
        let url : NSURL = NSURL(string: appUrlPath)!
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        let response : AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        let error : NSErrorPointer = nil
        
        var returnData : NSData!
        do {
            returnData =  try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
        } catch let error1 as NSError {
            error.memory = error1
            returnData = nil
        }
        var err : NSError
        
        if returnData != nil {
            let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(returnData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            print(jsonResult)
            return jsonResult
        }
        
        return NSDictionary()
    }

    
    class func callListDepartamentos() -> NSDictionary {
        let action = "/cabildoabierto/departamentos?limit=1000"
        let appUrlPath = kAppUrl+action
        print(appUrlPath)//Imprimir Url en Consola
        
        let url : NSURL = NSURL(string: appUrlPath)!
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        let response : AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        let error : NSErrorPointer = nil
        
        var returnData : NSData!
        do {
            returnData =  try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
        } catch let error1 as NSError {
            error.memory = error1
            returnData = nil
        }
        var err : NSError
        
        if returnData != nil {
            let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(returnData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            print(jsonResult)
            return jsonResult
        }
        
        return NSDictionary()
    }
    
    class func callListComisiones() -> NSDictionary {
        let action = "/cabildoabierto/comisiones?limit=1000"
        let appUrlPath = kAppUrl+action
        print(appUrlPath)//Imprimir Url en Consola
        
        let url : NSURL = NSURL(string: appUrlPath)!
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        let response : AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        let error : NSErrorPointer = nil
        
        var returnData : NSData!
        do {
            returnData =  try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
        } catch let error1 as NSError {
            error.memory = error1
            returnData = nil
        }
        var err : NSError
        
        if returnData != nil {
            let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(returnData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            print(jsonResult)
            return jsonResult
        }
        
        return NSDictionary()
    }
    
    class func getHeightFrom(texto : String, font: UIFont, width: CGFloat) -> CGFloat{
        let labelTexto : UILabel = UILabel(frame: CGRectMake(0, 0, width, 9999))
        //var labelTexto : UILabel = UILabel(frame: CGRectMake(0, 0, 270.0, 9999))
        labelTexto.text = texto
        labelTexto.font = font
        //labelTexto.font = UIFont(name: "Arial", size: 19.0)
        labelTexto.numberOfLines = 0
        labelTexto.sizeToFit()
        return labelTexto.bounds.size.height;
    }
    
    class func alertMensajeNoInternet() -> UIAlertView{
        return UIAlertView(title: "Advertencia", message: "No cuenta con acceso a internet", delegate: nil, cancelButtonTitle: "Aceptar")
    }
    
    //MARK: - Prediale
    class func callPredialBy(num_predial : String) -> NSDictionary {
        let action = "/mipredio/"
        let appUrlPath = kAppUrlPredial + action + num_predial
        print(appUrlPath)
        
        let url : NSURL = NSURL(string: appUrlPath)!
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        let response : AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        let error : NSErrorPointer = nil
        
        var returnData : NSData!
        do {
            returnData =  try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
        } catch let error1 as NSError {
            error.memory = error1
            returnData = nil
        }
        var err : NSError
        
        if returnData != nil {
            if let jsonResult: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(returnData, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary {
                print(jsonResult)
                return jsonResult
            }
        }
        
        return NSDictionary()
    }
    
    class func funcEjemplo(Num: Int){
        print(Num)
    }
}
