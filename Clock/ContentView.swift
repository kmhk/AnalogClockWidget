//
//  ContentView.swift
//  Clock
//
//  Created by Quentin Beukelman on 21/01/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fontFamilyModel = ViewModel.shared
    @State private var selectedFontFamily = ViewModel.shared.fontFamilies[0]
    
    @AppStorage("selectedFontFamily", store: UserDefaults(suiteName: "group.Qb.Clock")!) var selectedFontFamilyDefaults: String = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Selected Font: \(selectedFontFamilyDefaults)")
                .font(.custom("Arial", size: 20))
            
            Picker("Font Family", selection: $selectedFontFamily) {
                ForEach(fontFamilyModel.fontFamilies, id: \.self) { fontFamily in
                    Text(fontFamily)
                        .font(.custom(fontFamily, size: 20))
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Button("Save Selection") {
                selectedFontFamilyDefaults = selectedFontFamily
                print("Font: \(selectedFontFamilyDefaults)")
            }
        }
//        .onReceive(timer) { _ in
//            print("hi")
//        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
