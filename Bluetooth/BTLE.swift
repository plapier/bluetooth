//
//  BTLE.swift
//  Bluetooth
//
//  Created by Phil LaPier on 1/11/15.
//  Copyright (c) 2015 Phil LaPier. All rights reserved.
//

import Foundation
import CoreBluetooth

class BTLEController : NSObject, CBCentralManagerDelegate {
    var deviceList: [Device] = [Device]()
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
        switch central.state {
            
        case .PoweredOn:
            println(".PoweredOn")
            
        case .PoweredOff:
            println(".PoweredOff")
            
        case .Resetting:
            println(".Resetting")
            
        case .Unauthorized:
            println(".Unauthorized")
            
        case .Unknown:
            println(".Unknown")
            
        case .Unsupported:
            println(".Unsupported")
        }
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        var targetPeripheral = peripheral
        if isReadyToConnect {
            if peripheral.identifier == selectedDeviceUUID {
                central.stopScan()
                println("ready to connect... \(peripheral.name) --> \(peripheral.state.hashValue)")
                central.connectPeripheral(targetPeripheral!, options: nil)
                println(peripheral)
            }
        }
            
        else {
            if (peripheral.name? != nil) {
                var idString = peripheral.identifier.UUIDString
                var device = Device(nsuuid: peripheral.identifier, name: peripheral.name, uuid: idString)
                println(device.name)
                //println(peripheral, RSSI)

                
                if deviceList.isEmpty {
                    deviceList.append(device)
                }
                else {
                    var isDuplicate = false
                    for device in deviceList {
                        if device.uuid == idString {
                            isDuplicate = true
                        }
                    }
                    if !isDuplicate {
                        deviceList.append(device)
                    }
                }
            }
        }
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        println("Peripheral Connected: \(peripheral)")
    }
    
    func centralManager(central: CBCentralManager!, didDisconnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        println("Disconnected")
    }
    
    func centralManager(central: CBCentralManager!, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        println("Failed to connect: \(error)")
    }
}