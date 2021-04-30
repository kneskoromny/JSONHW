//
//  NASAPicture.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//


struct NasaPOD: Decodable {
    
    var copyright: String?
    var date: String?
    var explanation: String?
    var title: String?
    var url: String?
    
    var description: String {
        """
        AstroPhotoOfTheDay!
        Here you can see \(title ?? "")
        This photo was shooted \(copyright ?? "someone")
        \(date ?? "sometime")
        """
    }
}
