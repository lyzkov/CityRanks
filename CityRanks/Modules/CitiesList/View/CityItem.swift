//
//  CityItem.swift
//  CityRanks
//
//  Created by lyzkov on 09/09/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import SwiftUI

struct CityItem: View {
    
    var body: some View {
        HStack(spacing: 8.0) {
            Image(systemName: "shift.fill")
            Text("Hello world!")
            Spacer()
            Text("💛")
        }
    }
    
}

struct CityItem_Previews: PreviewProvider {
    static var previews: some View {
        CityItem()
    }
}
