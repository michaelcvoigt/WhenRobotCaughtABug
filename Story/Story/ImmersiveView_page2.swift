//
//  ImmersiveView.swift
//  Story
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView_page2: View {
    @Environment(AppModel.self) var appModel
    
    var body: some View {
        RealityView { content, attachments in
            
            // OPTIONAL: your old scene (probably safe to remove)
                        // if let scene = try? await Entity(named: "Immersive", ...) { content.add(scene) }
                        
            // COVER THE BLACK FLOOR WITH A GIANT SEMI-TRANSPARENT WHITE ONE
            let whiteFloor = ModelEntity(
                mesh: .generatePlane(width: 1000, depth: 1000),
                materials: [UnlitMaterial(color: UIColor.white.withAlphaComponent(0.85))]  // ← 85% opaque
            )

            whiteFloor.position = [0, 0.01, 0]  // just above the black floor
            whiteFloor.orientation = simd_quatf(angle: -.pi/2, axis: [1, 0, 0])  // lay flat
            content.add(whiteFloor)
                       
            // PLACE THE MAIN PAGE — GUARANTEED VISIBLE IN FRONT OF YOUR FACE
            if let quotePanel = attachments.entity(for: "QUOTE_PANEL") {
                // This anchor is attached directly to the user's head/camera
                let headAnchor = AnchorEntity(.head)
                
                // Position it ~1 meter in front, eye level, perfectly centered
                quotePanel.position = [0, 0, -1.5]   // -1.0 meters = clearly visible
                
                headAnchor.addChild(quotePanel)
                content.add(headAnchor)
            }
            
            
            
        } attachments: {
            
            // MARK: - Main Quote Panel (big, centered)
            Attachment(id: "QUOTE_PANEL") {
                VStack(spacing: 0) {
                   

                    Image("whiteBox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 1600, height: 100)
                        .cornerRadius(30)
                    
                    Image("WhenRobotCaughtABug-Page1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 1600, height: 800)
                        .cornerRadius(30)
                    
                    Text("""
                    “Good morning Alex!

                    Remember to take your raincoat and umbrella today… it will be a perfect day for jumping in puddles!”
                    """)
                    .foregroundStyle(.black)
                    .font(.system(size: 40, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(30)
                    
                    .scaledToFit()
                    
                    Spacer()   // ← pushes everything to the top of the panel
                   
                }
                
                .frame(width: 2800, height: 1200)
                .padding(10)
                .frame(maxWidth: 2100)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(color: .black.opacity(0.2), radius: 40, x: 0, y: 20)  // Optional: nice soft shadow
            
                
                // THIS ONE LINE KILLS CONTENTVIEW THE INSTANT IMMERSIVEVIEW APPEARS
                        .onAppear { appModel.immersiveSpaceState = .open }
                        .onDisappear { appModel.immersiveSpaceState = .closed }
                
                
                
                NextPageButton()
                    .padding()
               
                
            }
            
           
            
        }
        
    
    }
    
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
        .environment(AppModel())
    
}

/*
 
 // 3. Place the About panel
 if let aboutPanel = attachments.entity(for: "ABOUT_PANEL") {
     let aboutAnchor = AnchorEntity(world: [1.0, 1.2, -1.8])
     aboutAnchor.addChild(aboutPanel)
     content.add(aboutAnchor)
 }
 
 // MARK: - About the Authors Panel (smaller, readable)
 Attachment(id: "ABOUT_PANEL") {
     VStack(alignment: .leading, spacing: 20) {
         Text("About the Authors")
             .font(.largeTitle)
             .fontWeight(.bold)
         
         Text("""
         Michael Voigt has worked on robots for children, at Anki, Dash and Dot from Wonder Workshop and Kuri the robot from Bosch. After publishing DinoBoy Adventures; a digital interactive children’s book, Michael wanted to publish a physical book about robots, children and how they interact together and the relationship they have in our modern world.

         Aubrey Shick has created socially assistive robots for children and adults, at Carnegie Mellon University, industry startups, and continues robot development as Head of Technology & Research at Fine Art Miracles, Inc. She has also worked on robots for spine surgery. As an aunt of four preschoolers, Aubrey wanted to publish a book that provided an opportunity for families to talk about how robots share information and when to choose what to share with them.
         """)
         .font(.title3)
         .multilineTextAlignment(.leading)
     }
     .padding(50)
     .frame(maxWidth: 900)
     //.background(.ultraThinMaterial)
     
     .clipShape(RoundedRectangle(cornerRadius: 40))
     .shadow(radius: 30)
 */
