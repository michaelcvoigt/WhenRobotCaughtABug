//
//  ContentView.swift
//  Story
//

import SwiftUI

struct ContentView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        ZStack {
            // This transparent background removes the grey window frame
            Color.clear
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
             

            // Only show ContentView when NOT in immersive space
            if appModel.immersiveSpaceState != .open {
                VStack {
                    Text("An Immersive Story By Michael Voigt")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    Image("Title")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 500)
                        .padding()
                    
                    ToggleImmersiveSpaceButton()
                        .padding()
                    
                    Text("Copyright © 2025")
                        .font(.title3)
                        .foregroundStyle(.black)
                        .padding(.top, 20)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(40)
                //.shadow(radius: 30)
                .transition(.opacity)
               
            }
        }
        // THESE TWO LINES ARE THE MAGIC
        .persistentSystemOverlays(.hidden)     // removes the volume window chrome
        
    }
}

#Preview {
    ContentView()
        .environment(AppModel())
      
}
