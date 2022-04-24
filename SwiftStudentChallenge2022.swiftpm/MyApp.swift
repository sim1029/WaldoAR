import SwiftUI

@main
struct MyApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
          .navigationBarTitle("")
          .navigationBarHidden(true)
      }
      .tint(.white)
      .accentColor(.white)
    }
  }
}
