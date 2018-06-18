//
//  CameraVC.swift
//  Demo
//
//  Created by Admin on 15.05.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import AVFoundation



class CameraVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var objCaptureSession:AVCaptureSession?
    var objCaptureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
    var vwQRCode:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            guard response else { return }
            DispatchQueue.main.sync{
                self.configureVideoCapture()
                self.addVideoPreviewLayer()
                self.initializeQRView()
            }
        }
    }
    
    func configureVideoCapture() {
        let objCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        let objCaptureDeviceInput: AnyObject!
        do {
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice!) as AVCaptureDeviceInput
        } catch {
            return
        }
        objCaptureSession = AVCaptureSession()
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    }
    
    func addVideoPreviewLayer()
    {
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession!)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        objCaptureVideoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer!)
        objCaptureSession?.startRunning()
        
    }
    func initializeQRView() {
        vwQRCode = UIView()
        vwQRCode?.layer.borderColor = UIColor.red.cgColor
        vwQRCode?.layer.borderWidth = 5
        self.view.addSubview(vwQRCode!)
        self.view.bringSubview(toFront: vwQRCode!)
    }
    
    var search = false
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !metadataObjects.isEmpty else {
            vwQRCode?.frame = CGRect.zero
            return
        }
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        guard objMetadataMachineReadableCodeObject.type == AVMetadataObject.ObjectType.qr else { return }
        let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObject(for: objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
        vwQRCode?.frame = objBarCode.bounds
        guard let resultQR = objMetadataMachineReadableCodeObject.stringValue else { return }
        guard !search else { return }
        search = true
        findEtalon(withQRcode: resultQR, completion: { (etalon) in
            self.performSegue(withIdentifier: "ToEtalonFromCamera", sender: etalon)
        }) { (error) in
            if error {
                self.search = false
            }
        }
        /*let piu = ResolveQRCodeRequestApiModel(text: resultQR)
        VendorDistributionPointsAPI.resolveQRCode(vendorId: 1, id: 56, model: piu) { (response, error) in
            print(response!.etalonId!)
            print(response!.success!)
        }*/
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let etalon = sender as? Etalon else { return }
        guard segue.identifier == "ToEtalonFromCamera" else { return }
        guard let destination = segue.destination as? EtalonVC else { return }
        destination.etalon = etalon
        search = false
    }
}
