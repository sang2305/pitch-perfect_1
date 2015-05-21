//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Praveen Ramanathan on 5/15/15.
//  Copyright (c) 2015 Sangeetha. All rights reserved.
//

import Foundation

class RecordedAudio{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL,title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
