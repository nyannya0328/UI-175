//
//  ContentView.swift
//  UI-175
//
//  Created by にゃんにゃん丸 on 2021/05/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            
            SmaliView()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
