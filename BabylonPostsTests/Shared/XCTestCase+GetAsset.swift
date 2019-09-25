//
//  XCTestCase+GetAsset.swift
//  BabylonPostsTests
//
//  Created by Li Linyu on 25/09/2019.
//  Copyright © 2019 Li Linyu. All rights reserved.
//

import XCTest

extension XCTestCase {
    func getAsset<T: Decodable>(from fileName: String, ofType: String) -> T? {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: fileName, ofType: ofType)
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped),
            let json = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return json
    }
}
