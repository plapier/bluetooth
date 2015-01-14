//
//  Device.swift
//  Bluetooth
//
//  Created by Phil LaPier on 1/11/15.
//  Copyright (c) 2015 Phil LaPier. All rights reserved.
//

import Foundation
import CoreBluetooth

class Device: NSObject {
    var nsuuid: NSUUID = NSUUID()
    var uuid = "uuid"
    var name = "name"
    
    init(nsuuid: NSUUID, name: String, uuid: String) {
        self.nsuuid = nsuuid
        self.name = name
        self.uuid = uuid
    }
}
