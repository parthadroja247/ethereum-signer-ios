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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startCaptureSession()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scannerView.layoutIfNeeded()
        previewLayer.frame = scannerView.bounds
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCaptureSession()
    }

    private func configureView() {
        configureContract()
        configureNavigationBar()
        configureQRReaderView()
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
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = scannerView.layer.bounds
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
        stopCaptureSession()
        guard let messageData = Data(base64Encoded: code) else {
            signatureInvalid()
            return
        }
        do {
            let customSignature = try JSONDecoder().decode(CustomSignature.self,
                                                           from: messageData)
            let result = contract.verify(message: message, signature: customSignature)
            if result {
                signatureValid()
            } else {
                signatureInvalid()
            }
        } catch {
            signatureInvalid()
        }
    }

    private func startCaptureSession() {
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }

    private func stopCaptureSession() {
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }

    private func signatureInvalid() {
        showAlert(title: Constants.Alert.oops,
                  message: Constants.Alert.invalidSignature)
    }

    private func signatureValid() {
        showAlert(title: Constants.Alert.success,
                  message: Constants.Alert.validSignature)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.Alert.okButton,
                                     style: .default) { _ in
            self.startCaptureSession()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
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
