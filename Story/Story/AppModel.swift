import Foundation
import RealityKit
import SwiftUI

@Observable
class AppModel {
    var immersiveSpaceState: ImmersiveSpaceState = .closed
    let immersiveSpaceID = "ImmersiveSpace"
        
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }

}
