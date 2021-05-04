//
//  NASAPicture.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//


struct NasaPOD: Decodable {
    
    let copyright: String?
    let date: String?
    let title: String?
    let url: String?
    
    var description: String {
        """
        Насладитесь NASA AstroPhotoOfTheDay \(date ?? "")!
        Оно называется
        "\(title ?? "")".
        Это фото было загружено \(copyright ?? "неизвестным").
        """
    }
}
