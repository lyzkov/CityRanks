//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport

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

PlaygroundPage.current.setLiveView(CityItem())
