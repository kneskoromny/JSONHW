//
//  NASAPicture.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//

import Foundation

struct NasaPOD: Decodable {
    
    var copyright: String?
    var date: String?
    var explanation: String?
    var hdurl: String?
    var media_type: String?
    var service_version: String?
    var title: String?
    var url: String?
    
}
