//
//  CityItemList.swift
//  CityRanks
//
//  Created by lyzkov on 09/09/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import SwiftUI
import SwipeCell

struct CityItemList: View {
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<5) { index in
                    NavigationLink(destination: CityDetails()) {
                        CityItem()
                    }
                    .padding(.leading).padding(.trailing)
                    .swipeCell(
                        cellPosition: .right,
                        leftSlot: nil,
                        rightSlot: SwipeCellSlot(
                            slots: [
                                SwipeCellButton(
                                    buttonStyle: .title,
                                    title: "Favorite",
                                    systemImage: nil,
                                    view: nil,
                                    backgroundColor: .orange,
                                    action: { print("Item No. \(index) marked as favorite!") }
                                )
                            ]
                            ,slotStyle: .destructive
                        )
                    )
                }
            }
            .dismissSwipeCell()
            .navigationTitle("Ranking of cities")
        }
    }
    
}

struct CityItemList_Previews: PreviewProvider {
    static var previews: some View {
        CityItemList()
    }
}
