//
//  ViewController.swift
//  Bluetooth
//
//  Created by Phil LaPier on 1/4/15.
//  Copyright (c) 2015 Phil LaPier. All rights reserved.
//

import Foundation
import Cocoa
import CoreBluetooth

var CBdelegate = BTLEController()
var isReadyToConnect = false
var selectedDeviceUUID: NSUUID = NSUUID()

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var centralManager = CBCentralManager(delegate: CBdelegate, queue: nil)
    var UUIDs: [String]?
    
    @IBOutlet weak var scanningSpinner: NSProgressIndicator!
    @IBOutlet weak var deviceListTable: NSTableView!
    
    func numberOfRowsInTableView(aTableView: NSTableView!) -> Int {
        var deviceList = CBdelegate.deviceList
        println(deviceList.count)
        if deviceList.count == 0 {
            return 0
        } else {
            return deviceList.count
        }
    }
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        var deviceList = CBdelegate.deviceList
        return deviceList[row].name
    }
    
    @IBAction func startScan(sender: AnyObject) {
        isReadyToConnect = false
        scanningSpinner.startAnimation(self)
        scanningSpinner.hidden = false

        centralManager.scanForPeripheralsWithServices(UUIDs, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
    
    @IBAction func stopScan(sender: AnyObject) {
        centralManager.stopScan()
        scanningSpinner.hidden = true
        scanningSpinner.stopAnimation(self)
        deviceListTable.reloadData()
    }
    
    @IBAction func connectButton(sender: AnyObject) {
        var deviceList = CBdelegate.deviceList
        var row = deviceListTable.selectedRow
        var nsuuid: NSUUID = deviceList[row].nsuuid
        var cbuuid: CBUUID = CBUUID(NSUUID: nsuuid)
        
        isReadyToConnect = true
        selectedDeviceUUID = nsuuid
        
        /*
        var CBdelegateConnect = BTLEController(connectToDevice: nsuuid)
        var centralManager = CBCentralManager(delegate: CBdelegateConnect, queue: nil)
        */
        centralManager.scanForPeripheralsWithServices(UUIDs, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanningSpinner.hidden = true
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

