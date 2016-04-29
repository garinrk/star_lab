//
//  Collision.swift
//  LabryinthMaster
//
//  Created by M on 4/24/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation

struct Collision {
    
    let north: Bool
    let east: Bool
    let south: Bool
    let west: Bool
    
    let coin: Bool
	
    let cellX: Int
    let cellY: Int
 
	let centered: Bool
}