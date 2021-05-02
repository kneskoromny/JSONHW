//
//  NASAPicture.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//


struct NasaPOD: Decodable {
    
    var copyright: String?
    var date: String?
    var title: String?
    var url: String?
    
    var description: String {
        """
        Насладитесь NASA AstroPhotoOfTheDay \(date ?? "")!
        Оно называется
        "\(title ?? "")".
        Это фото было загружено \(copyright ?? "неизвестным").
        """
    }
}
