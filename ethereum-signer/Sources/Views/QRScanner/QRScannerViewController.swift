//
//  QRScannerViewController.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 17/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import AVFoundation
import UIKit

class QRScannerViewController: UIViewController {
    @IBOutlet var scannerView: UIView!

    var message: String!
    private var contract: QRScannerContract!
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureQRReaderView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }

    private func configureView() {
        configureContract()
        configureNavigationBar()
    }

    private func configureContract() {
        contract = QRScannerViewModel()
    }

    private func configureNavigationBar() {
        title = Constants.Title.qrScanner
    }

    private func configureQRReaderView() {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            unsupportedDevice()
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            unsupportedDevice()
            return
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        scannerView.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }

    private func unsupportedDevice() {
        let alert = UIAlertController(title: "Scanning not supported",
                                      message: "Please use a device with a camera.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        present(alert, animated: true)
        captureSession = nil
    }

    private func found(code: String) {
        print(code)
    }
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from _: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            found(code: stringValue)
        }
    }
}
