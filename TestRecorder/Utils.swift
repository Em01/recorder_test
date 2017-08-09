//
//  Utils.swift
//  TestRecorder
//
//  Created by Emma Williams on 27/07/2017.
//  Copyright © 2017 Emma Williams. All rights reserved.
//


import Foundation

var appHasMicAccess = false

enum AudioStatus: Int, CustomStringConvertible {
    case stopped = 0,
    playing,
    recording
    
    var audioName: String {
        let audioNames = [
            "Audio: Stopped",
            "Audio:Playing",
            "Audio:Recording"]
        return audioNames[rawValue]
    }
    
    var description: String {
        return audioName
    }
}
