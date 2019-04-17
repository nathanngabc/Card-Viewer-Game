//
//  CardStorage.swift
//  CardGame
//
//  Created by Nathan Ng on 6/17/18.
//  Copyright © 2018 Brian Broom. All rights reserved.
//

import Foundation

class cardStorage {
    public var front: String;
    public var back: String;
    public var music = "null";
    init(f: String, b: String) {
        front = f
        back = b
    }
    
    init(f: String, b: String, s: String) {
        front = f;
        back = b;
        music = s;
    }
}
