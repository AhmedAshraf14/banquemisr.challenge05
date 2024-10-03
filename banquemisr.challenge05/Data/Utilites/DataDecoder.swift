//
//  DataDecoder.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 03/10/2024.
//

import Foundation

class DataDecoder{
    static func parsingData<T: Decodable>(data:Data,model:T.Type)->T?{
        do{
            let decodedData = try JSONDecoder().decode(model.self, from: data)
            return decodedData
        }catch {
            return nil
        }
    }
}
